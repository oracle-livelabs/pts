# Designing Agentic Workflows with MCP: Architecture and Code Walkthrough

### Introduction

This workshop leverages the Model Context Protocol (MCP) to demonstrate how to build a powerful AI agent capable of dynamic tool interaction, context management, and robust task execution. Through this LiveLab, you will learn to integrate Oracle GenAI and other services within an MCP-driven architecture to enable your agent to perform complex tasks such as searching documents, generating PDFs, and handling email-related operations. In this lab, you will perform the following tasks:

1. Setting up the MCP-compatible environment and dependencies.
2. Setting Up an MCP Server to Isolate Tools for Secure Agent Execution
3. Designing effective prompt templates that leverage MCP context
4. Initializing and running your MCP-enabled agent

Let's get started!

## **Task 1: Environment Setup and Imports**

### Launch Jupyter Lab Notebook

1. From the Activities menu, open a terminal window if it is not already opened.

 ![Open terminal](images/browser.png)

2. From the terminal OS prompt type the following to launch jupyter notebook:

    ```
        $ cd /home/oracle/aidemo/oracle-mcp-agent
        $ jupyter lab
    ```

3. Open the notebook **GenAI\_Agent.ipynb**. You can double click or right-click and select **Open**.
   
    ![Open AI Agentics notebook using Jupyter lab](images/jupyter_notebook.png)

4.  **GenAI\_Agent.ipynb**.

    ![Open AI Agentics notebook using Jupyter lab](images/open_jupyter_notebook.png)

    If you want to enlarge the window and have larger fonts, you can zoom in with the browser.

    ![Zoom in](images/zoom.png)


### **Imports and Configuration**

Import Oracle LangChain from langchain_community, along with MCP and LangGraph for agent creation, plus libraries for PDF generation and standard utilities.

We are using OracleDB Python Drivers to connect to Oracle database and not cx\_oracle driver, as only the latest driver supports the new feature like Vector Data type. 

To import all the required libararies, run the below code.  

```Python

import os
import io
import re
import json
import traceback
from typing import Union, Dict, List

# Third-party imports
import oracledb
import pandas as pd
from dotenv import load_dotenv

# MCP Imports 
from mcp.server.fastmcp import FastMCP
from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client
from langchain_mcp_adapters.tools import load_mcp_tools

# LangGraph import
from langgraph.prebuilt import create_react_agent

# LangChain imports
from langchain.memory import ConversationBufferMemory
from langchain.schema import HumanMessage, AIMessage
from langchain_core.prompts import PromptTemplate
from langchain.agents import Tool, create_react_agent, AgentExecutor
from langchain_community.chat_models import ChatOCIGenAI
from langchain_community.embeddings import HuggingFaceEmbeddings
from langchain_community.vectorstores import OracleVS
from langchain_community.vectorstores.utils import DistanceStrategy

# PDF generation
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.units import inch

# From sql magic
# loads the SQL magic extensions

#from prettytable import DEFAULT, MARKDOWN, MSWORD_FRIENDLY, ORGMODE, PLAIN_COLUMNS, RANDOM,  SINGLE_BORDER, DOUBLE_BORDER, FRAME, NONE
#from prettytable import  TableStyle,PLAIN_COLUMNS
%load_ext sql
%config SqlMagic.autopandas = True
%config SqlMagic.style = 'PLAIN_COLUMNS'  # 
%sql oracle+oracledb://vector:vector@localhost:1521?service_name=ORCLPDB1

# Load environment variables
load_dotenv()

# For visualization in the notebook
import matplotlib.pyplot as plt
from IPython.display import display, Image, FileLink, Markdown

# Set the figure size for plots
plt.rcParams["figure.figsize"] = (10, 6)

```
## Task 2: Setting up the MCP Server

This task guides you through setting up the Model Context Protocol (MCP) server, which is the central component responsible for exposing tools to your AI agents in a standardized and secure manner. The MCP server acts as a crucial intermediary, allowing your agents to discover and invoke functionalities without needing direct knowledge of their underlying implementations.

### Create MCP Server File (server.py)

We will define our MCP tools within a Python file named `server.py`. The `FastMCP` class from the MCP library is used to instantiate the server and register our tools. Each tool is defined as a Python function decorated with `@mcp.tool()`, making it discoverable and callable by MCP-compliant agents.

Here’s the `server.py` code:

```python
mcp = FastMCP("AgentAssitant")


@mcp.tool()
def fetch_recipients(query: str) -> str:
    Search for recipients by name and return formatted results.
    try:
        # Clean the query
        cleaned_query = query.strip()
        while cleaned_query.endswith('O'): cleaned_query = cleaned_query[:-1]

        # Use the existing connection
        cursor = connection.cursor()

        # Parse search terms and build query
        search_terms = cleaned_query.split()
        base_query = "SELECT first_name, last_name, email FROM recipients WHERE 1=0"
        conditions, params = [], []

        for term in search_terms:
            conditions.extend(["LOWER(first_name) LIKE LOWER(:term)||'%'", "LOWER(last_name) LIKE LOWER(:term)||'%'"])
            params.extend([term, term])

        query = base_query.replace("1=0", " OR ".join(conditions))
        cursor.execute(query, params)
        recipients = cursor.fetchall()
        cursor.close()

        # Format results
        if not recipients: return f"No recipients found matching '{cleaned_query}'."

        formatted_results = [f"{first_name} {last_name} ({email})" for first_name, last_name, email in recipients]
        if len(recipients) == 1:
            first_name, last_name, email = recipients[0]
            return f"{first_name} {last_name} ({email})\n\nSuggested recipient: {email}"

        return "\n".join(formatted_results) + "\n\nMultiple recipients found. Using the first email address: " + recipients[0][2]

    except Exception as e:
        return f"Error finding email addresses: {str(e)}" 

@mcp.tool()
def oracle_connect() -> str:
    """
    Checks and returns Oracle DB connection status.
    """
    try:
        db_ops = DatabaseOperations()
        if db_ops.connect():
            print("Oracle connection successful!")
            return "Oracle DB is reachable."
        return None
    except Exception as e:
        print(f"Oracle connection failed: {str(e)}")
        return None    

@mcp.tool()
def extract_email_fields_from_response(response_text: str) -> dict:
    """
    Parses a draft email message and extracts structured fields including recipient (To), subject, and body text.

    This tool is useful when the AI assistant generates an email draft and you want to extract its components to populate an email form.

    Input:
    - response_text: AI-generated email draft (e.g., "To: someone@example.com\nSubject: ...\nMessage: ...")

    Output:
    - A dictionary with keys: "to", "subject", "message"
    """
    try:
        return extract_email_data_from_response(response_text)
    except Exception as e:
        return {"error": f"Failed to extract email data: {str(e)}"}


@mcp.tool()
def prepare_and_send_email(email_data: dict) -> dict:
    """
    Sends an email using the given dictionary with keys: to, subject, and message.
    """
    try:
        to = email_data["to"]
        subject = email_data["subject"]
        message = email_data["message"]

        # Example sending logic (replace with real SMTP or email API logic)
        print(f"Sending email:\nTo: {to}\nSubject: {subject}\nMessage:\n{message}")
        
        # Actual email logic (ensure this is correct)
        return send_email_function({"to": to, "subject": subject, "message": message})
    
    except Exception as e:
        return {"error": f"Failed to send email: {str(e)}"}




@mcp.tool()
def store_text_chunks(file_path: str) -> str:
    """Split text and store as embeddings in Oracle Vector Store"""
    try:
        db_ops = DatabaseOperations()
        
        if not db_ops.connect():
            return "Oracle connection failed."

        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            raw_text = f.read()

            text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
            chunks = text_splitter.split_text(raw_text)
            file_name = os.path.basename(file_path)
            docs = [
                chunks_to_docs_wrapper({\'id\': f"{file_name}_{i}", \'link\': f"{file_name} - Chunk {i}", \'text\': chunk})
                for i, chunk in enumerate(chunks)
            ]


            embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
            OracleVS.from_documents(
                docs, embeddings, client=db_ops.connection,
                table_name="MY_DEMO4", distance_strategy=DistanceStrategy.COSINE)
            
            return f"Stored {len(docs)} chunks from {file_name}"

    except Exception as e:
        return f"Error: {str(e)}"

@mcp.tool()
def rag_search(query: str) -> str:
    """
    Retrieve relevant information from user-uploaded documents stored in the Oracle Vector Store.

    Use this tool whenever a user asks a question that may be answered from the uploaded documents
    (e.g., HR policy files, contracts, technical manuals, PDF uploads, etc.).

    The tool performs a semantic similarity search over the embedded document chunks and returns
    the top 5 most relevant text snippets.

    Input:
    - A natural language question or topic from the user.

    Output:
    - A formatted string combining the most relevant document excerpts.

    Examples:
    - "What is the leave policy for new employees?"
    - "Summarize the refund terms in the uploaded contract"
    - "Find safety precautions mentioned in the manual"
    """
    try:
        # Load vector store (or access from persistent source if needed)
        vector_store = get_vector_store()
        if vector_store is None:
            return "No documents have been indexed yet."

        docs = vector_store.similarity_search(query, k=5)
        return "\n".join([doc.page_content for doc in docs])
    except Exception as e:
        return f"Error during document search: {str(e)}"


@mcp.tool()
def create_pdf_tool(input_data: Union[str, Dict]) -> str:
    """    
    Create a PDF from email content or general information.
    Input should be a JSON with "title", "content", and optionally "filename".
    For emails, content should contain "to", "subject", and "message" fields.
    
    try:
        # Parse input if it's a string
        if isinstance(input_data, str):
            try:
                data = json.loads(input_data)
            except json.JSONDecodeError:
                # If parsing fails, treat it as content
                data = {
                    "title": "Generated Content",
                    "content": input_data,
                    "filename": "generated_document.pdf"
                }
        else:
            data = input_data

        # Use default filename if not provided
        title = data.get("title", "Generated Content")
        filename = data.get("filename")

        if not filename:
           if title.lower() == "email" and isinstance(data.get("content"), dict):
               to_name = re.sub(r"[^\w\s]", "", data["content"].get("to", "recipient")).strip().replace(" ", "_")
               from_match = re.search(r"Best regards,\s*(\w+(?:_\w+)*)", data["content"].get("message", ""), re.IGNORECASE)
               from_name = from_match.group(1) if from_match else "me"
               filename = f"Email_to_{to_name}_from_{from_name}.pdf"
           else:
               # Fallback for general documents
               safe_title = re.sub(r"[^\w\s-]", "", title).strip().replace(" ", "_")
               filename = f"{safe_title}.pdf"


        # Check if content is an email (has to, subject, message)
        is_email_format = False
        if isinstance(data["content"], dict):
            if all(k in data["content"] for k in ["to", "subject", "message"]):
                is_email_format = True

        if is_email_format:
            # Create email PDF
            result = generate_email_pdf(data["content"], filename)
        else:
            # Create general content PDF
            buffer = io.BytesIO()
            pdf = SimpleDocTemplate(buffer, pagesize=letter)
            styles = getSampleStyleSheet()
            elements = [
                Paragraph(data["title"], styles['Title']),
                Spacer(1, 0.2 * inch)
            ]

            # Convert string content to paragraphs
            if isinstance(data["content"], str):
                paragraphs = data["content"].split('\n\n')  # Split on double newlines
                for para in paragraphs:
                    if para.strip():
                        elements.append(Paragraph(para.replace('\n', '
'), styles['Normal']))
                        elements.append(Spacer(1, 0.1 * inch))
            elif isinstance(data["content"], list):
                for item in data["content"]:
                    elements.append(Paragraph(str(item).replace('\n', '
'), styles['Normal']))
                    elements.append(Spacer(1, 0.1 * inch))

            pdf.build(elements)
            buffer.seek(0)
            with open(filename, "wb") as f:
                f.write(buffer.getvalue())
            result = f"PDF generated and saved as {filename}"

        return result
    except Exception as e:
        traceback.print_exc()
        return f"Error creating PDF: {str(e)}"  

def generate_email_pdf(email_data, filename="email.pdf"):
    Generate a PDF from email data.
    buffer = io.BytesIO()
    pdf = SimpleDocTemplate(buffer, pagesize=letter)
    styles = getSampleStyleSheet()

    elements = [
        Paragraph("Email", styles['Title']),
        Spacer(1, 0.2 * inch),
        Paragraph(f"To: {email_data['to']}", styles['Normal']),
        Paragraph(f"Subject: {email_data['subject']}", styles['Normal']),
        Spacer(1, 0.2 * inch),
        Paragraph("Message:", styles['Normal']),
        Spacer(1, 0.1 * inch)
    ]

    message_paragraphs = email_data['message'].split('\n\n')
    for para in message_paragraphs:
        if para.strip():
            elements.append(Paragraph(para.replace('\n', '
'), styles['Normal']))
            elements.append(Spacer(1, 0.1 * inch))

    pdf.build(elements)
    buffer.seek(0)

    with open(filename, "wb") as f:
        f.write(buffer.getvalue())

    return f"Email PDF generated and saved as {filename}"

if __name__ == "__main__":
    print(" Starting MCP Agentic Server ...")
    mcp.run(transport="stdio")
```

### Run MCP Server

To start the MCP server, execute the following command in your terminal:

````
<copy>
python server.py
</copy>
````

This command will launch the MCP server, making the registered tools available for discovery and invocation by your AI agents.

## Task 3: Reviewing MCP Tools

This task delves into the specific tools that our AI agent will utilize, all of which are exposed via the MCP server. These tools are registered with the MCP server and can be dynamically discovered and invoked by MCP-compliant agents to perform specialized actions like RAG search, recipient lookup, email processing, and PDF generation.

### Tool 1: `rag_search` (MCP Tool)

The `rag_search` tool is exposed via the MCP server and is designed to retrieve relevant information from a vector store. It takes a user query and performs a similarity search, returning the most relevant document chunks. This is crucial for Retrieval-Augmented Generation (RAG) applications, where the agent needs to access external knowledge bases through the MCP framework.

```python
@mcp.tool()
def rag_search(query: str) -> str:
    """
    Retrieve relevant information from user-uploaded documents stored in the Oracle Vector Store.

    Use this tool whenever a user asks a question that may be answered from the uploaded documents
    (e.g., HR policy files, contracts, technical manuals, PDF uploads, etc.).

    The tool performs a semantic similarity search over the embedded document chunks and returns
    the top 5 most relevant text snippets.

    Input:
    - A natural language question or topic from the user.

    Output:
    - A formatted string combining the most relevant document excerpts.

    Examples:
    - "What is the leave policy for new employees?"
    - "Summarize the refund terms in the uploaded contract"
    - "Find safety precautions mentioned in the manual"
    """
    try:
        # Load vector store (or access from persistent source if needed)
        vector_store = get_vector_store()
        if vector_store is None:
            return "No documents have been indexed yet."

        docs = vector_store.similarity_search(query, k=5)
        return "\n".join([doc.page_content for doc in docs])
    except Exception as e:
        return f"Error during document search: {str(e)}"
```

**Parameters:**
*   `query`: The user\'s input query for the RAG search.
*   `k=5`: Specifies the number of top `k` chunks to be sent to the LLM for generating an answer. This can be adjusted as needed.
*   `content`: This variable will hold the result set of the similarity search and is returned as the function\'s output.

**Sample Input/Output:**
*   **Input:** A question about a document for a RAG search.
*   **Output:** The top 5 most relevant text chunks that have the most relevant answers for the question.

### Tool 2: `lookup_recipients` (MCP Tool)

The `lookup_recipients` tool is exposed via the MCP server and queries a database table to retrieve email IDs based on a person\'s first or last name. This enables the agent to dynamically find contact information for email-related tasks through the MCP framework.

```python
@mcp.tool()
def fetch_recipients(query: str) -> str:
    Search for recipients by name and return formatted results.
    try:
        # Clean the query
        cleaned_query = query.strip()
        while cleaned_query.endswith('O'): cleaned_query = cleaned_query[:-1]

        # Use the existing connection
        cursor = connection.cursor()

        # Parse search terms and build query
        search_terms = cleaned_query.split()
        base_query = "SELECT first_name, last_name, email FROM recipients WHERE 1=0"
        conditions, params = [], []

        for term in search_terms:
            conditions.extend(["LOWER(first_name) LIKE LOWER(:term)||'%'", "LOWER(last_name) LIKE LOWER(:term)||'%'"])
            params.extend([term, term])

        query = base_query.replace("1=0", " OR ".join(conditions))
        cursor.execute(query, params)
        recipients = cursor.fetchall()
        cursor.close()

        # Format results
        if not recipients: return f"No recipients found matching '{cleaned_query}'."

        formatted_results = [f"{first_name} {last_name} ({email})" for first_name, last_name, email in recipients]
        if len(recipients) == 1:
            first_name, last_name, email = recipients[0]
            return f"{first_name} {last_name} ({email})\n\nSuggested recipient: {email}"

        return "\n".join(formatted_results) + "\n\nMultiple recipients found. Using the first email address: " + recipients[0][2]

    except Exception as e:
        return f"Error finding email addresses: {str(e)}"
```

**Parameters:**
*   **Input:** First Name or Last Name from the chat conversation.
*   **Output:** The email ID associated with the name.

### Tool 3: `prepare_and_send_email` and `extract_email_fields_from_response` (MCP Tools)

The `prepare_and_send_email` and `extract_email_fields_from_response` tools are exposed via the MCP server to handle email processing. `extract_email_fields_from_response` parses email drafts, and `prepare_and_send_email` sends emails using the extracted data. These tools enable the agent to manage email-related functionalities through the MCP framework.

```python
@mcp.tool()
def extract_email_fields_from_response(response_text: str) -> dict:
    """
    Parses a draft email message and extracts structured fields including recipient (To), subject, and body text.

    This tool is useful when the AI assistant generates an email draft and you want to extract its components to populate an email form.

    Input:
    - response_text: AI-generated email draft (e.g., "To: someone@example.com\nSubject: ...\nMessage: ...")

    Output:
    - A dictionary with keys: "to", "subject", "message"
    """
    try:
        return extract_email_data_from_response(response_text)
    except Exception as e:
        return {"error": f"Failed to extract email data: {str(e)}"}


@mcp.tool()
def prepare_and_send_email(email_data: dict) -> dict:
    """
    Sends an email using the given dictionary with keys: to, subject, and message.
    """
    try:
        to = email_data["to"]
        subject = email_data["subject"]
        message = email_data["message"]

        # Example sending logic (replace with real SMTP or email API logic)
        print(f"Sending email:\nTo: {to}\nSubject: {subject}\nMessage:\n{message}")
        
        # Actual email logic (ensure this is correct)
        return send_email_function({"to": to, "subject": subject, "message": message})
    
    except Exception as e:
        return {"error": f"Failed to send email: {str(e)}"}
```

**Parameters for `extract_email_fields_from_response`:**
*   **Input:** AI-generated email draft (e.g., "To: someone@example.com\nSubject: ...\nMessage: ...")
*   **Output:** A dictionary with keys: "to", "subject", "message"

**Parameters for `prepare_and_send_email`:**
*   **Input:** A dictionary with keys: "to", "subject", and "message"
*   **Output:** A dictionary indicating success or failure of email sending.


### Tool 4: `PDF Creation` (MCP Tool)

Using Python libraries (reportlab) to generate PDF files

```python
@mcp.tool()
def create_pdf_tool(input_data: Union[str, Dict]) -> str:
    """    
    Create a PDF from email content or general information.
    Input should be a JSON with "title", "content", and optionally "filename".
    For emails, content should contain "to", "subject", and "message" fields.
    
    try:
        # Parse input if it's a string
        if isinstance(input_data, str):
            try:
                data = json.loads(input_data)
            except json.JSONDecodeError:
                # If parsing fails, treat it as content
                data = {
                    "title": "Generated Content",
                    "content": input_data,
                    "filename": "generated_document.pdf"
                }
        else:
            data = input_data

        # Use default filename if not provided
        title = data.get("title", "Generated Content")
        filename = data.get("filename")

        if not filename:
           if title.lower() == "email" and isinstance(data.get("content"), dict):
               to_name = re.sub(r"[^\w\s]", "", data["content"].get("to", "recipient")).strip().replace(" ", "_")
               from_match = re.search(r"Best regards,\s*(\w+(?:_\w+)*)", data["content"].get("message", ""), re.IGNORECASE)
               from_name = from_match.group(1) if from_match else "me"
               filename = f"Email_to_{to_name}_from_{from_name}.pdf"
           else:
               # Fallback for general documents
               safe_title = re.sub(r"[^\w\s-]", "", title).strip().replace(" ", "_")
               filename = f"{safe_title}.pdf"


        # Check if content is an email (has to, subject, message)
        is_email_format = False
        if isinstance(data["content"], dict):
            if all(k in data["content"] for k in ["to", "subject", "message"]):
                is_email_format = True

        if is_email_format:
            # Create email PDF
            result = generate_email_pdf(data["content"], filename)
        else:
            # Create general content PDF
            buffer = io.BytesIO()
            pdf = SimpleDocTemplate(buffer, pagesize=letter)
            styles = getSampleStyleSheet()
            elements = [
                Paragraph(data["title"], styles['Title']),
                Spacer(1, 0.2 * inch)
            ]

            # Convert string content to paragraphs
            if isinstance(data["content"], str):
                paragraphs = data["content"].split('\n\n')  # Split on double newlines
                for para in paragraphs:
                    if para.strip():
                        elements.append(Paragraph(para.replace('\n', '
'), styles['Normal']))
                        elements.append(Spacer(1, 0.1 * inch))
            elif isinstance(data["content"], list):
                for item in data["content"]:
                    elements.append(Paragraph(str(item).replace('\n', '
'), styles['Normal']))
                    elements.append(Spacer(1, 0.1 * inch))

            pdf.build(elements)
            buffer.seek(0)
            with open(filename, "wb") as f:
                f.write(buffer.getvalue())
            result = f"PDF generated and saved as {filename}"

        return result
    except Exception as e:
        traceback.print_exc()
        return f"Error creating PDF: {str(e)}"  

def generate_email_pdf(email_data, filename="email.pdf"):
    Generate a PDF from email data.
    buffer = io.BytesIO()
    pdf = SimpleDocTemplate(buffer, pagesize=letter)
    styles = getSampleStyleSheet()

    elements = [
        Paragraph("Email", styles['Title']),
        Spacer(1, 0.2 * inch),
        Paragraph(f"To: {email_data['to']}", styles['Normal']),
        Paragraph(f"Subject: {email_data['subject']}", styles['Normal']),
        Spacer(1, 0.2 * inch),
        Paragraph("Message:", styles['Normal']),
        Spacer(1, 0.1 * inch)
    ]

    message_paragraphs = email_data['message'].split('\n\n')
    for para in message_paragraphs:
        if para.strip():
            elements.append(Paragraph(para.replace('\n', '
'), styles['Normal']))
            elements.append(Spacer(1, 0.1 * inch))

    pdf.build(elements)
    buffer.seek(0)

    with open(filename, "wb") as f:
        f.write(buffer.getvalue())

    return f"Email PDF generated and saved as {filename}"
```

**Parameters:**
*   **Input:** Well formed JSON document. which either has title and text, or To, subject and body.
*   **Output:** A PDF file is created in the current directory.

---

## Task 4: Database and Vector Store Setup (MCP Perspective)

This task focuses on configuring the Oracle Database and setting up the Vector Store, which are essential for providing your AI agents with access to persistent data and advanced search capabilities through the MCP server. The setup described here directly supports the MCP tools that interact with the database.

### Oracle Database Connection

Establishing a secure connection to your Oracle Database is the first step. We will connect using database credentials typically stored as environment variables for security best practices (e.g., in a `.env` file on Linux). This ensures that your MCP tools can interact with the database to fetch or store information as needed.

```python
@mcp.tool()
def create_db_connection():
    """Create and return a database connection using environment variables."""
    return oracledb.connect(
        user=os.getenv("ORACLE_USER"),
        password=os.getenv("ORACLE_PASSWORD"),
        dsn=os.getenv("ORACLE_DSN")
    )

print(os.getenv("ORACLE_DSN"))

# Initialize connection
connection = create_db_connection()

print("Database connection established")

```

### Vector Store Setup

Vector search is a powerful technique that allows AI agents to find semantically similar data (e.g., text, images, or audio) by comparing their numerical vector representations, moving beyond traditional keyword matching. Oracle Vector Store leverages Oracle\`s robust database capabilities for efficient similarity search, making it an ideal backend for RAG (Retrieval-Augmented Generation) tools exposed via MCP.

For this workshop, the **Oracle Table AGENTICS_AI is already loaded with data from the file "Oracle 23ai New features"**. This pre-loaded data will be used by the `rag_search` MCP tool to retrieve relevant information. The `rag_search` tool will perform a vector search, retrieve top N text chunks, and send them along with the user\`s question to the LLM to generate a human-readable answer.

The embedding model we are using is `all-MiniLM-L6-v2`. This model has been downloaded as an ONNX file and is already loaded in the database, ensuring efficient local processing.

**Note:** To learn more about creating embeddings in the database, refer to the LiveLab: [AI Vector Search - 7 Easy Steps to Building a RAG Application using LangChain](https://apexapps.oracle.com/pls/apex/f?p=133:180:6805094326698::::wid:3927).

Run the below code to initialize the Oracle Vector Store:

```python
@mcp.tool()
def store_text_chunks(file_path: str) -> str:
    """Split text and store as embeddings in Oracle Vector Store"""
    try:
        db_ops = DatabaseOperations()

        if not db_ops.connect():
            return "Oracle connection failed."

        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            raw_text = f.read()

            text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)
            chunks = text_splitter.split_text(raw_text)
            file_name = os.path.basename(file_path)
            docs = [
                chunks_to_docs_wrapper({\'id\': f"{file_name}_{i}", \'link\': f"{file_name} - Chunk {i}", \'text\': chunk})
                for i, chunk in enumerate(chunks)
            ]


            embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
            OracleVS.from_documents(
                docs, embeddings, client=db_ops.connection,
                table_name="MY_DEMO4", distance_strategy=DistanceStrategy.COSINE)

            return f"Stored {len(docs)} chunks from {file_name}"

    except Exception as e:
        return f"Error: {str(e)}"
```
**Note:** We are using the embedding model cached locally on disk.

### Verify the Vector Store Table

To explore the vector store we created, run the SQL query to select the first 5 rows of the table that holds the vector data. This will help you understand the structure of the stored embeddings and associated metadata.

```python
%sql select * from AGENTICS_AI where rownum <= 5
```

The output shows 4 columns: `id`, `text`, `meta`, and `embedding`.
*   `id` is the primary key.
*   `text` column contains the text chunks.
*   `meta` column contains additional information which can be used for filtering (e.g., location and page of the chunk).
*   `embedding` column contains the vector value of the text chunk.

<div>
<style scoped>
    .dataframe tbody tr th:only-of_type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>text</th>
      <th>metadata</th>
      <th>embedding</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>b\'K"ww\xd4\xdd\x1f\xc6\'</td>
      <td>may be trademarks of their respective owners. ...</td>
      <td>{"id": "4", "link": "Page 4"}</td>
      <td>[-0.10093670338392258, -0.0510505847632885, -0...</td>
    </tr>
    <tr>
      <th>1</th>  
      <td>b\'\xef-\x12}\xe3{\x94+\'</td>
      <td>damages incur red due to your access to or use...</td>
      <td>{"id": "5", "link": "Page 5"}</td>
      <td>[-0.05846373364329338, -0.03191264346241951, 0...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>b\'_\xec\xebf\xff\xc8o8\'</td>
      <td>Oracle Database®  \nOracle Database New Featur...</td>
      <td>{"id": "0", "link": "Page 0"}</td>
      <td>[-0.03197915479540825, -0.004067039582878351, ...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>b\'k\x86\xb2s\xff4\xfc\xe1\'</td>
      <td>The information contained herein is subject to...</td>
      <td>{"id": "1", "link": "Page 1"}</td>
      <td>[-0.033684320747852325, 0.03027949295938015, -...</td>
    </tr>
    <tr>
      <th>4</th>
      <td>b\'\xd4s^:&^\x16\xee\'</td>
      <td>"commercial computer software documentation," ...</td>
      <td>{"id": "2", "link": "Page 2"}</td>
      <td>[-0.05899398773908615, -0.008670773357152939, ...</td>
    </tr>
  </tbody>
</table>
</div>

---
## Task 5: Setting Up the MCP-Compatible LangGraph Agent

In this step, you will set up an AI agent using LangGraph and Oracle’s MCP (Modular Component Platform). This agent will use tool-based reasoning and interact with a running MCP tool server.


### Part 1: Configure the LLM and MCP Server Parameters

```python
# Set up the LLM
def initialize_llm():
    """Initialize and return the LLM model."""
    model = ChatOCIGenAI(
        model_id="cohere.command-r-08-2024",
        service_endpoint="https://inference.generativeai.us-chicago-1.oci.oraclecloud.com",
        compartment_id=os.getenv("COMPARTMENT_OCID"),
        auth_type="API_KEY",
        model_kwargs={"temperature": 0, "max_tokens": 700}
    )
    print(" LLM model initialized")
    return model

llm = initialize_llm()

# MCP tool server configuration
server_params = StdioServerParameters(
    command="python",
    args=["server.py"]
)
```

### Part 2: Define the Agent Execution Function

```python
async def run_mcp_agent(prompt: str) -> str:
    """Run the agent with the given prompt using MCP tools."""
    async with stdio_client(server_params) as (read, write):
        async with ClientSession(read, write) as session:
            await session.initialize()
            tools = await load_mcp_tools(session)
            agent = create_react_agent(llm, tools)
            response = await agent.ainvoke({
                "messages": [HumanMessage(content=prompt)]
            })
            return response["messages"][-1].content
```

### You can test the setup by running the following script:
```python
if __name__ == "__main__":
    user_input = input("Enter your question: ")
    output = asyncio.run(run_mcp_agent(user_input))
    print("Agent Response:\n", output)
```

You have completed the Code explanation. We would do code walk through in the next lab.

Please proceed to the next lab.

## Acknowledgements
* **Authors** - Ashu Kumar, Vijay Balebail, Rajeev Rumale
* **Contributors** - Milton Wan, Doug Hood
* **Last Updated By/Date** -  Ashu Kumar, July 2025
