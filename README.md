# Jaffle Shop: Semantic Layer & Sales Insights POC

This project extends the classic dbt Labs "Jaffle Shop" dataset to serve as a Proof of Concept (POC) for a modern data workflow designed to empower sales teams.

The fundamental philosophy is to provide sales engineers with "genie insights" via a **"Customer on a Page"** view, transforming their pre-call research ritual. This repository contains the foundational backend for that vision: a live, queryable dbt Semantic Layer served via the dbt Mesh Conceptual Protocol (`dbt-mcp`).

## Project Purpose

In today's SaaS landscape, sales engineers spend valuable time manually gathering fragmented customer information before a call. This POC demonstrates how to solve that problem by building a "single source of truth" for customer metrics.

The goal is to provide the data foundation for a pre-call sales tool that can answer critical questions instantly:
* What is this customer's product adoption level?
* Are they at risk of overages?
* What is their payment history and financial health?
* What are the key opportunities for up-sell or cross-sell?

This repository focuses on **Step 1:** Building and serving the live, governed metrics that would power such a tool.

## Core Concepts Demonstrated

* **dbt Core:** Building and running a modern dbt project.
* **dbt Semantic Layer:** Defining consistent, reusable business metrics (measures, dimensions).
* **MetricFlow Time Spine:** Correctly configuring a project for robust time-based analysis.
* **dbt-mcp:** Serving live metrics via a GraphQL API.
* **Foundational Backend:** Creating the engine for a future AI-powered front-end application.

---

## Getting Started

This project is configured to run seamlessly in a GitHub Codespace.

### 1. Launch the Environment

Simply open this repository in a GitHub Codespace. The environment will be automatically built and configured based on the `.devcontainer/devcontainer.json` file, which installs Python 3.12 and all necessary dependencies.

### 2. Build the Data Warehouse

Once the environment is ready and you have a terminal open, run the following commands.

```bash
# First, install the dbt packages (like dbt-utils) listed in packages.yml
dbt deps

# Next, load all seed data and build all models, including the time spine
dbt run
```
After this step, your DuckDB data warehouse will be fully built and ready.

### 3. Run the Semantic Layer Server

With the project built, you can now bring the semantic layer online.

```bash
# Start the server on port 8008
dbt-mcp serve --port 8008
```

The server is now running and ready to accept queries.

### 4. Query the Server

The server exposes a GraphQL endpoint. You can query it from any application, or directly from the command line using `curl`.

Open a **new terminal tab** (`Ctrl+Shift+5` or via the Command Palette) and run the following command to query the `order_total` metric, grouped by month:

```bash
curl --location --request POST 'http://localhost:8008/graphql' \
--header 'Content-Type: application/json' \
--data-raw '{
    "query": "query { metrics(metrics: [\"order_total\"], groupBy: [{name: \"order_date\", granularity: \"MONTH\"}]) { data } }"
}' | python -m json.tool
```
You will receive a JSON response with the requested metric data, proving the entire backend is working correctly.

## Next Steps

This repository is the foundation. The logical next steps in this project are:
1.  **Build the "Customer on a Page" UI:** Create a front-end application (e.g., with Streamlit) that consumes the GraphQL API.
2.  **Integrate the Cognitive Layer:** Pass the JSON metric data to a Large Language Model (e.g., Google's Gemini) with a custom prompt to generate natural language summaries, insights, and talking points for the sales engineer.
3.  **Expand the Semantic Model:** Define more complex and valuable business metrics to enrich the "Customer on a Page" view.

---

### Original Jaffle Shop Context

This project is based on the dbt Labs Jaffle Shop project, a demonstration of a dbt project for a fictional e-commerce store. It's a great way to learn the fundamentals of dbt and data transformation.
