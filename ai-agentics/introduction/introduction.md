# Build an Agentic AI application with LangChain and Oracle Database 23ai

## **Introduction**

This workshop is to show how to build an AI Agent application using LangChain and Oracle Database 23ai. We will discuss how an Agent is initialized, makes calls to tools, and uses context memory. Once you understand the building components of an Agent, the applications that you build using AI Agentic frameworks are limitless.

Oracle Database 23ai is a converged database that includes support for AI Vector Search, Graph, JSON, Machine Learning, and many more AI features. By showing how an AI agent can interact with the Oracle database, an architect can design an application harnessing the power of the Oracle converged database with GenAI LLMs.

In this workshop, we will demonstrate how to build a powerful AI agent that performs AI Vector Search, queries relational databases, generates PDFs, and handles email-related tasks using LangChain with Oracle GenAI service. This hands-on workshop teaches you how to build AI agents with Python and LangChain using Oracle Database 23ai. Learn to design prompts, create custom tools, and use memory for maintaining the context of the LLM. Using LangChain, participants will gain skills with one of the many AI Agentic frameworks to develop cutting-edge AI solutions, showcasing Oracle Database 23ai.


Estimated Time:  15 min

### Objectives

In this workshop, we'll perform the following:

* Setting up the environment and dependencies
* Creating custom tools for our AI agent
* Designing effective prompt templates
* Initializing and running the AI agent


Let's get started!


### Prerequisites
* An Oracle LiveLabs Account
* Check out Livelab - Complete RAG Application using PL/SQL in Oracle Database 23ai


## Task: Understanding AI Agents


### **What are AI Agents?**

An AI or LLM Agent is a reasoning framework built around a Large Language Model (LLM) that can interpret user input, reason through it step by step, and autonomously use external tools (like vector search, relational queries email, or PDF generators) to accomplish tasks, not just a chatbot that responds, but a system that plans, decides, and acts.

It's like giving the LLM: a brain to reason and remember (via prompts and memory),
eyes and ears to read documents or look up information (via tools),
and hands to take action (e.g., sending emails, generating PDFs).
 

### **Why AI Agents Matter?**
AI agents are transforming industries by automating sophisticated workflows, boosting productivity, and enabling intelligent, scalable solutions. Integrated with databases like Oracle Database 23ai, they enhance tasks such as enterprise customer support and data analysis, reducing costs and errors. For developers, mastering AI agents unlocks opportunities to build innovative, competitive solutions.

### **Understanding the AI Agent Architecture**

AI Agent systems have the following characteristics:

Plan and Reason: Analyze a task and determine the necessary steps.
Tools: Execute functions to gather information or perform actions.
Maintain Context: Remember conversation history and previous actions.
Make Decisions: Choose appropriate next steps based on observations.
Reasoning: The agent thinks through the problem.
Acting: The agent takes action based on reasoning.
Observation: The agent observes the result.
Repeat: Until the task is complete.

### **Agent Components**

AI agents rely on the following components for functionality:
Tools: External resources or APIs (e.g., database queries, email services, PDF generation).
Prompts: Instructions guiding the agent’s behavior for accurate outputs.
Model: The AI model (e.g., GPT, LLaMA) powering reasoning and decisions.
Memory: Contextual memory for retaining prior interactions in multi-step tasks.
Planner: Breaks down tasks into steps, selecting tools and actions.
Environment: Data sources like Oracle Database 23ai for processing information.

 ![AI Agent Architecture](images/ai-architecture.jpg )


### Learn More

See below for more information on Oracle Database 23ai and Oracle AI Vector Search

* [Oracle AI Agentic Blog](https://medium.com/oracledevs/how-to-build-a-conversational-ai-agent-in-just-a-few-steps-fb40a1bad004)
* [Oracle AI Vector Search User's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/index.html)
* [Oracle AI Vector Search Blog](https://blogs.oracle.com/database/post/oracle-announces-general-availability-of-ai-vector-search-in-oracle-database-23ai)



You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** - Vijay Balebail, Rajeev Rumale
* **Contributors** - Milton Wan, Doug Hood
* **Last Updated By/Date** -  Rajeev Rumale, June 2025
