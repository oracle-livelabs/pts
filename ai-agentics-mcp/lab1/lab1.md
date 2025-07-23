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
        $ cd /home/oracle/aidemo
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
%sql oracle+oracledb://vector:vector@129.213.75.70:1521?service_name=ORCLPDB1

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
def lookup_recipients(name: str):
    return fetch_recipients(name)

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

### Tool 4: `store_text_chunks` (MCP Tool)

The `store_text_chunks` tool is exposed via the MCP server and is responsible for splitting text and storing it as embeddings in the Oracle Vector Store. This is a crucial step for preparing documents for RAG operations within the MCP framework.

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

**Parameters:**
*   **Input:** `file_path`: The path to the text file to be chunked and stored.
*   **Output:** A string indicating the number of chunks stored and the file name, or an error message.

### Tool 5: `oracle_connect` (MCP Tool)

The `oracle_connect` tool is exposed via the MCP server and checks the connection status to the Oracle Database. This is a utility tool to ensure database connectivity for other MCP tools that rely on it.

```python
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
```

**Parameters:**
*   **Input:** None.
*   **Output:** A string indicating the Oracle DB connection status.

---

## Task 4: Database and Vector Store Setup (MCP Perspective)

This task focuses on configuring the Oracle Database and setting up the Vector Store, which are essential for providing your AI agents with access to persistent data and advanced search capabilities through the MCP server. The setup described here directly supports the MCP tools that interact with the database.

### Oracle Database Connection

Establishing a secure connection to your Oracle Database is the first step. We will connect using database credentials typically stored as environment variables for security best practices (e.g., in a `.env` file on Linux). This ensures that your MCP tools can interact with the database to fetch or store information as needed.

```python
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
def setup_vector_store(connection):

  """Set up and return the Oracle Vector Store."""    
    local_model_path = "/home/oracle/.cache/huggingface/hub/models--sentence-transformers--all-MiniLM-L6-v2/snapshots/c9745ed1d9f207416be6d2e6f8de32d1f16199bf"
    embeddings = HuggingFaceEmbeddings(model_name=local_model_path) 
    #embeddings = HugcingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")

    vector_store = OracleVS(
        client=connection,
        embedding_function=embeddings,
        table_name="AGENTICS_AI",
        distance_strategy=DistanceStrategy.COSINE
    )
    print("Oracle Vector Store ready")
    return vector_store

# Initialize vector store
vector_store = setup_vector_store(connection)
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

## Task 5: Setting up Agent using LangChain

This task details the process of setting up your AI agent using LangChain. We will cover agent memory, LLM initialization, prompt template creation, and the overall agent initialization process. This section will focus on how the agent interacts with MCP-exposed tools.

### Agent Memory

Memory is crucial for agents that need to maintain context over multiple turns. Our agent uses `ConversationBufferMemory`, which:
1.  Stores the complete conversation history.
2.  Makes it available to the agent on each turn.
3.  Allows the agent to refer back to prior information (like user names).

```python
memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)
```

### Initialize Oracle GenAI Model

The brain behind the agent is Oracle GenAI. This function initializes the specific model using Oracle API keys, providing the agent with its reasoning capabilities.

```python
def initialize_llm():
    """Initialize and return the LLM model."""
    model = ChatOCIGenAI(
        model_id="cohere.command-r-08-2024",
        service_endpoint="https://inference.generativeai.us-chicago-1.oci.oraclecloud.com",
        compartment_id=os.getenv("OCI_COMPARTMENT_ID"),
        auth_type="API_KEY",
        model_kwargs={"temperature": 0, "max_tokens": 700}
    )
    print(" LLM model initialized")
    return model
```

### Creating the Agent Prompt Template

A well-crafted prompt template is essential for guiding agent behavior effectively. It should clearly define the agent\'s role and limitations, establish strict formatting rules (such as enforcing the ReAct structure), and include specific instructions for handling special cases like usernames or conditional actions (e.g., when to generate a PDF). Examples are crucial—they illustrate proper reasoning and the expected format across different scenarios. Additionally, a concise list of available tools with descriptions helps the agent choose the right tool for the task.

Without these components, the agent is likely to produce inconsistent responses, make formatting errors that disrupt the reasoning-action loop, select inappropriate tools, or overlook important contextual information. A strong prompt template ensures consistent, accurate, and context-aware outputs from the agent.

```python
def create_agent_prompt():
    """Create and return the prompt template for the agent."""
    template = """
    You are an assistant that can search documents, look up emails, and create PDFs.

    Previous Chat History:
    {chat_history}

    STRICT FORMAT RULES:
    1. NEVER respond directly after "Thought:" - ALWAYS follow with either "Action:" or "Final Answer:"
    2. NEVER combine Action and Final Answer in the same response
    3. For name introductions: ONLY use "Thought:" followed by "Final Answer:"
    4. For PDF creation: Use "Action: Create PDF" with JSON in "Action Input:", then wait for "Observation:" before proceeding

    - If usr says "from me", check chat history to extract my name and use it in email sign-off as: "Best regards, <User Name>".
    - When the user says "from me", use the name from chat history (if available) in the signature. Use "Best regards,\n<User Name>" in the email body.
    - You may use the tool \`Get User Name\` to extract the name.
    - If the user says "from <Name>", you MUST use <Name> exactly as provided in the sign-off.
      Example: "Generate email from Milton" ? use "Best regards,\nMilton" in the email body

    - If the user says "do not generate a PDF", you MUST NOT call the Create PDF tool.

    EXAMPLES:

    CORRECT (for name introduction):
    Thought: The user introduced themselves, I should respond appropriately.
    Final Answer: Hello [Name]! Nice to meet you. How can I help you today?

    CORRECT (for PDF creation):
    Thought: I\'ll create the requested PDF.
    Action: Create PDF
    Action Input: {{ "title": "Test Document", "content": "This is a test" }}
    Observation: [PDF creation result]
    Thought: The PDF has been created.
    Final Answer: I\'ve created a PDF titled "Test Document".

    CORRECT (for feature listing with PDF):
    Thought: I need to find features and create a PDF.
    Action: RAG Search
    Action Input: features
    Observation: [search results]
    Thought: Now I\'ll create a PDF with these features.
    Action: Create PDF
    Action Input: {{ "title": "Oracle Features", "content": "Here are 5 features:..." }}
    Observation: [PDF creation result]
    Thought: I have completed both tasks.
    Final Answer: I\'ve found these features and created a PDF.


    CORRECT (for feature listing without PDF):
    Thought: User wants only the features without a PDF.
    Action: RAG Search
    Action Input: features
    Observation: [search results]
    Thought: I will now summarize 5 new features.
    Final Answer: 1. ... 2. ... 3. ...

    Available tools:
    {tools}

    Use the following format:
    Question: {input}
    Thought: [your reasoning]
    Action: [tool name]
    Action Input: [tool input]
    Observation: [tool result]
    ... (repeat Action/Action Input/Observation if needed)
    Thought: [your conclusion]
    Final Answer: [your response to the user]

    Begin!
    Question: {input}
    Thought:{agent_scratchpad}
    """
    return template

```

### Initialize Agent & AgentExecutor

We defined tools, models, and a prompt. Next, we need to initialize the agent and its executor. The `AgentExecutor` has additional information like the number of iterations, verbose mode for logging the thought process, and keywords for when the answer is found.

![AiArchitectire](images/flowstepsai.jpg)

### Agent Initialization Process

The agent initialization process begins with setting up memory to retain the conversation history, enabling the agent to access prior exchanges at each step. This is followed by configuring the language model—specifically Oracle’s ChatOCIGenAI powered by the Cohere Command-R model—where parameters such as temperature are tuned (e.g., setting it to 0 for deterministic responses).

Next, all tools required by the agent are registered with clear names and descriptions. These descriptions are essential, as they guide the LLM in selecting the appropriate tool during execution. The prompt is then constructed by combining a predefined template with dynamic components such as the tool list and a function to access chat history. This forms the basis for how the agent understands and responds to tasks.

Finally, the agent is created using LangChain’s ReAct agent framework, integrating the configured LLM, tools, and prompt. Execution settings like the maximum number of iterations, verbosity, and error handling are also established to ensure controlled and informative runs. Together, these steps ensure the agent is fully equipped for interactive, tool-augmented reasoning.

The below code snippet initializes the agent:

```python
def setup_agent():
    """Set up and return the agent executor."""
    # Initialize memory
    memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)

    # Initialize LLM
    model = initialize_llm()

    # Create tools
    tools = [
        Tool(name="RAG Search", func=rag_search, description="Useful for searching documents and retrieving information."),
        Tool(name="fetch_recipients", func=fetch_recipients, description="Useful for looking up email addresses by name."),
        Tool(name="Get User Name", func=extract_user_name, description="Useful for extracting the user\'s name from chat history."),
        Tool(name="Create PDF", func=create_pdf_tool, description="Useful for generating PDF documents from text or email data.")
    ]

    # Create prompt template
    template = create_agent_prompt()
    prompt = PromptTemplate.from_template(template)
        
    # Create agent and executor
    agent = create_react_agent(model, tools, prompt)

    agent_executor = AgentExecutor(
        agent=agent,
        tools=tools,
        memory=memory,
        verbose=True,
        max_iterations=15,
        handle_parsing_errors=True,
        output_key="output"
    )
    return agent_executor, memory

````

You have completed the Code explanation. We would do code walk through in the next lab.

Please proceed to the next lab.

## Acknowledgements
* **Authors** - Vijay Balebail, Rajeev Rumale
* **Contributors** - Milton Wan, Doug Hood
* **Last Updated By/Date** -  Rajeev Rumale, June 2025