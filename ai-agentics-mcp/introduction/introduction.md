# Building AI Agents with Model Context Protocol (MCP) and Oracle Database 23ai

### Introduction

This workshop demonstrates how to build an AI agent application using LangChain, Oracle Database 23ai, and the Model Context Protocol (MCP)—an open standard that defines how AI agents manage context, memory, and tool usage in a portable and secure way.

MCP acts as the **interoperability layer** between large language models (LLMs), agent logic, tools, and enterprise data systems. It separates agent reasoning from execution, enabling AI systems to scale safely and remain adaptable to different environments or LLMs.

By combining LangChain with Oracle Database 23ai’s AI-native features (Vector Search, JSON, Graph), and using MCP to structure all interactions, this workshop shows how to build enterprise-grade AI agents that are modular, context-aware, and secure.

You’ll learn how to:

* Register MCP tools that wrap Oracle services
* Build agents that follow MCP tasks and tool metadata
* Maintain structured memory and task flows using the MCP format

Estimated Time: 15 min

### Objectives

In this workshop, we'll:

* Set up the development environment
* Use Model Context Protocol (MCP) to standardize agent-tool interactions
* Build MCP-compliant tools for Oracle services (SQL, vector search, PDF)
* Structure prompts and memory using MCP schemas
* Run a reasoning agent that plans, calls tools, and maintains context

Let’s get started.

### Prerequisites

* Oracle LiveLabs account
* Familiarity with Python and LLMs
* Completed: “Complete RAG Application using PL/SQL in Oracle Database 23ai”

---

## Task: Understanding MCP & AI Agents

### What is MCP?

Model Context Protocol (MCP) is an open protocol that defines how AI agents operate:

* It standardizes tool registration, memory, and context
* It allows tools and agents to interact across languages and frameworks
* It enables tool isolation: agents **can only access tools exposed via MCP**, with clear input/output definitions

In short, MCP gives AI agents **a clean, declarative interface** to reason over tasks and securely call external systems.

Instead of hardcoding APIs or database access into agents, you register tools with MCP and let the agent **dynamically discover and invoke** them—based on metadata and real-time decisions.

MCP enables:

* Tool discovery through structured schemas
* Memory and context tracking across agent steps
* Portable agents that work across LLMs, platforms, or runtimes

It’s the **standard glue** for safe and scalable AI agents.

---

### What Are AI Agents?

AI agents are systems that use LLMs to plan, reason, and take actions to complete tasks. Unlike simple chatbots, agents think through problems step-by-step and interact with external tools.

An agent becomes truly powerful when it can:

* Understand intent from user input
* Choose from a list of registered tools
* Call tools securely and evaluate the output
* Track task progress using memory and context

With MCP, all of these steps happen in a **structured**, **repeatable**, and **governable** way.

---

### Why MCP Matters for AI Agents

In traditional systems, tool access is hardcoded into the agent logic. This makes it difficult to:

* Apply security controls
* Swap tools or APIs
* Track usage or enforce compliance

MCP solves this by decoupling the **agent’s brain (LLM reasoning)** from the **hands (tools)** and **memory (context store)**.

With MCP, your agent:

* Requests a task plan
* Sees the available tools via MCP metadata
* Calls tools through a secure interface
* Uses observations to continue reasoning

This enables **fine-grained control**, easy debugging, and safe scalability—critical for production GenAI systems in Oracle environments.

---

## AI Agent Architecture with MCP

An MCP-powered agent system includes:

* **Planner**: Determines task steps
* **MCP Tool Server**: Hosts tools the agent can call
* **Memory**: Tracks history and intermediate steps
* **LLM**: Powers reasoning and decision making
* **Context**: Carries structured task metadata

Oracle Database 23ai complements this by offering:

* AI Vector Search tools
* Relational/JSON queries
* Stored memory in a converged format
* Graph reasoning

MCP acts as the **middleware protocol**, enabling consistent interaction across all these components.

---

### Agent Components in an MCP System

| Component | Description                           | Oracle Example                 |
| --------- | ------------------------------------- | ------------------------------ |
| Tools     | Wrapped APIs/services exposed via MCP | SQL query, vector search, PDF  |
| Prompts   | Standardized task definitions         | “Summarize this document”      |
| Model     | Reasoning engine (LLM)                | OpenAI, Cohere, OCI model      |
| Memory    | Structured memory store               | JSON stored in Oracle DB       |
| Planner   | Selects next step/tool                | Chooses based on tool metadata |
| Context   | MCP-formatted task metadata           | Inputs, tools, prior steps     |

---

## Learn More

* [MCP Protocol Overview](https://modelcontextprotocol.io/)
* [Oracle MCP + OCI Blog](https://blogs.oracle.com/ai-and-datascience/post/unleashing-the-power-of-mcp-with-oracle-oci-genai)
* [LangChain MCP Adapter](https://github.com/langchain-ai/langchain-mcp-adapter)
* [Oracle Vector Search Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/vecse/index.html)

You may now [proceed to the next lab](#next).

---

## Acknowledgements

* Authors – Vijay Balebail, Rajeev Rumale, Ashu Kumar
* Contributors – Milton Wan, Doug Hood
* Last Updated – Rajeev Rumale, June 2025