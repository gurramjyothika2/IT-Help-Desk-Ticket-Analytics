-- IT Help Desk Ticket Analytics & SLA Prediction
-- Compatible with MySQL 8+ / PostgreSQL with minor syntax adjustments.

CREATE TABLE helpdesk_tickets (
    Ticket_ID VARCHAR(20) PRIMARY KEY,
    Created_Date DATE,
    Created_Hour INT,
    Department VARCHAR(50),
    Category VARCHAR(50),
    Priority VARCHAR(20),
    Assigned_Agent VARCHAR(50),
    Status VARCHAR(30),
    First_Response_Hours DECIMAL(10,2),
    Resolution_Time_Hours DECIMAL(10,2),
    SLA_Target_Hours DECIMAL(10,2),
    SLA_Breached INT,
    Customer_Satisfaction DECIMAL(3,1)
);

-- KPI 1: Total tickets
SELECT COUNT(*) AS total_tickets FROM helpdesk_tickets;

-- KPI 2: SLA breach rate
SELECT ROUND(100.0 * SUM(SLA_Breached) / COUNT(*), 2) AS sla_breach_rate_pct
FROM helpdesk_tickets;

-- KPI 3: Average resolution time
SELECT ROUND(AVG(Resolution_Time_Hours), 2) AS avg_resolution_hours
FROM helpdesk_tickets;

-- KPI 4: Tickets by priority
SELECT Priority, COUNT(*) AS ticket_count
FROM helpdesk_tickets
GROUP BY Priority
ORDER BY ticket_count DESC;

-- KPI 5: Category performance
SELECT
    Category,
    COUNT(*) AS tickets,
    ROUND(AVG(Resolution_Time_Hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * SUM(SLA_Breached) / COUNT(*), 2) AS breach_rate_pct
FROM helpdesk_tickets
GROUP BY Category
ORDER BY breach_rate_pct DESC;

-- KPI 6: Agent performance
SELECT
    Assigned_Agent,
    COUNT(*) AS tickets_handled,
    ROUND(AVG(Resolution_Time_Hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * SUM(SLA_Breached) / COUNT(*), 2) AS breach_rate_pct,
    ROUND(AVG(Customer_Satisfaction), 2) AS avg_customer_satisfaction
FROM helpdesk_tickets
GROUP BY Assigned_Agent
ORDER BY breach_rate_pct ASC;

-- KPI 7: Monthly trend
SELECT
    EXTRACT(YEAR FROM Created_Date) AS year,
    EXTRACT(MONTH FROM Created_Date) AS month,
    COUNT(*) AS tickets,
    ROUND(AVG(Resolution_Time_Hours), 2) AS avg_resolution_hours,
    ROUND(100.0 * SUM(SLA_Breached) / COUNT(*), 2) AS breach_rate_pct
FROM helpdesk_tickets
GROUP BY EXTRACT(YEAR FROM Created_Date), EXTRACT(MONTH FROM Created_Date)
ORDER BY year, month;

-- KPI 8: High-risk tickets for operational review
SELECT *
FROM helpdesk_tickets
WHERE SLA_Breached = 1
   OR (Priority IN ('High','Critical') AND Status NOT IN ('Resolved','Closed'))
ORDER BY Priority DESC, Resolution_Time_Hours DESC;