# predictive-maintenance-telemetry
A predictive maintenance system utilizing machine learning to forecast manufacturing equipment failures directly from raw sensor telemetry, bypassing unrealistic diagnostic flags.

## 📌 Project Overview

Predictive maintenance helps industries reduce downtime by identifying potential machine failures before they occur.

This project includes:

- Data Cleaning & Preprocessing
- Exploratory Data Analysis (EDA)
- Machine Failure Analysis
- Machine Learning Models
- SQL-Based Analytics & Reporting
- Risk Classification System

---

## 📂 Dataset

**AI4I 2020 Predictive Maintenance Dataset**

### Features

| Feature | Description |
|----------|-------------|
| UDI | Unique Identifier |
| Product ID | Product Identifier |
| Type | Product Quality Type (L, M, H) |
| Air Temperature [K] | Ambient Temperature |
| Process Temperature [K] | Machine Process Temperature |
| Rotational Speed [rpm] | Machine Rotational Speed |
| Torque [Nm] | Applied Torque |
| Tool Wear [min] | Tool Wear Duration |
| Machine Failure | Failure Status |
| TWF | Tool Wear Failure |
| HDF | Heat Dissipation Failure |
| PWF | Power Failure |
| OSF | Overstrain Failure |
| RNF | Random Failure |

---

## 🎯 Objectives

- Analyze machine operating conditions
- Identify factors contributing to machine failures
- Build predictive maintenance models
- Perform SQL-based failure analysis
- Generate machine risk classifications

---

## 🛠️ Technologies Used

### Python

- Pandas
- NumPy
- Matplotlib
- Seaborn
- Scikit-Learn
- Jupyter Notebook

### Database

- MySQL 8.0

### Machine Learning Models

- Logistic Regression
- Decision Tree Classifier
- Random Forest Classifier

---

## 📊 Exploratory Data Analysis

The notebook includes:

- Dataset Overview
- Missing Value Analysis
- Failure Distribution Analysis
- Product Type Analysis
- Correlation Heatmap
- Feature Importance Analysis
- Failure Pattern Investigation

---

## 🤖 Machine Learning Pipeline

### Data Preprocessing

- Feature Selection
- Encoding Categorical Variables
- Train-Test Split
- Feature Scaling

### Models Trained

#### Logistic Regression
Baseline classification model.

#### Decision Tree
Interpretable classification model.

#### Random Forest
Best-performing predictive maintenance model.

### Evaluation Metrics

- Accuracy
- Precision
- Recall
- F1 Score
- Confusion Matrix

---

## 🗄️ SQL Analysis

### Data Exploration

- Total Records Analysis
- Failure Distribution
- Product Type Statistics

### Failure Analysis

- Failure Rate by Product Type
- Temperature Analysis
- Torque Analysis
- Tool Wear Analysis

### Risk Classification

Machines are categorized into:

- Low Risk
- Medium Risk
- High Risk

using SQL CASE statements.

### Advanced SQL Features

- Views
- Aggregate Functions
- Window Functions
- Summary Tables
- Failure-Type Analysis
- Risk Scoring

---

## 📈 Key Findings

- Tool wear is a significant indicator of machine failure.
- Higher torque values increase failure probability.
- Product type influences reliability.
- Random Forest achieved the highest predictive performance.
- SQL risk scoring successfully identifies high-risk machines.

---

## 📷 Sample Analysis

### Machine Failure Distribution
- Failure vs Non-Failure Comparison

### Correlation Analysis
- Relationship between operating parameters

### Risk Classification
- SQL-based predictive risk categories

---

#  Real-Time Predictive Maintenance from Sensor Telemetry

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/)
[![Scikit-Learn](https://img.shields.io/badge/scikit--learn-latest-orange.svg)](https://scikit-learn.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An end-to-end machine learning project demonstrating how to transition a predictive maintenance model from an artificially perfect "cheated" baseline to a robust, factory-floor-ready deployment using raw sensor data.

---

##  The "Reality Check" (Project Pivot)

### Phase 1: The Baseline Fallacy
Initially, the models included downstream diagnostic flags (`TWF`, `HDF`, `PWF`, `OSF`, `RNF`) as training features. Because these flags trigger *simultaneously* with a breakdown, the models effectively "cheated" by looking at the cause to predict the crash—yielding an unrealistic **F1-Score of 0.98**.

### Phase 2: True Predictive Modeling (Production-Ready)
To simulate a real factory floor, **all diagnostic flags were removed**. The models were forced to forecast failures strictly using raw, real-time sensor telemetry *before* a failure occurs.

---

## 📝 Conclusion

This project demonstrates how Machine Learning and SQL Analytics can be integrated to build a predictive maintenance solution capable of identifying failure patterns, reducing downtime, and improving operational efficiency.

---

