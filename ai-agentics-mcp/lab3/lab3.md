# Lab 2:  Demonstrate AI Agent Reasoning with Examples

### Introduction


Until now the agent and tools are initialized. Now we will call the agent with and ask specific questions to demonstrate how Agent calls apporpirate tools and generates answer.


Estimated Time: 15 min

### Objectives

We'll demonstrate:
1. Demonstrate agent context memory
2. Demonstrate agent ability to use to call RAG tools
3. Demonstrate agent's ability to create PDFs
4. Demonstarte agents ability to access the database.
5. Demonstrate the ability of agent to use all the above tools in iteration to perform complex task.


### Prerequisites

* Have read through the lab 1 and understood the code snippets
* Have got the Sandbox instance created and able to access the noVNC console.


## Example 1: Testing Context Memory - Name Introduction  

This will to used to test if the agent can retrive info from chat context.
We chat with the agent and introduce ourselve and check if it remember our name during the whole conversation. The output is in verbose mode and will trace the activities and thought process of agent. it would be labeled as Observation, Action,  Final answer and Response.

```python
prompt = "My name is Homer Simpson"
result = await run_mcp_agent(prompt)
print("\nResponse:\n", result)
```

    The output would be similar to below
    
    Response:
    Hello, Homer Simpson! How can I assist you today?

Now we ask agent for our name.

```python
prompt = "what is my name ?"
result = await run_mcp_agent(prompt)
print("\nResponse:\n", result)
```

    The output would be similar to below
    
    Your name is Homer Simpson.

Notice it responds back with your name as you entered in Introduction and retained in Contect Memory.

## Example 2: Get name from DB -- Testing reteriving relational data from database

In this example, we'll evaluate the agent's ability to retrieve information from a relational database—a key and powerful capability. By leveraging both the database and the language model, the agent can generate the desired output using its available tools.

To test this, we’ll ask a question that requires accessing the database—for instance, retrieving Vijay’s email address.  

```python
prompt = "what is the details of ashu."
result = await run_mcp_agent(prompt)
print("\nResponse:\n", result)
```
The final response would be like 

````    
Response:
    The details for Ashu are as follows:

    Name: Ashu Kumar
    Email: ashu.kumar@oracle.com

````

### Insert your name and email into the database and verify.

The table is preloaded with few rows with name and email address. Now you can load your name and email address also.  To load your name and email, edit the below sql to put in your first name, last name and email id into the database and verify it exists.  Replace the first name , last name and email and run. 


```python
%sql delete from recipients where first_name='james'

%sql insert into recipients( FIRST_NAME, LAST_NAME, EMAIL) VALUES ('james','bond', 'james.bond@oracle.com')

```

Now run the below sql to query the data we inserted

```python
%sql SELECT first_name, last_name, email FROM recipients 
```

### Verify your email can be retrived from the database.

replace the name with the name you inserted to verify if the agent can retrieve the data from relational table.

```python
result = await run_mcp_agent("what is the email for james")
```

## Example 3: RAG Search -- Test Oracle DB vector search 

This is a demonstration of doing vector search of data stored in Oracle using vector search.
Oracle Vector Store leverages Oracle's database capabilities for efficient similarity search.
For this workshop, **Oracle Table AGENTICS_AI is already loaded with data from file "Oracle 23ai New features"**  So, doing a RAG search on return top N text chunks doing vector search and send the text chunks olong with the question to LLM and return a human reable text.


```python
# Run this cell to test
prompt = "List are 5  features from the document"
result = await run_mcp_agent(prompt)
print("\nResponse:\n", result)
```

The response would be as below

````    
    Response:
        
    Here are five features from the document:

    1. AI Vector Search: This feature involves advanced search capabilities using AI-driven vector analysis.

    2. JSON Relational Duality: This feature suggests a dual approach to handling JSON data in a relational database context.

    3. Operational Property Graphs in SQL: This feature indicates support for property graphs within SQL operations, enhancing data modeling and querying capabilities.

    4. AutoUpgrade Unplug-Plugin Upgrades to Different Systems: This feature involves upgrading systems using a plugin approach, possibly allowing for more flexible and efficient upgrades.

    5. REST APIs for AutoUpgrade: This feature provides RESTful API support for automating upgrade processes, likely improving integration and automation capabilities.


```` 


## Example 4: Creating a Simple PDF -- Test working of Create pdf tool

This is to demonstrate how agent can interact with 3rd party tools. And test how the agent can call the tools available to get to the solution.

```python
# Run this cell to test
prompt = "Create a simple PDF with the title 'Workshop Notes' and content 'This workshop demonstrates building an AI agent with Oracle GenAI."
result = await run_mcp_agent(prompt)
print("\nResponse:\n", result)
```

The final response would be

````
Response:
    I've created a PDF titled 'Workshop Notes'. You can find it saved as Workshop_Notes.pdf.
````
You can check the output file in the file browser. You can double click the filename to view the pdf file.

![Showing the location of PDF file output in Jupyter Notebook](images/location_of_pdf_file_output.png)


## Example 6: Combined Task - Rag Search, fetch_recipients and create PDF

Demonstrating the use of Oracle Vector Search, with 3rd party tools and information from the prompt.
We will further increase the complexity by asking questions requiring the use of multiple tools and context memory.  

```python
prompt = "List 5 new features from the document. Generate a PDF in email format to send to Vijay from Milton"
result = await run_mcp_agent(prompt)
print("\nResponse:\n", result)

```

Check the verbose output to understand how the agent though and action happens.  The final response would be as below.

````
Response:
To: vijay.balebail@oracle.com
Subject: New Features Summary from Document
From: Milton

Message:

Hi Vijay,

I hope this message finds you well. Please find attached a PDF summary of the new features extracted from the document. These features are designed to enhance performance, usability, and security.

New Features:

Enhanced AI Capabilities: The document introduces new AI-driven features that improve automation and decision-making processes.

Improved User Interface: Updates to the user interface make navigation more intuitive and user-friendly.

Expanded Cloud Storage Options: The document highlights new cloud storage solutions that offer greater flexibility and scalability.

Advanced Data Analytics: Enhanced data analytics tools provide deeper insights and more comprehensive reporting capabilities.

Robust Security Enhancements: New security measures have been implemented to protect against emerging threats and vulnerabilities.

Please let me know if you have any questions or need further information.

Best regards,
Milton
````


## Task: Workshop Takeaways

### What We've Learned

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
- Implement more sophisticated tools (database queries, API integrations).
- Explore different memory mechanisms for long-term context.
- Fine-tune the prompt for better handling of edge cases.
- For more understanding RAG Vector Search in Oracle Database 23ai, to look at the live lab [AI Vector Search - Complete RAG Application using PL/SQL in Oracle Database 23ai](https://apexapps.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=3934)
- And also the live lab [AI Vector Search - 7 Easy Steps to Building a RAG Application using LangChain](https://apexapps.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=3927)



You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Vijay Balebail, Rajeev Rumale, Ashu Kumar
* **Contributors** - Milton Wan, Doug Hood
* **Last Updated By/Date** -  Rajeev Rumale, June 2025