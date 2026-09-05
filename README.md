# Retail Sales Analysis — SQL Project

**Author:** Frank Agba Onwuchekwa
**Tools:** MySQL 8.0, MySQL Workbench
**Skills demonstrated:** Data cleaning, database design, exploratory data analysis (EDA), window functions, CTEs, business-question-driven SQL

---

## Why this project matters

Retail businesses generate huge volumes of transactional data every day — but raw data alone answers no questions. This project takes a raw, messy retail sales export (missing values, inconsistent formatting) and turns it into a clean, queryable database that answers real business questions: *When do we sell the most? Who are our best customers? Which categories drive revenue? What time of day should we staff for?*

This is the kind of end-to-end workflow — **ingest → clean → validate → analyze → answer business questions** — that a data analyst is expected to own independently in a live business setting.

---

## Business Problem

A retail store needed to understand its sales performance across categories, customer demographics, and time periods, but had no structured way to query or report on that data. This project builds the database layer and analytical queries needed to support that decision-making.

---

## What This Project Demonstrates

| Skill | Where it shows up |
|---|---|
| Database design | Designing a normalized table schema from a raw CSV |
| Data ingestion at scale | Bulk-loading a CSV via `LOAD DATA INFILE`, handling encoding and file-path issues |
| Data quality / cleaning | Identifying and removing incomplete records (`NULL` handling) before analysis |
| Exploratory Data Analysis (EDA) | Row counts, unique customer counts, category distribution |
| Business-question SQL | Translating plain-English business questions into precise SQL queries |
| Intermediate/advanced SQL | `CASE` statements, `GROUP BY`, `RANK() OVER (PARTITION BY ...)` window functions, Common Table Expressions (CTEs) |
| Attention to data integrity | Verifying row counts before and after cleaning to confirm no silent data loss |

---

## Dataset

A retail transactions dataset containing:

| Column | Description |
|---|---|
| `transactions_id` | Unique transaction identifier |
| `sale_date`, `sale_time` | Date and time of sale |
| `customer_id` | Unique customer identifier |
| `gender`, `age` | Customer demographics |
| `category` | Product category (e.g. Clothing, Beauty, Electronics) |
| `quantiy` | Units sold |
| `price_per_unit` | Unit price |
| `cogs` | Cost of goods sold |
| `total_sale` | Total transaction value |

---

## Project Workflow

### 1. Database & Table Setup
Created a dedicated schema and table with appropriate data types for each field (`DATE`, `TIME`, `INT`, `FLOAT`, `VARCHAR`), ensuring the structure matched the source data before import.

### 2. Data Import
Loaded the raw CSV using `LOAD DATA LOCAL INFILE`, explicitly converting empty CSV fields to true SQL `NULL` values with `NULLIF()` — rather than allowing rows with missing values to be silently dropped, which is the default (and easy-to-miss) behavior of GUI import wizards.

### 3. Data Cleaning
Queried for and removed any transaction record with a `NULL` in a required field, then verified the row count post-cleaning to confirm data integrity.

### 4. Exploratory Data Analysis
Established baseline metrics: total transaction count, total unique customers — the starting point for any deeper analysis.

### 5. Business Question Analysis
Answered a set of realistic business questions retail stakeholders would actually ask, including:

- Sales activity on a specific date
- High-quantity category-specific transactions within a date range
- Revenue and order volume by category
- Average customer age by category (targeting/segmentation insight)
- High-value transaction identification
- Transaction volume by gender and category (segmentation)
- **Best-performing month per year**, using a window function (`RANK() OVER PARTITION BY`) inside a CTE
- Top 5 customers by total spend (VIP/loyalty candidates)
- Unique customer count per category (category reach)
- **Sales by shift** (Morning / Afternoon / Evening) — an operational insight for staffing decisions

### 6. Key Insights *(fill in after running the queries against your own results)*
- Top-performing category by revenue: `[insert]`
- Best month for sales: `[insert]`
- Top 5 customers contributed `[insert]`% of total revenue
- Busiest shift: `[insert]`
- Average customer age in the Beauty category: `[insert]`

> *Note for reviewers: the queries in this project are fully written and tested; the specific numeric findings above are intentionally left as placeholders here so they can be populated with results from a live run against the dataset.*

---

## How to Run This Project

1. Open MySQL Workbench (or any MySQL client) and connect to a local or remote MySQL 8.0+ instance.
2. Ensure the client allows local file loading (`OPT_LOCAL_INFILE=1` in the connection's Advanced settings, and `SET GLOBAL local_infile = 1;` on the server).
3. Update the file path in the `LOAD DATA LOCAL INFILE` statement to point to your local copy of the CSV.
4. Run `sql_retail_sales.sql` from top to bottom.
5. Review the output of each analytical query in the Result Grid.

---

## What This Project Shows About How I Work

- I don't just write queries — I catch and fix data quality problems before they silently corrupt an analysis (e.g. the default GUI import wizard behavior of dropping incomplete rows without warning).
- I write SQL that answers specific, stakeholder-relevant business questions, not just generic exploratory queries.
- I'm comfortable with intermediate SQL techniques (CTEs, window functions) used to answer questions that a simple `GROUP BY` can't.
- I document my process clearly enough for someone else — a teammate, a hiring manager — to follow, re-run, and verify.

---

## Possible Extensions

- Connect this database to Power BI or Tableau for an interactive dashboard layer.
- Automate the cleaning/import step as a repeatable ETL pipeline.
- Add cohort or retention analysis on top of the existing customer-level queries.
