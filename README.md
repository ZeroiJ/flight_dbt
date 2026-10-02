# ✈️ Aviation Data Engineering: Phase C1 - Dimensional Modeling with dbt

This repository represents the **C-Tier** of the [Aviation Data Engineering Roadmap](https://github.com/your-username/aviation-de-roadmap). It focuses on taking raw, real-time ADS-B flight pings (ingested during Phase D1) and transforming them into a structured analytics-ready Star Schema using **dbt (data build tool)**.

## 🏗️ Architecture & Lineage

The pipeline processes raw data through a medallion-style approach:

1. **Sources**: Raw flight states (`flight_states`) stored in PostgreSQL.
2. **Staging (`stg_flight_states`)**: Basic cleaning, data type casting, and timestamp parsing.
3. **Intermediate (`int_flights_aggregated`)**: Aggregating individual airplane pings into coherent, unique flight sessions.
4. **Marts (Star Schema)**:
   - `fact_flights`: Incrementally loaded fact table representing individual flights.
   - `dim_aircraft`: Aircraft dimension table with latest seen locations and country origins.
   - `dim_airport`: A dbt seed CSV file simulating global airport locations.

## 🚀 How to Run

1. **Activate Environment**
   ```bash
   source ../dbt-venv/bin/activate
   ```

2. **Load Seed Data (Airports)**
   ```bash
   dbt seed
   ```

3. **Run Models**
   ```bash
   dbt run
   ```

4. **Run Data Quality Tests**
   ```bash
   dbt test
   ```

5. **Generate & Serve Documentation**
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## ✅ Resume Hook
*"Implemented dimensional modeling and automated data quality testing for real-time aviation data using dbt, successfully transforming raw API records into an incremental Star Schema."*
