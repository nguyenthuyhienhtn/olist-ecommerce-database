# Olist E-Commerce Database

A relational SQL database modeling Olist, a Brazilian e-commerce marketplace, built to analyze business performance across customers, sellers, products, and orders.

## Overview

This project designs and implements a 7-table relational database using real, publicly available e-commerce data from Olist (via Kaggle), covering over 550,000 records across orders, order items, payments, reviews, products, sellers, and customers.

## Features

- **7 normalized tables** with primary keys, composite keys, and foreign key constraints
- **4 indexes** built to fix full table scans, identified via `EXPLAIN QUERY PLAN`
- **2 views** for repeated analysis (top product categories, average order value by state)
- **Analytical SQL queries** answering business questions such as:
  - Top-performing sellers by revenue
  - Sellers with the best and worst average review scores
  - Repeat customer behavior
  - Best-selling product categories
  - Regional order value trends

## Tech Stack

- **SQLite** for schema design and querying
- **Kaggle's Brazilian E-Commerce Public Dataset by Olist** as the data source

## Files

- [`schema.sql`](./schema.sql) — Database schema: tables, indexes, and views
- [`queries.sql`](./queries.sql) — Example SELECT, INSERT, UPDATE, and DELETE queries
- [`DESIGN.md`](./DESIGN.md) — Full design documentation, including scope, entity relationships, optimizations, and limitations

## Video Overview

https://youtu.be/cB2C6S0mEDA 

## Entity Relationship Diagram

See [`DESIGN.md`](./DESIGN.md) for the full ER diagram and relationship explanations.

---

Built as the final project for [CS50's Introduction to Databases with SQL](https://cs50.harvard.edu/sql/).
