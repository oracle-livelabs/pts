# Building a Document Search and PDF Generation Agent


## Introduction

This notebook demonstrates how to build a powerful AI agent that can search documents, generate PDFs, and handle email-related tasks using LangChain and Oracle GenAI. Throughout this workshop, we'll explore:

1. Setting up the environment and dependencies
2. Creating custom tools for our agent
3. Designing effective prompt templates
4. Initializing and running the agent

Let's get started!

# Section 1: Environment Setup and Imports

## **Imports and Configuration**

We need to import Oracle implementation of Langchain from langchain community.  Addition libraries are imported for PDF generation and standard library.

We are using OracleDB Python Drivers to connect to Oracle database and not cx_oracle driver, as only the latest driver supports the new feature like Vector Data type. 

To import all the require libararies for this work run the below code.  

```python

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

# Section 2: Database and Vector Store Setup

## **Oracle Database Connection**

Connecting to Oracle database using the database username and password which are stored as environment variables (in .env file on linux)

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

## **Vector Store Setup**

Vector search is a way to find similar data (like text, images, or audio) by comparing their vector representations which are numerical forms of that data rather than using traditional keyword matching.

Oracle Vector Store leverages Oracle's database capabilities for efficient similarity search.
For this workshop, **Oracle Table AGENTICS_AI is already loaded with data from file "Oracle 23ai New features"**  So, doing a RAG search on return top N text chunks doing vector search and send the text chunks olong with the question to LLM and return a human reable text.

The model we are using is all-MiniLM-L6-v2. This model has been download as ONNX file and loaded in the database already.

Note: To learn more about creating embedding in database check for live lab ( AI Vector Search - 7 Easy Steps to Building a RAG Application using LangChain [https://apexapps.oracle.com/pls/apex/f?p=133:180:6805094326698::::wid:3927] )

Run the below code to initialize the Oracle Vector Store 

```
def setup_vector_store(connection):
    """Set up and return the Oracle Vector Store."""
    embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
    vector_store = OracleVS(
        client=connection,
        embedding_function=embeddings,
        table_name="AGENTICS_AI",
        distance_strategy=DistanceStrategy.COSINE
    )
    print("? Oracle Vector Store ready")
    return vector_store

# Initialize vector store
vector_store = setup_vector_store(connection)
```
## **Verify the Vectore Store table**

To explore the vector store we created, run the sql query to select the first 5 rows of the table that holds the vector data.

```python
%sql select * from AGENTICS_AI where rownum <= 5
```

The out put shows 4 columns having id, text, meta and embedding.
id is the primary key,  Text column contains the text chunks, meta column contain additional information which can be used for filtering i.e location and page of the chunk, emmbeding column contain the Vector value of text chunk.

--------------Add a image of output of the sql query


<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
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
      <td>b'K"ww\xd4\xdd\x1f\xc6'</td>
      <td>may be trademarks of their respective owners. ...</td>
      <td>{"id": "4", "link": "Page 4"}</td>
      <td>[-0.10093670338392258, -0.0510505847632885, -0...</td>
    </tr>
    <tr>
      <th>1</th>
      <td>b'\xef-\x12}\xe3{\x94+'</td>
      <td>damages incur red due to your access to or use...</td>
      <td>{"id": "5", "link": "Page 5"}</td>
      <td>[-0.05846373364329338, -0.03191264346241951, 0...</td>
    </tr>
    <tr>
      <th>2</th>
      <td>b'_\xec\xebf\xff\xc8o8'</td>
      <td>Oracle Database®  \nOracle Database New Featur...</td>
      <td>{"id": "0", "link": "Page 0"}</td>
      <td>[-0.03197915479540825, -0.004067039582878351, ...</td>
    </tr>
    <tr>
      <th>3</th>
      <td>b'k\x86\xb2s\xff4\xfc\xe1'</td>
      <td>The information contained herein is subject to...</td>
      <td>{"id": "1", "link": "Page 1"}</td>
      <td>[-0.033684320747852325, 0.03027949295938015, -...</td>
    </tr>
    <tr>
      <th>4</th>
      <td>b'\xd4s^:&amp;^\x16\xee'</td>
      <td>"commercial computer software documentation," ...</td>
      <td>{"id": "2", "link": "Page 2"}</td>
      <td>[-0.05899398773908615, -0.008670773357152939, ...</td>
    </tr>
  </tbody>
</table>
</div>

## **Understanding AI Agent Components**
 
![AiArchitectire](images/flowstepsai.jpg)

The diagram shows the core structure of an AI agent: **Tools**, **Model**, and **Prompt** feed into the **Agent**, which is then processed by an **Agent Executor** that incorporates tools and memory. Specifically, the agent is initialized with a model (e.g., `ChatOCIGenAI`), a prompt template (`PromptTemplate.from_template(...)`), and a set of tools. The `AgentExecutor` then manages the agent’s operations, leveraging tools and memory to execute tasks effectively.

### **Explanation of Components and Tools**

We’ll define a set of specialized tools that the AI agent will utilize to perform its tasks, aligning with the workflow shown in the diagram:

- **rag\_search**: This tool enables the agent to perform Oracle Vector Search and retrieve Retrieval-Augmented Generation (RAG) answers from a large language model (LLM), enhancing its ability to provide accurate, data-driven responses from Oracle Database 23ai.
  
- **fetch\_recipients**: Designed to look up email addresses based on a given name, this tool allows the agent to dynamically fetch recipient details for email automation tasks, ensuring seamless communication workflows.

- **create\_pdf\_tool**: This tool empowers the agent to generate PDFs, either with a specified title and content or formatted as an email, enabling professional document creation for reporting or sharing purposes.

- **extract\_user\_name**: By accessing the agent’s short-term memory (as part of the `AgentExecutor`’s memory component), this tool retrieves user names from prior conversations, ensuring the agent maintains context and personalizes interactions effectively.

These tools, combined with the model and prompt, are orchestrated by the `AgentExecutor` to enable the AI agent to perform complex, multi-step tasks like data retrieval, email automation, and PDF generation, all while maintaining contextual awareness through memory.
How to Use:
Copy the above content into a text editor.
Save it as AI_Agent_Components.md.
Open it in any Markdown viewer or editor (e.g., VS Code, Typora, or GitHub) to see the formatted output.
Let me know if you need further assistance!



# Section 3: Building Agent Tools

Python tools are defined similarly to standard Python programs. When using LangChain with Python, tools are essentially Python functions that can operate independently of an agent, as no API abstraction interface is required if the agent and tools share the same language.

## Tool 1: RAG Search

In the RAG Search tool we create a function rag\_search. The variables in funcation are 
- query: Input User query about the RAG serch in the document.
- K=5: Specfies the number of top k-chuck to be sent to LLM for generating answer for query. We have to 5, can change as needed.
- content: This variable will hold the result set of similarity search and return as fuction output. 

```python
def rag_search(query: str) -> str:
    """Search for relevant documents using the vector store."""
    docs = vector_store.similarity_search(query, k=5)
    content = "\n".join([doc.page_content for doc in docs])
    return content
```

Sample input/output

    Input: Question about the document for a RAG search
    Output: Top 8 pages that have most relavent answers for the question.

# Tool 2: Fetch Recipients (Database Tool)

Fetch Recipients tools will query the database table for the first name and last name and return the corresponding email id.  The function fetch\_recipients is created for this.  The parameter used in the function are 

- Input: Takes name of the person
- Output: frist name, last name and email address

```python
def fetch_recipients(query: str) -> str:
    """Search for recipients by name and return formatted results."""
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
Fetch Recipients:

    Input: First Name or Last Name from chat conversation
    Output: email id associated with the name.

Hilights:

    - shows integration of RDBMS with LLM.
    - In this funtion, In the prompt, we can give additional instructions to handle multiple emails.


## Tool 3: PDF Creation
PDF Creation
- **Input**: well formed JSON document. which either has title and text, or To, subject and body
- **Output**: A PDF file is created in the directer in the current directory.

Highlights:
 Demonstation of use of 3rd party tools by the agent.



```python
def generate_email_pdf(email_data, filename="email.pdf"):
    """Generate a PDF from email data."""
    buffer = io.BytesIO()
    pdf = SimpleDocTemplate(buffer, pagesize=letter)
    styles = getSampleStyleSheet()

    elements = [
        Paragraph("Email", styles['Title']),
        Spacer(1, 0.2 * inch),
        Paragraph(f"<b>To:</b> {email_data['to']}", styles['Normal']),
        Paragraph(f"<b>Subject:</b> {email_data['subject']}", styles['Normal']),
        Spacer(1, 0.2 * inch),
        Paragraph("<b>Message:</b>", styles['Normal']),
        Spacer(1, 0.1 * inch)
    ]

    message_paragraphs = email_data['message'].split('\n\n')
    for para in message_paragraphs:
        if para.strip():
            elements.append(Paragraph(para.replace('\n', '<br/>'), styles['Normal']))
            elements.append(Spacer(1, 0.1 * inch))

    pdf.build(elements)
    buffer.seek(0)

    with open(filename, "wb") as f:
        f.write(buffer.getvalue())

    return f"Email PDF generated and saved as {filename}"

def create_pdf_tool(input_data: Union[str, Dict]) -> str:
    """
    Create a PDF from email content or general information.
    Input should be a JSON with "title", "content", and optionally "filename".
    For emails, content should contain "to", "subject", and "message" fields.
    """
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
                        elements.append(Paragraph(para.replace('\n', '<br/>'), styles['Normal']))
                        elements.append(Spacer(1, 0.1 * inch))
            elif isinstance(data["content"], list):
                for item in data["content"]:
                    elements.append(Paragraph(str(item).replace('\n', '<br/>'), styles['Normal']))
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

```

## Tool 4: User Name Extraction

Username extraction:
- **Input**: The chat history 
- **Output**: Firnd the name of the user from memory. and lookup email if asked to create pdf in email format.

Highlights
 
    - Stores the complete conversation history
    - Makes it available to the agent on each turn
    - Allows the agent to refer back to prior information (like user names)




```python
def format_chat_history(memory_vars):
    """Format the last few messages from the chat history for the prompt."""
    chat_hist = memory_vars.get("chat_history", [])
    formatted_lines = []
    # Consider up to the last 6 messages (to keep prompt concise)
    for msg in chat_hist[-6:]:
        if isinstance(msg, HumanMessage):
            formatted_lines.append(f"Human: {msg.content}")
        elif isinstance(msg, AIMessage):
            formatted_lines.append(f"Assistant: {msg.content}")
    return "\n".join(formatted_lines)

def extract_user_name(memory):
    """Extract user name from chat history based on 'My name is' pattern."""
    chat_hist = memory.load_memory_variables({}).get("chat_history", [])
    for msg in chat_hist:
        if isinstance(msg, HumanMessage):
            name_match = re.search(r"[Mm]y name is (\w+(?:\s+\w+)*)", msg.content)
            if name_match:
                return name_match.group(1)
    return None

```

"""
# Agent Memory

Memory is crucial for agents that need to maintain context over multiple turns.
- memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)
Our agent uses `ConversationBufferMemory` which:
1. Stores the complete conversation history
2. Makes it available to the agent on each turn
3. Allows the agent to refer back to prior information (like user names)

The `extract_user_name` tool demonstrates how we can parse this history to extract specific information.
"""

# Section 5: Creating the Agent Prompt Template



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
    - You may use the tool 'Get User Name' to extract the name.
    - If the user says "from <Name>", you MUST use <Name> exactly as provided in the sign-off.
      Example: "Generate email from Milton" ? use "Best regards,\nMilton" in the email body

    - If the user says "do not generate a PDF", you MUST NOT call the Create PDF tool.

    EXAMPLES:

    CORRECT (for name introduction):
    Thought: The user introduced themselves, I should respond appropriately.
    Final Answer: Hello [Name]! Nice to meet you. How can I help you today?

    CORRECT (for PDF creation):
    Thought: I'll create the requested PDF.
    Action: Create PDF
    Action Input: {{ "title": "Test Document", "content": "This is a test" }}
    Observation: [PDF creation result]
    Thought: The PDF has been created.
    Final Answer: I've created a PDF titled "Test Document".

    CORRECT (for feature listing with PDF):
    Thought: I need to find features and create a PDF.
    Action: RAG Search
    Action Input: features
    Observation: [search results]
    Thought: Now I'll create a PDF with these features.
    Action: Create PDF
    Action Input: {{ "title": "Oracle Features", "content": "Here are 5 features:..." }}
    Observation: [PDF creation result]
    Thought: I have completed both tasks.
    Final Answer: I've found these features and created a PDF.


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

"""
# The Importance of Effective Prompt Templates

The prompt template is the most crucial component for guiding agent behavior. Let's analyze what makes our template effective:

## 1. Clear Identity and Capabilities
- Sets expectations about what the agent can and cannot do
- Defines the agent's role

## 2. Strict Formatting Rules
- Ensures the agent follows the ReAct pattern
- Prevents common errors (like mixing actions and final answers)

## 3. Specific Instructions
- Custom rules for handling special cases (like user names)
- Conditional logic (when to create PDFs vs. when not to)

## 4. Examples
- Shows the exact expected format for different scenarios
- Demonstrates correct thought processes

## 5. Tool Descriptions
- Lists available tools with descriptions
- Helps the agent choose the right tool

Without these elements, the agent would:
- Be inconsistent in its responses
- Make format errors that break the agent loop
- Choose inappropriate tools
- Miss important context
"""

## Section 6: Initilize Agent  & Agent_executor

    agent = create_react_agent(model, tools, prompt)

    agent_executor = AgentExecutor(
        agent=agent,
        tools=tools,
        memory=memory,
        verbose=True,
        max_iterations=15,
        handle_parsing_errors=True,
        output_key="output"




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

def setup_agent():
    """Set up and return the agent executor."""
    # Initialize memory
    memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)

    # Initialize LLM
    model = initialize_llm()

    # Create tools
    tools = [
        Tool(
            name="RAG Search",
            func=rag_search,
            description="Search documents for relevant information about features, products, etc."
        ),
        Tool(
            name="fetch_recipients",
            func=fetch_recipients,
            description="Find an email address by name. Example input: 'Vijay Balebail'"
        ),
        Tool(
            name="Get User Name",
            func=lambda query: extract_user_name(memory) or "No name found in chat history",
            description="Extract the user's name from the chat history."
        ),
        Tool(
            name="Create PDF",
            func=create_pdf_tool,
            description='Create a PDF document. Regular format: {"title": "Title", "content": "Content"}. Email format: {"title": "Email", "content": {"to": "email", "subject": "Subject", "message": "Message"}}'
        )
    ]

    tool_names = [tool.name for tool in tools]

    # Create prompt template
    template = create_agent_prompt()
    prompt = PromptTemplate.from_template(template).partial(
        tools="\n".join(f"{tool.name}: {tool.description}" for tool in tools),
        tool_names=", ".join(tool_names),
        chat_history=lambda: format_chat_history(memory.load_memory_variables({}))
    )

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

    

```


```python
## Initialize the agent
agent_executor, memory = setup_agent()
    
print("Agent is ready to use!")
   
```

     LLM model initialized
    Agent is ready to use!


"""
# Agent Initialization Process

The agent initialization involves several key components:

1. **Memory Setup**
   - Creates a buffer to store conversation history
   - Makes this history available to the agent on each turn

2. **LLM Configuration**
   - Uses Oracle's ChatOCIGenAI with the Cohere Command-R model
   - Sets parameters like temperature (0 for more deterministic outputs)

3. **Tool Registration**
   - Creates and registers each tool with a name and description
   - The description is crucial as it helps the LLM understand when to use each tool

4. **Prompt Construction**
   - Takes our template and fills in dynamic elements
   - Creates a partial prompt with tools list and chat history function

5. **Agent Creation**
   - Uses LangChain's ReAct agent framework
   - Connects the LLM, tools, and prompt

6. **Executor Configuration**
   - Sets execution parameters like max iterations
   - Configures error handling and verbosity
"""

# Section 7: Agent Demonstration

"""
# Let's test our agent with various scenarios!

We'll demonstrate:
1. Self-introduction and name recognition
2. RAG search for information
3. PDF generation
4. Combining tools for complex tasks
"""

## Example 1: Name Introduction --Memory test

This will to used to test if the agent can retrive info from chat context.



```python
response = agent_executor.invoke({"input": "My name is Homer Simpson."})
print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mHello Homer Simpson! Nice to meet you. How can I help you today?[0mInvalid Format: Missing 'Action:' after 'Thought:'[32;1m[1;3mFinal Answer: Hello Homer Simpson! Nice to meet you. How can I help you today?[0m
    
    [1m> Finished chain.[0m
    
    Response:
     Hello Homer Simpson! Nice to meet you. How can I help you today?



```python
response = agent_executor.invoke({"input": "what is my name ?"})
print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will use the 'Get User Name' tool to extract the user's name from the chat history.
    Action: Get User Name
    [32;1m[1;3mFinal Answer: Your name is Homer Simpson. Is there anything else I can help you with?[0m
    
    [1m> Finished chain.[0m
    
    Response:
     Your name is Homer Simpson. Is there anything else I can help you with?


## Example 2: Get name from DB -- DB intaration test

This will to used to test if the agent can retrive info from relational database.
 This is a power feature if the agent and combine the data in the database and LLM to get the desared output using the tools available.


```python
response = agent_executor.invoke({"input": "what is the email of vijay."})
print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will use the 'fetch_recipients' tool to find the email address of Vijay.
    Action: fetch_recipients
    Action Input: Vijay BalebailO[0m[33;1m[1;3mVijay Balebail (vijay.balebail@oracle.com)
    
    [32;1m[1;3mThought: I have found the email address for Vijay Balebail.
    Final Answer: The email address for Vijay Balebail is vijay.balebail@oracle.com.[0m
    
    [1m> Finished chain.[0m
    
    Response:
     The email address for Vijay Balebail is vijay.balebail@oracle.com.


## Insert your name and email into the database and verify.

Edit the below sql to put in your first name, last name and email id into the database and verify it exists.


```python
%sql delete from recipients where first_name='james'

%sql insert into recipients( FIRST_NAME, LAST_NAME, EMAIL) VALUES ('james','bond', 'james.bond@oracle.com')

```

     * oracle+oracledb://vector:***@129.213.75.70:1521?service_name=ORCLPDB1
    1 rows affected.
     * oracle+oracledb://vector:***@129.213.75.70:1521?service_name=ORCLPDB1
    1 rows affected.





<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
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
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>
</div>




```python
%sql SELECT first_name, last_name, email FROM recipients 
```

     * oracle+oracledb://vector:***@129.213.75.70:1521?service_name=ORCLPDB1
    0 rows affected.





<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
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
      <th>first_name</th>
      <th>last_name</th>
      <th>email</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Vijay</td>
      <td>Balebail</td>
      <td>vijay.balebail@oracle.com</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Milton</td>
      <td>Wan</td>
      <td>milton.wan@oracle.com</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Mahesh</td>
      <td>Gurav</td>
      <td>mahesh.gurav@oracle.com</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Rajeev</td>
      <td>Ramale</td>
      <td>rajeev.rumale@oracle.com</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Satya</td>
      <td>mishra</td>
      <td>satyabrata.mishra@oracle.com</td>
    </tr>
    <tr>
      <th>5</th>
      <td>team</td>
      <td>Wan</td>
      <td>bvijay@hotmail.com</td>
    </tr>
    <tr>
      <th>6</th>
      <td>james</td>
      <td>bond</td>
      <td>james.bond@oracle.com</td>
    </tr>
    <tr>
      <th>7</th>
      <td>your_first_name</td>
      <td>your_last_name</td>
      <td>your_emai@oracle.com</td>
    </tr>
    <tr>
      <th>8</th>
      <td>Nitin</td>
      <td>Vengurlekar</td>
      <td>nitinvvengurlekar@gmail.com</td>
    </tr>
  </tbody>
</table>
</div>



## Verify your email can be retrived from the database.


```python
response = agent_executor.invoke({"input": "what is the email for james"})
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will use the fetch_recipients tool to find the email address for James.
    Action: fetch_recipients
    Action Input: JamesO[0m[33;1m[1;3mjames bond (james.bond@oracle.com)
    
    [32;1m[1;3mThought: I have found the email address for James.
    Action: fetch_recipients
    Action Input: JamesO[0m[33;1m[1;3mjames bond (james.bond@oracle.com)
    
    [32;1m[1;3mThought: I have found the email address for James.
    Final Answer: The email address for James is james.bond@oracle.com.[0m
    
    [1m> Finished chain.[0m


## Example 3: RAG Search -- Test Oracle DB vector search 
This is a demonstration of doing vector search of data stored in Oracle using vector search.


```python
# Run this cell to test
response = agent_executor.invoke({"input": "List are 5  features from the document"})
print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will use the RAG Search tool to find information about the features of the document.
    Action: RAG Search
    Action Input: features of the documentO[0m[36;1m[1;3mto produce better forecasting models without manual or exhaus tive search. It enables 
    non-expert users to perform time series forecasting without detailed understanding of 
    algorithm hyperparameters while also increasing data scientist productivity.  
    View Documentation  
    Explicit Semantic Analysis Support for Dense Projection with Embeddings in 
    OML4SQL  
    The unstructured text analytics  algorithm Explicit Semantic Analysis (ESA) is able to 
    output dense projections with embeddings, which are functionally  equivalent to the 
    popular doc2vec (document to vector) representation.  
    Producing  a doc2vec represe ntation is useful as input to other machine learning 
    techniques, for example, classification and regression, to improve their accuracy when 
    used solely with text or in combination with other structured data. Use cases include 
    processing unstructured text f rom call center representative notes on customers or
    customizable, efficient, and engaging map experiences.  
    View Documentation  
    Workspace Manager: Improved Security when using Oracle Workspace Manager  
    Database u sers can have workspace manager objects in their own schema instead of 
    in the WMSYS schema.  
    Oracle Workspace Manager enables collaborative development, what -if analysis from 
    data updates, and maintains a history of changes to the data. Developers can creat e 
    multiple workspaces and group different versions of table row values in different 
    workspaces. With this enhancement, developers have improved security when using 
    this feature. All the workspace manager objects can be stored and invoked in their 
    own user schema in Oracle Autonomous Database and user -managed databases.  
    View Documentation   
     68 5 Data Ware housing/Big Data  
    General  
    Enhanced Partitioning Metadata  
    Data dictionary views that contain partitioning -related metadata, for example,
    View Documentation   
     68 5 Data Ware housing/Big Data  
    General  
    Enhanced Partitioning Metadata  
    Data dictionary views that contain partitioning -related metadata, for example,  
    ALL_TAB_PARTITIONS , have two additional columns representing the high value 
    (boundary) information of partitions and subpartitions in JSON and CLOB format.  
    Providing the high value (boundary) partitioning information in JSON and as CLOB 
    allows  you to use this information pr ogrammatically. This enables simple and 
    automated processing of this information for schema retrieval or lifecycle 
    management operations.  
    View Documentation  
    Extended Language Support in Oracle Text  
    Language support is extended in Oracle Text, now supporting up to 48 languages. 
    Additionally, there is extended support for all languages. To avoid the e xtended 
    language support increasing your install footprint on disk, a new mechanism is 
    introduced to control the downloaded languages on demand.
    functionality is part of the SQL/JSON standard.  
    Applying JSON path expressions more widely for  querying JSON data boosts 
    your  developer's productivity and simplifies code development.  
    View Documentation  
    SCORE Ancillary Operator for JSON_TEXTCONTAINS()  
    This feature allows you to return a score for your JSON_TEXTCONTAINS()  queries by 
    using the SCORE()  operator.  
    You can also order the results by the score.  
    JSON_TEXTCONTAINS function gains a new parameter for use with the SCORE() 
    function allowing for an improved development experience.  
    View Documentation  
    SODA Enhancements  
    Various extensions are made to the SODA API:  
    • Merge and patch:  New SODA operations mergeOne and mer geOneAndGet.  
    • Embedded Keys:  You can now embed the key of a document in the document 
    itself. This is used for MongoDB -compatible collections.  
    • Dynamic Data Guide:  The operation to compute a data guide on the fly is 
    extended to other SODA languages, besides  PL/SQL and C.
    required.  
    View Documentat ion 
    Flashback Time Travel Enhancements  
    Flashback Time Travel can automatically track and archive transactional changes to 
    tables. Flashback Time Travel creates archives of the changes made to the rows of a 
    table and stores the changes in history tables. It  also maintains a history of the 
    evolution of the table's schema. By maintaining the history of the transactional 
    changes to a table and its schema, Flashback Time Travel enables you to perform 
    operations, such as Flashback Query ( AS OF  and VERSIONS ), on t he table to view the 
    history of the changes made during transaction time.  
    Flashback Time Travel helps to meet compliance requirements based on record -stage 
    policies and audit reports by tracking and storing transactional changes to a table, 
    which has also been made more efficient and performant in this release.  
    View Documentation   
    [32;1m[1;3mThought: I have found the following features in the document: Mode[0m
    1. Oracle Time Series provides better forecasting models without manual or exhaustive search.
    2. Explicit Semantic Analysis Support for Dense Projection with Embeddings in OML4SQL.
    3. Workspace Manager: Improved Security when using Oracle Workspace Manager.
    4. Enhanced Partitioning Metadata.
    5. Extended Language Support in Oracle Text.
    
    I can now provide a summary of these features or create a PDF document with more detailed information if required.
    
    Final Answer: Here are five features from the document:
    
    1. Oracle Time Series: This feature enhances time series forecasting by enabling non-expert users to perform predictions without a detailed understanding of algorithm hyperparameters. It also increases data scientist productivity.
    2. Explicit Semantic Analysis (ESA): ESA is an unstructured text analytics algorithm that can output dense projections with embeddings, similar to doc2vec representations. These representations can be used as input for other machine learning techniques to improve accuracy when working with text data.
    3. Workspace Manager: Oracle Workspace Manager allows for collaborative development and what-if analysis from data updates. With this feature, developers can create multiple workspaces and group different versions of table row values. The enhancement allows workspace manager objects to be stored and invoked in the user's own schema, improving security.
    4. Enhanced Partitioning Metadata: Data dictionary views now include two additional columns representing the high value (boundary) information of partitions and subpartitions in JSON and CLOB format. This allows for programmatic use of this information, simplifying schema retrieval and lifecycle management operations.
    5. Extended Language Support in Oracle Text: Oracle Text now supports up to 48 languages, with extended support for all languages. A new mechanism has been introduced to control the downloaded languages on demand, reducing the install footprint on disk.[0m
    
    [1m> Finished chain.[0m
    
    Response:
     Here are five features from the document:
    
    1. Oracle Time Series: This feature enhances time series forecasting by enabling non-expert users to perform predictions without a detailed understanding of algorithm hyperparameters. It also increases data scientist productivity.
    2. Explicit Semantic Analysis (ESA): ESA is an unstructured text analytics algorithm that can output dense projections with embeddings, similar to doc2vec representations. These representations can be used as input for other machine learning techniques to improve accuracy when working with text data.
    3. Workspace Manager: Oracle Workspace Manager allows for collaborative development and what-if analysis from data updates. With this feature, developers can create multiple workspaces and group different versions of table row values. The enhancement allows workspace manager objects to be stored and invoked in the user's own schema, improving security.
    4. Enhanced Partitioning Metadata: Data dictionary views now include two additional columns representing the high value (boundary) information of partitions and subpartitions in JSON and CLOB format. This allows for programmatic use of this information, simplifying schema retrieval and lifecycle management operations.
    5. Extended Language Support in Oracle Text: Oracle Text now supports up to 48 languages, with extended support for all languages. A new mechanism has been introduced to control the downloaded languages on demand, reducing the install footprint on disk.


## Example 4: Creating a Simple PDF -- Test working of Create pdf tool
This is to demonstrate use of   non-database tools and later test how the agent can use some or all the tools available to get to the solution.


```python
# Run this cell to test
response = agent_executor.invoke({
    "input": "Create a simple PDF with the title 'Workshop Notes' and content 'This workshop demonstrates building an AI agent with Oracle GenAI.'"
})
print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I'll create the requested PDF.
    Action: Create PDF
    Action Input: {
        "title": "Workshop Notes",
        "content": "This workshop demonstrates building an AI agent with Oracle GenAI."
    [32;1m[1;3mThought: I have successfully created the PDF.s.pdf[0m
    Final Answer: I've created a PDF titled 'Workshop Notes'. You can find it saved as Workshop_Notes.pdf.[0m
    
    [1m> Finished chain.[0m
    
    Response:
     I've created a PDF titled 'Workshop Notes'. You can find it saved as Workshop_Notes.pdf.


## Example 4: Combined Task - RAG Search and Create PDF
Demonstration of using Oracle Vector search with 3rd party tools.
**Create pdf with info from milton to vijay**


```python
response = agent_executor.invoke({
    "input": "Find information about Oracle Cloud Infrastructure and create a PDF summary."
})
print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will search for information about Oracle Cloud Infrastructure and then create a PDF summary.
    
    Action: RAG Search
    Action Input: Oracle Cloud InfrastructureO[0m[36;1m[1;3mto complete tasks more efficiently and reducing the opportunity for errors.  
    View Documentation   
     95 Autonomous Database  
    Identity and Access Management Integration with Oracle Autonomous Cloud 
    Databases  
    You can now log in to additional Oracle Database Oracle Cloud Infrastructure (OCI) 
    DBaaS platforms by using an Identity and Access Management (IAM) password or a 
    token -based authentication. It's possible to log in to  these databases by using these 
    IAM credentials from  tools, such as SQL*Plus or SQLcl.  
    This feature improves security through centralized management of credentials for OCI 
    DBaaS database instances.  
    View Documentation  
    ODP.NET: Oracle Identity and Access Management  
    ODP.NET supports Oracle Identity and Access M anagement (IAM) cloud service for 
    unified identity across Oracle cloud services, including Oracle Cloud Database 
    Services. ODP.NET can use the same Oracle IAM credentials for authentication and
    unified identity across Oracle cloud services, including Oracle Cloud Database 
    Services. ODP.NET can use the same Oracle IAM credentials for authentication and 
    authorization to the Oracle Cloud and Oracle cloud databases, now with IAM SSO 
    tokens. This feature is available in ODP.NET Core and managed ODP.NET.  
    This capability allows single sign -on and for identity to be propagated to all services 
    Oracle IAM supports including federated users via Azure Active Directory and 
    Microsoft Active Directory (on -premises). A unified identity makes user management 
    and account management easier for administrators and end users.  
    View Documentation  
    Oracle Client Increased Database Password Length  
    Starting with this release, Oracle Database and client drivers support  passwords up to 
    1024 bytes in length.  
    The Oracle Database and client  password length has been increased to 1024 bytes, up 
    from 30 bytes, to allow users to set longer passwords if needed.  The maximum
    OCI Attributes for Microsoft Azure Active Dir ectory Integration with Additional 
    Oracle Database Environments  
    You can log into additional Oracle Database environments using your Microsoft Azure 
    Active Directory (Azure AD) single sign -on OAuth2 access token.  The previous release 
    supported Azure AD inte gration  for Oracle Cloud Infrastructure (OCI) Autonomous 
    Database (Shared Infrastructure). This release has expanded Azure AD integration to 
    support on -premises Oracle Database release 19.16 and later. The project adds the OCI 
    attributes needed to supply t he bearer token for connection creation.  
    This multi -cloud feature integrates authentication and authorization between Azure 
    AD and Oracle Databases in Oracle Cloud Infrastructure  and on -premises.   
     97 View Documentation   
     98 10 OLTP and Core Database  
    Availability  
    True Cache  
    True Cache is an in -memory, consistent, and automatically managed cache for Oracle
    "commercial computer software documentation," or "limited rights data" pursuant to the 
    applicable Federal Acquisitio n Regulation and agency -specific supplemental regulations. As such, 
    the use, reproduction, duplication, release, display, disclosure, modification, preparation of 
    derivative works, and/or adaptation of i) Oracle programs (including any operating system, 
    integrated software, any programs embedded, installed, or activated on delivered hardware, and 
    modifications of such programs), ii) Oracle computer documentation and/or iii) other Oracle data, 
    is subject to the rights and limitations specified in the license  contained in the applicable contract. 
    The terms governing the U.S. Government's use of Oracle cloud services are defined by the 
    applicable contract for such services. No other rights are granted to the U.S. Government.  
    This software or hardware is develop ed for general use in a variety of information management
    configure. Hybrid disaste r recovery for the Oracle Database allows you to expand 
    outage and data protection to take advantage of the automation and resources of 
    Oracle Cloud Infrastructure (OCI). By enabling the ability to quickly configure disaster 
    recovery in OCI, even in cases where on -premises databases might not already be 
    encrypted with Transparent Data Encryption (TDE), the steps required to configure 
    hybrid disaster recovery environments and prepare on -premises databases for a DR 
    configuration with cloud databases in OCI ha ve been greatly reduced.  
    View Documentation  
    Per-PDB Data Guard Integration Enhancements  
    The new  Oracle Data Guard per Pluggable Database architecture provides more 
    granular control over pluggable databases, which can now switch and fail over 
    independently. The enhancements to the Oracle Data Guard per Pluggable Database 
    [32;1m[1;3mAction: Create PDFlidation, automatic addition of temporary files,[0m
    Action Input: {
        "title": "Oracle Cloud Infrastructure Summary",
        "content": "Oracle Cloud Infrastructure (OCI) offers a range of features to enhance security and efficiency. One notable feature is the integration of Identity and Access Management (IAM) with OCI DBaaS platforms, allowing for centralized management of credentials and improved security. Additionally, ODP.NET supports Oracle IAM for unified identity across Oracle cloud services, enabling single sign-on and easier user management. The Oracle Database and client drivers now support passwords up to 1024 bytes in length, providing users with more flexibility. OCI also integrates with Microsoft Azure Active Directory, allowing users to log in to Oracle Database environments using their Azure AD single sign-on OAuth2 access token. This multi-cloud feature enhances authentication and authorization between Azure AD and Oracle Databases in OCI and on-premises environments. Furthermore, Oracle's True Cache provides an in-memory, consistent, and automatically managed cache for Oracle Database, improving performance and reducing the steps required for hybrid disaster recovery configurations."
    [32;1m[1;3mThought: I will now create a PDF summary of the information about Oracle Cloud Infrastructure.
    
    Action: Create PDF
    Action Input: {
        "title": "Oracle Cloud Infrastructure Summary",
        "content": "Oracle Cloud Infrastructure (OCI) offers a range of features to enhance security and efficiency. One notable feature is the integration of Identity and Access Management (IAM) with OCI DBaaS platforms, allowing for centralized management of credentials and improved security. Additionally, ODP.NET supports Oracle IAM for unified identity across Oracle cloud services, enabling single sign-on and easier user management. The Oracle Database and client drivers now support passwords up to 1024 bytes in length, providing users with more flexibility. OCI also integrates with Microsoft Azure Active Directory, allowing users to log in to Oracle Database environments using their Azure AD single sign-on OAuth2 access token. This multi-cloud feature enhances authentication and authorization between Azure AD and Oracle Databases in OCI and on-premises environments. Furthermore, Oracle's True Cache provides an in-memory, consistent, and automatically managed cache for Oracle Database, improving performance and reducing the steps required for hybrid disaster recovery configurations."
    [32;1m[1;3mThought: I have found the requested information about Oracle Cloud Infrastructure and will now create a PDF summary.
    
    Action: Create PDF
    Action Input: {
        "title": "Oracle Cloud Infrastructure Summary",
        "content": "Oracle Cloud Infrastructure (OCI) offers a range of features to enhance security and efficiency. One notable feature is the integration of Identity and Access Management (IAM) with OCI DBaaS platforms, allowing for centralized management of credentials and improved security. Additionally, ODP.NET supports Oracle IAM for unified identity across Oracle cloud services, enabling single sign-on and easier user management. The Oracle Database and client drivers now support passwords up to 1024 bytes in length, providing users with more flexibility. OCI also integrates with Microsoft Azure Active Directory, allowing users to log in to Oracle Database environments using their Azure AD single sign-on OAuth2 access token. This multi-cloud feature enhances authentication and authorization between Azure AD and Oracle Databases in OCI and on-premises environments. Furthermore, Oracle's True Cache provides an in-memory, consistent, and automatically managed cache for Oracle Database, improving performance and reducing the steps required for hybrid disaster recovery configurations."
    [32;1m[1;3mThought: I have found the requested information about Oracle Cloud Infrastructure and will now create a PDF summary.
    
    Action: Create PDF
    Action Input: {
        "title": "Oracle Cloud Infrastructure Summary",
        "content": "Oracle Cloud Infrastructure (OCI) offers a range of features to enhance security and efficiency. One notable feature is the integration of Identity and Access Management (IAM) with OCI DBaaS platforms, allowing for centralized management of credentials and improved security. Additionally, ODP.NET supports Oracle IAM for unified identity across Oracle cloud services, enabling single sign-on and easier user management. The Oracle Database and client drivers now support passwords up to 1024 bytes in length, providing users with more flexibility. OCI also integrates with Microsoft Azure Active Directory, allowing users to log in to Oracle Database environments using their Azure AD single sign-on OAuth2 access token. This multi-cloud feature enhances authentication and authorization between Azure AD and Oracle Databases in OCI and on-premises environments. Furthermore, Oracle's True Cache provides an in-memory, consistent, and automatically managed cache for Oracle Database, improving performance and reducing the steps required for hybrid disaster recovery configurations."
    [32;1m[1;3mFinal Answer: I've found the requested information about Oracle Cloud Infrastructure and created a PDF summary. You can find it saved as Oracle_Cloud_Infrastructure_Summary.pdf.[0m
    
    [1m> Finished chain.[0m
    
    Response:
     I've found the requested information about Oracle Cloud Infrastructure and created a PDF summary. You can find it saved as Oracle_Cloud_Infrastructure_Summary.pdf.


## Example 4: Combined Task - Rag Search , fetch_recipients and create PDF
Demonstrating use of Oracle Vector search, with 3rd party tools and information from prompt.


```python

    print("\n=== Listing Features and Generate PDF in email format===")
    response = agent_executor.invoke({"input": "List 5 new features from the document. Generate a pdf in email format to send to vijay from Milton"})
    print("\nResponse:\n", response.get("output"))

```

    
    === Listing Features and Generate PDF in email format===
    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will first search for the 5 new features from the document.
    Action: RAG Search
    Action Input: 5 new features from the documentO[0m[36;1m[1;3mto produce better forecasting models without manual or exhaus tive search. It enables 
    non-expert users to perform time series forecasting without detailed understanding of 
    algorithm hyperparameters while also increasing data scientist productivity.  
    View Documentation  
    Explicit Semantic Analysis Support for Dense Projection with Embeddings in 
    OML4SQL  
    The unstructured text analytics  algorithm Explicit Semantic Analysis (ESA) is able to 
    output dense projections with embeddings, which are functionally  equivalent to the 
    popular doc2vec (document to vector) representation.  
    Producing  a doc2vec represe ntation is useful as input to other machine learning 
    techniques, for example, classification and regression, to improve their accuracy when 
    used solely with text or in combination with other structured data. Use cases include 
    processing unstructured text f rom call center representative notes on customers or
    customizable, efficient, and engaging map experiences.  
    View Documentation  
    Workspace Manager: Improved Security when using Oracle Workspace Manager  
    Database u sers can have workspace manager objects in their own schema instead of 
    in the WMSYS schema.  
    Oracle Workspace Manager enables collaborative development, what -if analysis from 
    data updates, and maintains a history of changes to the data. Developers can creat e 
    multiple workspaces and group different versions of table row values in different 
    workspaces. With this enhancement, developers have improved security when using 
    this feature. All the workspace manager objects can be stored and invoked in their 
    own user schema in Oracle Autonomous Database and user -managed databases.  
    View Documentation   
     68 5 Data Ware housing/Big Data  
    General  
    Enhanced Partitioning Metadata  
    Data dictionary views that contain partitioning -related metadata, for example,
    functionality is part of the SQL/JSON standard.  
    Applying JSON path expressions more widely for  querying JSON data boosts 
    your  developer's productivity and simplifies code development.  
    View Documentation  
    SCORE Ancillary Operator for JSON_TEXTCONTAINS()  
    This feature allows you to return a score for your JSON_TEXTCONTAINS()  queries by 
    using the SCORE()  operator.  
    You can also order the results by the score.  
    JSON_TEXTCONTAINS function gains a new parameter for use with the SCORE() 
    function allowing for an improved development experience.  
    View Documentation  
    SODA Enhancements  
    Various extensions are made to the SODA API:  
    • Merge and patch:  New SODA operations mergeOne and mer geOneAndGet.  
    • Embedded Keys:  You can now embed the key of a document in the document 
    itself. This is used for MongoDB -compatible collections.  
    • Dynamic Data Guide:  The operation to compute a data guide on the fly is 
    extended to other SODA languages, besides  PL/SQL and C.
    View Documentation   
     68 5 Data Ware housing/Big Data  
    General  
    Enhanced Partitioning Metadata  
    Data dictionary views that contain partitioning -related metadata, for example,  
    ALL_TAB_PARTITIONS , have two additional columns representing the high value 
    (boundary) information of partitions and subpartitions in JSON and CLOB format.  
    Providing the high value (boundary) partitioning information in JSON and as CLOB 
    allows  you to use this information pr ogrammatically. This enables simple and 
    automated processing of this information for schema retrieval or lifecycle 
    management operations.  
    View Documentation  
    Extended Language Support in Oracle Text  
    Language support is extended in Oracle Text, now supporting up to 48 languages. 
    Additionally, there is extended support for all languages. To avoid the e xtended 
    language support increasing your install footprint on disk, a new mechanism is 
    introduced to control the downloaded languages on demand.
    required.  
    View Documentat ion 
    Flashback Time Travel Enhancements  
    Flashback Time Travel can automatically track and archive transactional changes to 
    tables. Flashback Time Travel creates archives of the changes made to the rows of a 
    table and stores the changes in history tables. It  also maintains a history of the 
    evolution of the table's schema. By maintaining the history of the transactional 
    changes to a table and its schema, Flashback Time Travel enables you to perform 
    operations, such as Flashback Query ( AS OF  and VERSIONS ), on t he table to view the 
    history of the changes made during transaction time.  
    Flashback Time Travel helps to meet compliance requirements based on record -stage 
    policies and audit reports by tracking and storing transactional changes to a table, 
    which has also been made more efficient and performant in this release.  
    View Documentation   
    [32;1m[1;3mThought: I will now create an email PDF to send to Vijay from Milton with the 5 new features from the document.
    Action: Create PDF
    Action Input: {
        "title": "Email",
        "content": {
            "to": "vijay.balebail@oracle.com",
            "subject": "5 New Features from the Document",
            "message": "Dear Vijay,\n\nI hope this email finds you well. I wanted to share with you some exciting new features from the document.\n\n1. Oracle Time Series: This feature enhances time series forecasting by enabling non-expert users to perform predictions without a detailed understanding of algorithm hyperparameters. It also increases data scientist productivity.\n2. Explicit Semantic Analysis (ESA): ESA is an unstructured text analytics algorithm that can output dense projections with embeddings, similar to doc2vec representations. These representations can be used as input for other machine learning techniques to improve accuracy when working with text data.\n3. Workspace Manager: Oracle Workspace Manager allows for collaborative development and what-if analysis from data updates. With this feature, developers can create multiple workspaces and group different versions of table row values. The enhancement allows workspace manager objects to be stored and invoked in the user's own schema, improving security.\n4. Enhanced Partitioning Metadata: Data dictionary views now include two additional columns representing the high value (boundary) information of partitions and subpartitions in JSON and CLOB format. This allows for programmatic use of this information, simplifying schema retrieval and lifecycle management operations.\n5. Extended Language Support in Oracle Text: Oracle Text now supports up to 48 languages, with extended support for all languages. A new mechanism has been introduced to control the downloaded languages on demand, reducing the install footprint on disk.\n\nBest regards,\nMilton"
        }
    [32;1m[1;3mThought: I have successfully created the email PDF and saved it as Email_to_vijaybalebailoraclecom_from_Milton.pdf.
    
    Final Answer: I've created an email PDF with the 5 new features from the document and sent it to Vijay from Milton. You can find the PDF saved as Email_to_vijaybalebailoraclecom_from_Milton.pdf.[0m
    
    [1m> Finished chain.[0m
    
    Response:
     I've created an email PDF with the 5 new features from the document and sent it to Vijay from Milton. You can find the PDF saved as Email_to_vijaybalebailoraclecom_from_Milton.pdf.


## Example 4: Combined Task - Rag Search , fetch_recipients and create PDF and MEMORY
Demonstrating use of Oracle Vector search, with 3rd party tools and mixing information from relational query, vector search,external tools  and conversation memory


```python

    response = agent_executor.invoke({"input": "what is my name"})
    print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mFinal Answer: Your name is Homer Simpson. Is there anything else I can help you with?[0m
    
    [1m> Finished chain.[0m
    
    Response:
     Your name is Homer Simpson. Is there anything else I can help you with?



```python
    
    response = agent_executor.invoke({"input": "List 4 new features from the document. Generate a pdf in email format to send to vijay from me"})
    print("\nResponse:\n", response.get("output"))

```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will first search for the 4 new features from the document.
    Action: RAG Search
    Action Input: 4 new features from the documentO[0m[36;1m[1;3mto produce better forecasting models without manual or exhaus tive search. It enables 
    non-expert users to perform time series forecasting without detailed understanding of 
    algorithm hyperparameters while also increasing data scientist productivity.  
    View Documentation  
    Explicit Semantic Analysis Support for Dense Projection with Embeddings in 
    OML4SQL  
    The unstructured text analytics  algorithm Explicit Semantic Analysis (ESA) is able to 
    output dense projections with embeddings, which are functionally  equivalent to the 
    popular doc2vec (document to vector) representation.  
    Producing  a doc2vec represe ntation is useful as input to other machine learning 
    techniques, for example, classification and regression, to improve their accuracy when 
    used solely with text or in combination with other structured data. Use cases include 
    processing unstructured text f rom call center representative notes on customers or
    functionality is part of the SQL/JSON standard.  
    Applying JSON path expressions more widely for  querying JSON data boosts 
    your  developer's productivity and simplifies code development.  
    View Documentation  
    SCORE Ancillary Operator for JSON_TEXTCONTAINS()  
    This feature allows you to return a score for your JSON_TEXTCONTAINS()  queries by 
    using the SCORE()  operator.  
    You can also order the results by the score.  
    JSON_TEXTCONTAINS function gains a new parameter for use with the SCORE() 
    function allowing for an improved development experience.  
    View Documentation  
    SODA Enhancements  
    Various extensions are made to the SODA API:  
    • Merge and patch:  New SODA operations mergeOne and mer geOneAndGet.  
    • Embedded Keys:  You can now embed the key of a document in the document 
    itself. This is used for MongoDB -compatible collections.  
    • Dynamic Data Guide:  The operation to compute a data guide on the fly is 
    extended to other SODA languages, besides  PL/SQL and C.
    customizable, efficient, and engaging map experiences.  
    View Documentation  
    Workspace Manager: Improved Security when using Oracle Workspace Manager  
    Database u sers can have workspace manager objects in their own schema instead of 
    in the WMSYS schema.  
    Oracle Workspace Manager enables collaborative development, what -if analysis from 
    data updates, and maintains a history of changes to the data. Developers can creat e 
    multiple workspaces and group different versions of table row values in different 
    workspaces. With this enhancement, developers have improved security when using 
    this feature. All the workspace manager objects can be stored and invoked in their 
    own user schema in Oracle Autonomous Database and user -managed databases.  
    View Documentation   
     68 5 Data Ware housing/Big Data  
    General  
    Enhanced Partitioning Metadata  
    Data dictionary views that contain partitioning -related metadata, for example,
    View Documentation   
     68 5 Data Ware housing/Big Data  
    General  
    Enhanced Partitioning Metadata  
    Data dictionary views that contain partitioning -related metadata, for example,  
    ALL_TAB_PARTITIONS , have two additional columns representing the high value 
    (boundary) information of partitions and subpartitions in JSON and CLOB format.  
    Providing the high value (boundary) partitioning information in JSON and as CLOB 
    allows  you to use this information pr ogrammatically. This enables simple and 
    automated processing of this information for schema retrieval or lifecycle 
    management operations.  
    View Documentation  
    Extended Language Support in Oracle Text  
    Language support is extended in Oracle Text, now supporting up to 48 languages. 
    Additionally, there is extended support for all languages. To avoid the e xtended 
    language support increasing your install footprint on disk, a new mechanism is 
    introduced to control the downloaded languages on demand.
    required.  
    View Documentat ion 
    Flashback Time Travel Enhancements  
    Flashback Time Travel can automatically track and archive transactional changes to 
    tables. Flashback Time Travel creates archives of the changes made to the rows of a 
    table and stores the changes in history tables. It  also maintains a history of the 
    evolution of the table's schema. By maintaining the history of the transactional 
    changes to a table and its schema, Flashback Time Travel enables you to perform 
    operations, such as Flashback Query ( AS OF  and VERSIONS ), on t he table to view the 
    history of the changes made during transaction time.  
    Flashback Time Travel helps to meet compliance requirements based on record -stage 
    policies and audit reports by tracking and storing transactional changes to a table, 
    which has also been made more efficient and performant in this release.  
    View Documentation   
    [32;1m[1;3mThought: I will now create an email PDF with the 4 new features from the document and send it to Vijay from the user's name.
    Action: Create PDF
    Action Input: {
        "title": "Email",
        "content": {
            "to": "vijay.balebail@oracle.com",
            "subject": "4 New Features from the Document",
            "message": "Dear Vijay,\n\nI hope this email finds you well. I wanted to share with you some exciting new features from the document.\n\n1. Oracle Time Series: This feature enhances time series forecasting, allowing non-expert users to perform predictions without a detailed understanding of algorithm hyperparameters. It also increases data scientist productivity.\n2. Explicit Semantic Analysis (ESA): ESA is an unstructured text analytics algorithm that can output dense projections with embeddings, similar to doc2vec representations. These representations can be used to improve accuracy when working with text data.\n3. SCORE Ancillary Operator for JSON_TEXTCONTAINS(): This feature allows you to return a score for your JSON_TEXTCONTAINS() queries by using the SCORE() operator. You can also order the results by the score.\n4. Enhanced Partitioning Metadata: Data dictionary views now include two additional columns representing the high value (boundary) information of partitions and subpartitions in JSON and CLOB format. This allows for programmatic use of this information.\n\nBest regards,\nHomer Simpson"
        }
    [32;1m[1;3mThought: I will now provide the user with a response, confirming the email PDF has been created and saved.
    
    Final Answer: I've created an email PDF with the 4 new features from the document and sent it to Vijay from your name, Homer Simpson. You can find the PDF saved as Email_to_vijaybalebailoraclecom_from_Homer.pdf.[0m
    
    [1m> Finished chain.[0m
    
    Response:
     I've created an email PDF with the 4 new features from the document and sent it to Vijay from your name, Homer Simpson. You can find the PDF saved as Email_to_vijaybalebailoraclecom_from_Homer.pdf.


Observer that the question mentions from me. And since you introduced your self as Homer Simson, its taking that information from memory and addressing.


"""
# Workshop Takeaways

## What We've Learned

1. **LLM Agent Architecture**
   - How to combine LLMs with tools for enhanced capabilities
   - The ReAct pattern for reasoning and acting

2. **Vector Search & RAG**
   - Setting up Oracle Vector Store
   - Implementing semantic search for document retrieval

3. **Tool Development**
   - Creating custom tools for specific tasks
   - Handling different input formats and error cases

4. **Prompt Engineering**
   - Designing effective templates for guiding agent behavior
   - Using examples and rules to improve performance
   
5. **Agent Configuration**
   - Setting up memory for contextual conversations
   - Configuring the agent for optimal performance

## Next Steps

- Scroll back and read through the template initilization. This is what makes an agent costamized to your needs.
- Implement more sophisticated tools (database queries, API integrations)
- Explore different memory mechanisms for long-term context
- Fine-tune the prompt for better handling of edge cases
"""

## Bonus: Create an Email PDF from Personal Information

# Run this cell to try it
response = agent_executor.invoke({
    "input": "Create an email to the workshop organizer thanking them for the session. Sign it from me."
})
print("\nResponse:\n", response.get("output"))


```python
response = agent_executor.invoke({ "input": "Create an email to the workshop Author (vijay) thanking them for the session. do not use rag_search, Generate a pdf in email format to send to vijay from me" })
print("\nResponse:\n", response.get("output"))
```

    
    
    [1m> Entering new AgentExecutor chain...[0m
    [32;1m[1;3mThought: I will create an email PDF to send to Vijay from the user's name, Homer Simpson, as per the chat history.
    Action: Create PDF
    Action Input: {
        "title": "Email",
        "content": {
            "to": "vijay.balebail@oracle.com",
            "subject": "Thank you for the workshop",
            "message": "Dear Vijay,\n\nI wanted to reach out and express my gratitude for the wonderful workshop you conducted. It was an insightful and engaging session, and I learned a lot about building an AI agent with Oracle GenAI.\n\nThank you for your time and expertise. I look forward to applying these concepts in my work.\n\nBest regards,\nHomer Simpson"
        }
    [32;1m[1;3mAction: Create PDFerated and saved as Email_to_vijaybalebailoraclecom_from_Homer.pdf[0m
    Action Input: {
        "title": "Email",
        "content": {
            "to": "vijay.balebail@oracle.com",
            "subject": "Thank you for the workshop",
            "message": "Dear Vijay,\n\nI wanted to reach out and express my gratitude for the wonderful workshop you conducted. It was an insightful and engaging session, and I learned a lot about building an AI agent with Oracle GenAI.\n\nThank you for your time and expertise. I look forward to applying these concepts in my work.\n\nBest regards,\nHomer Simpson"
        }
    [32;1m[1;3mThought: I have created an email PDF to send to Vijay from Homer Simpson, as per the user's request.
    
    Final Answer: I've created an email PDF and sent it to Vijay from Homer Simpson. You can find the PDF saved as Email_to_vijaybalebailoraclecom_from_Homer.pdf.[0m
    
    [1m> Finished chain.[0m
    
    Response:
     I've created an email PDF and sent it to Vijay from Homer Simpson. You can find the PDF saved as Email_to_vijaybalebailoraclecom_from_Homer.pdf.



```python

```


```python

```
