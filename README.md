# predictive-maintenance-telemetry
A predictive maintenance system utilizing machine learning to forecast manufacturing equipment failures directly from raw sensor telemetry, bypassing unrealistic diagnostic flags.

#  Real-Time Predictive Maintenance from Sensor Telemetry

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/)
[![Scikit-Learn](https://img.shields.io/badge/scikit--learn-latest-orange.svg)](https://scikit-learn.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An end-to-end machine learning project demonstrating how to transition a predictive maintenance model from an artificially perfect "cheated" baseline to a robust, factory-floor-ready deployment using raw sensor data.

---

##  Dataset Overview
The project utilizes the **AI4I 2020 Predictive Maintenance Dataset** (10,000 samples), reflecting real-world telemetry from a milling machine:
*   **Sensor Telemetry:** Air/Process Temperature ($K$), Rotational Speed ($rpm$), Torque ($Nm$), and Tool Wear ($min$).
*   **Target:** `Machine failure` (Highly imbalanced: 339 failures vs. 9,661 normal operations).

---

##  The "Reality Check" (Project Pivot)

### Phase 1: The Baseline Fallacy
Initially, the models included downstream diagnostic flags (`TWF`, `HDF`, `PWF`, `OSF`, `RNF`) as training features. Because these flags trigger *simultaneously* with a breakdown, the models effectively "cheated" by looking at the cause to predict the crash—yielding an unrealistic **F1-Score of 0.98**.

### Phase 2: True Predictive Modeling (Production-Ready)
To simulate a real factory floor, **all diagnostic flags were removed**. The models were forced to forecast failures strictly using raw, real-time sensor telemetry *before* a failure occurs.

---

## 🏆 Model Performance Comparison

After stripping the diagnostic flags, the models were evaluated strictly on raw operational signals:

| Model | Precision (Failures) | Recall (Failures) | F1-Score | Notes |
| :--- | :---: | :---: | :---: | :--- |
| **Random Forest Classifier** | **83.7%** | **59.0%** | **0.692** | ⭐ **Winner:** Low false-alarm rate; highly reliable for maintenance dispatch. |
| **Logistic Regression** | 64.0% | 26.2% | 0.372 | Failed to capture complex non-linear relations (e.g., Torque vs. RPM). |
