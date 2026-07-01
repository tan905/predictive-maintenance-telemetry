    SELECT * FROM ai4i2020;
    
    SELECT COUNT(*) AS total_records
FROM ai4i2020;
-- total 935 records 

-- data analysis 
-- check if any missing data 
SELECT 
    SUM(CASE WHEN `ï»¿UDI` IS NULL THEN 1 ELSE 0 END) AS Null_UDI,
    SUM(CASE WHEN `Product ID` IS NULL THEN 1 ELSE 0 END) AS Null_ProductID,
    SUM(CASE WHEN `Air temperature [K]` IS NULL THEN 1 ELSE 0 END) AS Null_AirTemp,
    SUM(CASE WHEN `Process temperature [K]` IS NULL THEN 1 ELSE 0 END) AS Null_ProcessTemp
FROM ai4i2020;

-- count of failure 
SELECT
    `Machine failure`,
    COUNT(*) AS count
FROM ai4i2020
GROUP BY `Machine failure`; 


-- type of machines 
SELECT 
    `Product ID`,
    Type,
    CASE 
        WHEN Type = 'H' THEN 0
        WHEN Type = 'L' THEN 1
        WHEN Type = 'M' THEN 2
    END AS Type_Encoded
FROM ai4i2020 LIMIT 5;

-- failure rate by product type 
SELECT
    Type,
    COUNT(*) AS total_machines,
    SUM(`Machine failure`) AS failures,
    ROUND(
        SUM(`Machine failure`) * 100 / COUNT(*),
        2
    ) AS failure_rate
FROM ai4i2020
GROUP BY Type;

-- breakdown by failure mode 
SELECT
    SUM(TWF) AS tool_wear_failures,
    SUM(HDF) AS heat_dissipation_failures,
    SUM(PWF) AS power_failures,
    SUM(OSF) AS overstrain_failures,
    SUM(RNF) AS random_failures,
    SUM(`Machine failure`) AS total_failures
FROM ai4i2020;

-- which failure mode dominates by product type 
SELECT
    Type,
    SUM(TWF) AS twf, SUM(HDF) AS hdf, SUM(PWF) AS pwf,
    SUM(OSF) AS osf, SUM(RNF) AS rnf
FROM ai4i2020
GROUP BY Type;

-- failure type that occur the most 
SELECT
    SUM(TWF) AS Tool_Wear_Failure,
    SUM(HDF) AS Heat_Dissipation_Failure,
    SUM(PWF) AS Power_Failure,
    SUM(OSF) AS Overstrain_Failure,
    SUM(RNF) AS Random_Failure
FROM ai4i2020;

-- Ranking machines by tool wear within each type 
SELECT
    `Product ID`, Type, `Tool wear [min]`,
    RANK() OVER (PARTITION BY Type ORDER BY `Tool wear [min]` DESC) AS wear_rank
FROM ai4i2020;

-- Risk machines 
SELECT
    `Product ID`,
    `Tool wear [min]`,
    `Torque [Nm]`,
    (`Tool wear [min]`*0.4 + `Torque [Nm]`*0.6) AS Risk_Score
FROM ai4i2020
ORDER BY Risk_Score DESC
LIMIT 10;

-- Abnormal machines 
SELECT *
FROM ai4i2020
WHERE `Torque [Nm]` >
(
    SELECT AVG(`Torque [Nm]`)
           + 2*STDDEV(`Torque [Nm]`)
    FROM ai4i2020
);


-- Tempearture analysis 
SELECT
    `Machine failure`,
    AVG(`Air temperature [K]`) AS avg_air_temp,
    AVG(`Process temperature [K]`) AS avg_process_temp
FROM ai4i2020
GROUP BY `Machine failure`;

-- Torque analysis 
SELECT
    `Machine failure`,
    AVG(`Torque [Nm]`) AS avg_torque,
    MAX(`Torque [Nm]`) AS max_torque
FROM ai4i2020
GROUP BY `Machine failure`;

-- Tool wear risk analysis 
SELECT
CASE
    WHEN `Tool wear [min]` < 100 THEN 'Low'
    WHEN `Tool wear [min]` BETWEEN 100 AND 200 THEN 'Medium'
    ELSE 'High'
END AS Wear_Category,
COUNT(*) AS Total,
SUM(`Machine failure`) AS Failures
FROM ai4i2020
GROUP BY Wear_Category;

-- Risk analysis 
SELECT
    `ï»¿UDI`,
    `Torque [Nm]`,
    `Tool wear [min]`,
    CASE
        WHEN `Tool wear [min]` > 200
             AND `Torque [Nm]` > 50
        THEN 'High Risk'

        WHEN `Tool wear [min]` > 100
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS Risk_Level
FROM ai4i2020;

-- Suggested Conditions 
SELECT *,
CASE
    WHEN (`Tool wear [min]`*0.4 + `Torque [Nm]`*0.6) > 120
    THEN 'Critical'
    WHEN (`Tool wear [min]`*0.4 + `Torque [Nm]`*0.6) > 80
    THEN 'Warning'
    ELSE 'Normal'
END AS Status
FROM ai4i2020;
-- machine health 
CREATE VIEW MachineHealth AS
SELECT
    `Product ID`,
    Type,
    `Torque [Nm]`,
    `Tool wear [min]`,
    `Machine failure`
FROM ai4i2020;

-- predict risk 
DELIMITER $$
CREATE PROCEDURE PredictRisk(
IN wear INT,
IN torque FLOAT
)
BEGIN
    IF wear > 200 AND torque > 50 THEN
        SELECT 'High Risk';
    ELSE
        SELECT 'Low Risk';
    END IF;
END$$
DELIMITER ;

-- summary
CREATE TABLE failure_summary AS
SELECT
    Type,
    COUNT(*) AS TotalMachines,
    SUM(`Machine failure`) AS TotalFailures
FROM ai4i2020
GROUP BY Type;

