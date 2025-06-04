# Agentic Architecture and Code Walkthrough

### Introduction

In this workshop we use notebook to demonstrates how to build a powerful AI agent that can search documents, generate PDFs, and handle email-related tasks using LangChain and Oracle GenAI. In this workshop, we'll explore:

1. Setting up the environment and dependencies
2. Creating custom tools for our agent
3. Designing effective prompt templates
4. Initializing and running the agent

Let's get started!

## **Task 1: Environment Setup and Imports**


### Launch Jupyter Lab Notebook

1. From the Activities menu, open a terminal window if it is not already opened.

 ![Open terminal](images/browser.png)

2. From the terminal OS prompt type the following to launch jupyter notebook:

    ```
        $ cd /home/oracle/aidemo
        $ jupyter notebook
    ```

3. Open the notebook **GenAI\_Agent.ipynb**. You can double click or right-click and select **Open**.
   
    ![Open AI Agentics notebook using Jupyter lab](images/open_jupyter_notebook.png)


    If you want to enlarge the window and have larger fonts, you can zoom in with the browser.

    ![Zoom in](images/zoom.png)



### **Imports and Configuration**

We need to import Oracle implementation of Langchain from langchain community.  Addition libraries are imported for PDF generation and standard library.

We are using OracleDB Python Drivers to connect to Oracle database and not cx\_oracle driver, as only the latest driver supports the new feature like Vector Data type. 

To import all the require libararies for this work run the below code.  

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

## **Task 2: Database and Vector Store Setup**

### **Oracle Database Connection**

Connecting to Oracle database using the database username and password which are stored as environment variables (in .env file on linux)

```Python
def create_db_connection():
    Create and return a database connection using environment variables.
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

### **Vector Store Setup**

Vector search is a way to find similar data (like text, images, or audio) by comparing their vector representations which are numerical forms of that data rather than using traditional keyword matching.

Oracle Vector Store leverages Oracle's database capabilities for efficient similarity search.
For this workshop, **Oracle Table AGENTICS\_AI is already loaded with data from file "Oracle 23ai New features"**  So, doing a RAG search on return top N text chunks doing vector search and send the text chunks olong with the question to LLM and return a human reable text.

The model we are using is all-MiniLM-L6-v2. This model has been download as ONNX file and loaded in the database already.

Note: To learn more about creating embedding in database check for live lab ( [AI Vector Search - 7 Easy Steps to Building a RAG Application using LangChain] (https://apexapps.oracle.com/pls/apex/f?p=133:180:6805094326698::::wid:3927) )

Run the below code to initialize the Oracle Vector Store 

```
def setup_vector_store(connection):
    """Set up and return the Oracle Vector Store."""    
    local_model_path = "/home/oracle/.cache/huggingface/hub/models--sentence-transformers--all-MiniLM-L6-v2/snapshots/c9745ed1d9f207416be6d2e6f8de32d1f16199bf"
    embeddings = HuggingFaceEmbeddings(model_name=local_model_path) 
    #embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
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

Note: We are using the embedding model cached locally on disk.

### **Verify the Vector Store table**

To explore the vector store we created, run the sql query to select the first 5 rows of the table that holds the vector data.

```Python
%sql select * from AGENTICS_AI where rownum <= 5
```

The out put shows 4 columns having id, text, meta and embedding.
id is the primary key,  Text column contains the text chunks, meta column contain additional information which can be used for filtering i.e location and page of the chunk, emmbeding column contain the Vector value of text chunk.


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


### **Understanding AI Agent Components**

The diagram shows the core structure of an AI agent: **Tools**, **Model**, and **Prompt** feed into the **Agent**, which is then processed by an **Agent Executor** that incorporates tools and memory. Specifically, the agent is initialized with a model (e.g., `ChatOCIGenAI`), a prompt template (`PromptTemplate.from\_template(...)`), and a set of tools. The `AgentExecutor` then manages the agent’s operations, leveraging tools and memory to execute tasks effectively.
 
![AiArchitectire](images/flowstepsai.jpg)



### **Explanation of Components and Tools**

We’ll define a set of specialized tools that the AI agent will utilize to perform its tasks, aligning with the workflow shown in the diagram:

- **rag\_search**: This tool enables the agent to perform Oracle Vector Search and retrieve Retrieval-Augmented Generation (RAG) answers from a large language model (LLM), enhancing its ability to provide accurate, data-driven responses from Oracle Database 23ai.
  
- **fetch\_recipients**: Designed to look up email addresses based on a given name, this tool allows the agent to dynamically fetch recipient details for email automation tasks, ensuring seamless communication workflows.

- **create\_pdf\_tool**: This tool empowers the agent to generate PDFs, either with a specified title and content or formatted as an email, enabling professional document creation for reporting or sharing purposes.

- **extract\_user\_name**: By accessing the agent’s short-term memory (as part of the `AgentExecutor`’s memory component), this tool retrieves user names from prior conversations, ensuring the agent maintains context and personalizes interactions effectively.

These tools, combined with the model and prompt, are orchestrated by the `AgentExecutor` to enable the AI agent to perform complex, multi-step tasks like data retrieval, email automation, and PDF generation, all while maintaining contextual awareness through memory.
How to Use:
Copy the above content into a text editor.
Save it as AI\_Agent\_Components.md.
Open it in any Markdown viewer or editor (e.g., VS Code, Typora, or GitHub) to see the formatted output.
Let me know if you need further assistance!



## **Task 3: Building Agent Tools**

Python tools are defined similarly to standard Python programs. When using LangChain with Python, tools are essentially Python functions that can operate independently of an agent, as no API abstraction interface is required if the agent and tools share the same language.

### **Tool 1: RAG Search**

In the RAG Search tool we create a function rag\_search. The variables in funcation are 
- query: Input User query about the RAG serch in the document.
- K=5: Specfies the number of top k-chuck to be sent to LLM for generating answer for query. We have to 5, can change as needed.
- content: This variable will hold the result set of similarity search and return as fuction output. 

```Python
def rag_search(query: str) -> str:
    Search for relevant documents using the vector store.
    docs = vector_store.similarity_search(query, k=5)
    content = "\n".join([doc.page_content for doc in docs])
    return content
```

Sample input/output

    Input: Question about the document for a RAG search
    Output: Top 8 pages that have most relavent answers for the question.

### **Tool 2: Fetch Recipients (Database Tool)**

Fetch Recipients tools will query the database table for the first name and last name and return the corresponding email id.  The function fetch\_recipients is created for this.  The parameter used in the function are 

- Input: Takes name of the person
- Output: frist name, last name and email address

```Python
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
Fetch Recipients:

    Input: First Name or Last Name from chat conversation
    Output: email id associated with the name.


### **Tool 3: PDF Creation**

Using Python libraries (reportlab) to generate PDF files


PDF Creation
- **Input**: Well  formed JSON document. which either has title and text, or To, subject and body
- **Output**: A PDF file is created in the current directory.

```Python
def generate_email_pdf(email_data, filename="email.pdf"):
    Generate a PDF from email data.
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

### **Tool 4: User Name Extraction**

The `extract_user_name` tool demonstrates how we can parse this history to extract specific information. This tool extract the name of user's interaction with application i.e., the last question and entire context of conversation.


Username extraction:
- **Input**: Username from memory
- **Output**: Find the name of the user from memory and lookup email if asked to create pdf in email format.

```Python
def format_chat_history(memory_vars):
    Format the last few messages from the chat history for the prompt.
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
    Extract user name from chat history based on 'My name is' pattern.
    chat_hist = memory.load_memory_variables({}).get("chat_history", [])
    for msg in chat_hist:
        if isinstance(msg, HumanMessage):
            name_match = re.search(r"[Mm]y name is (\w+(?:\s+\w+)*)", msg.content)
            if name_match:
                return name_match.group(1)
    return None

```
## **Task 4: Setting up Agent using LangChain.**

### **Agent Memory**

Memory is crucial for agents that need to maintain context over multiple turns.
Our agent uses `ConversationBufferMemory` which:
1. Stores the complete conversation history
2. Makes it available to the agent on each turn
3. Allows the agent to refer back to prior information (like user names)

```
memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)
```

### **Initialize Oracle GenAI Model**

The brain behind the agent is Oracle GenAI, the funcation initializes the specific model using Oracle API keys.

```Python

def initialize_llm():
    Initialize and return the LLM model.
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


### **Creating the Agent Prompt Template**


### **The Importance of Effective Prompt Templates**

A well-crafted prompt template is essential for guiding agent behavior effectively. It should clearly define the agent's role and limitations, establish strict formatting rules (such as enforcing the ReAct structure), and include specific instructions for handling special cases like usernames or conditional actions (e.g., when to generate a PDF). Examples are crucial—they illustrate proper reasoning and the expected format across different scenarios. Additionally, a concise list of available tools with descriptions helps the agent choose the right tool for the task.

Without these components, the agent is likely to produce inconsistent responses, make formatting errors that disrupt the reasoning-action loop, select inappropriate tools, or overlook important contextual information. A strong prompt template ensures consistent, accurate, and context-aware outputs from the agent.



```Python

def create_agent_prompt():
    Create and return the prompt template for the agent.
    template = 
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
    
    return template

```

### **Initilize Agent & Agent\_executor**

We defined tools, models and prompt, next we need to initialize the agent and agent executor.  the agent executor has additional information like number of itrations, versbose mode for logging thought process, and keywords when the answer is found.

![AiArchitectire](images/flowstepsai.jpg)  


### **Agent Initialization Process**

The agent initialization process begins with setting up memory to retain the conversation history, enabling the agent to access prior exchanges at each step. This is followed by configuring the language model—specifically Oracle’s ChatOCIGenAI powered by the Cohere Command-R model—where parameters such as temperature are tuned (e.g., setting it to 0 for deterministic responses).

Next, all tools required by the agent are registered with clear names and descriptions. These descriptions are essential, as they guide the LLM in selecting the appropriate tool during execution. The prompt is then constructed by combining a predefined template with dynamic components such as the tool list and a function to access chat history. This forms the basis for how the agent understands and responds to tasks.

Finally, the agent is created using LangChain’s ReAct agent framework, integrating the configured LLM, tools, and prompt. Execution settings like the maximum number of iterations, verbosity, and error handling are also established to ensure controlled and informative runs. Together, these steps ensure the agent is fully equipped for interactive, tool-augmented reasoning.

The below code snippet initializes the agent

```

def setup_agent():
    """Set up and return the agent executor."""
    # Initialize memory
    memory = ConversationBufferMemory(memory_key="chat_history", return_messages=True)

    # Initialize LLM
    model = initialize_llm()

    # Create tools
    tools = [
        Tool(name="RAG Search", ......),
        Tool(name="fetch_recipients",......),
        Tool(name="Get User Name",.......),
        Tool(name="Create PDF",.....)
    ]

    # Create prompt template
    template = create_agent_prompt()
    prompt = PromptTemplate.from_template(template).partial(....., ......, .....)
        
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

You have completed the Code explaination. We would do code walk through in the next lab.

Please proceed to the next lab.

## Acknowledgements
* **Authors** - Vijay Balebail, Rajeev Rumale
* **Contributors** - Milton Wan, Dough Hood
* **Last Updated By/Date** -  Rajeev Rumale, May 2025