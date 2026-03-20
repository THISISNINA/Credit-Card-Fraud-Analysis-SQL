/* Credit Card Fraud Detection Analysis */

-- Database and Table Setup
CREATE DATABASE IF NOT EXISTS credit_card_analysis;
USE credit_card_analysis;

CREATE TABLE cc_transactions (
	Time INT,
    V1 FLOAT, V2 FLOAT, V3 FLOAT, V4 FLOAT, V5 FLOAT,
    V6 FLOAT, V7 FLOAT, V8 FLOAT, V9 FLOAT, V10 FLOAT,
    V11 FLOAT, V12 FLOAT, V13 FLOAT, V14 FLOAT, V15 FLOAT,
    V16 FLOAT, V17 FLOAT, V18 FLOAT, V19 FLOAT, V20 FLOAT,
	V21 FLOAT, V22 FLOAT, V23 FLOAT, V24 FLOAT, V25 FLOAT,
    V26 FLOAT, V27 FLOAT, V28 FLOAT,
    Amount DECIMAL(10,2),
    Class INT
);

-- Analyzing Class Imbalance (Fraud vs. Normal)
SELECT
	Class,
    COUNT(*) as transaction_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cc_transactions), 2) as percentage
FROM cc_transactions
GROUP BY Class;

-- Descriptive Statistics for Transaction Amounts
SELECT 
	Class,
    MIN(Amount) as min_val,
    AVG(Amount) as avg_val,
    MAX(Amount) as max_val,
    STDDEV(Amount) as std_deviation
FROM cc_transactions
GROUP BY Class;

-- HOurly Distribution of Fraudulent Activity
SELECT 
	FLOOR(Time/3600) as hour_of_day,
    COUNT(*) as fraud_count
FROM cc_transactions
WHERE Class= 1
GROUP BY hour_of_day
ORDER BY fraud_count DESC
LIMIT 10;

-- High value Fraudulent Transactions
SELECT * FROM cc_transactions
WHERE Class = 1 AND Amount > 1000
ORDER BY Amount DESC;
