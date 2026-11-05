# IT Help Desk Ticket Analytics & SLA Prediction

## Project Overview
A portfolio-ready data analytics and machine learning project that analyzes IT help desk
tickets, measures SLA performance, identifies operational bottlenecks, and predicts the
risk of an SLA breach.

## Tech Stack
- Python
- Pandas
- Scikit-learn
- SQL
- Power BI
- Excel/CSV
- GitHub

## Business Problem
IT support teams need to resolve tickets within agreed service-level targets. Delays can
reduce customer satisfaction and increase operational workload. This project provides:
1. Descriptive analytics of help desk performance.
2. SQL-based operational reporting.
3. A Power BI dashboard.
4. A machine-learning model that predicts SLA breach risk.

## Project Structure
- data/helpdesk_tickets.csv -> 1,000 sample tickets
- sql/helpdesk_analysis.sql -> table + analytics queries
- sla_prediction.py -> trains and evaluates the ML model
- predict_ticket.py -> predicts breach risk for a new ticket
- powerbi/PowerBI_Dashboard_Guide.md -> dashboard build instructions
- requirements.txt -> Python packages

## How to Run
### 1. Install dependencies
pip install -r requirements.txt

### 2. Train the model
python sla_prediction.py

### 3. Predict a new ticket
python predict_ticket.py

### 4. SQL
Create the table and load `data/helpdesk_tickets.csv` into MySQL/PostgreSQL,
then run `sql/helpdesk_analysis.sql`.

### 5. Power BI
Follow `powerbi/PowerBI_Dashboard_Guide.md`.

## Key Resume Bullet
Built an IT Help Desk Ticket Analytics & SLA Prediction solution using SQL, Python,
Power BI and machine learning to analyze 1,000 support tickets, monitor SLA compliance,
identify operational trends, and predict potential SLA breaches.

## Important Portfolio Note
The dataset is synthetic and created for portfolio/learning purposes. Clearly label it
as synthetic data on GitHub and in interviews.