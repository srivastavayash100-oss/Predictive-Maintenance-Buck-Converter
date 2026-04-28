# Predictive Maintenance of a Power Converter Using Electrical Signal Features and Machine Learning in MATLAB

## 📌 Project Overview
This project focuses on the **Predictive Maintenance (PdM)** of DC-DC Buck Converters. Instead of traditional reactive maintenance, this system uses **Physical Modeling** and **Machine Learning** to detect early-stage degradation in critical components like MOSFETs and Electrolytic Capacitors.

Developed as part of my **Minor Project - 2 (Semester VI)** at JIIT, Noida, under the supervision of **Dr. Ankur Bhardwaj**.

## 🛠️ Technical Implementation
The project bridges the gap between power electronics and AI through a three-stage pipeline:

### 1. High-Fidelity Simulink Modeling
A realistic Buck Converter was implemented using the **Simscape Electrical** library. 
- **Solver Optimization:** Used **Powergui (Discrete/Tustin)** to eliminate algebraic loops and ensure stable data generation.
- **Fault Modeling:** Specifically modeled **ESR (Equivalent Series Resistance)** increase in capacitors and **$R_{ds(on)}$** variation in MOSFETs.

### 2. Automated Feature Engineering
Using `run_project.m`, the system extracts high-dimensional data from the simulation:
- **$V_{mean}$:** Average output voltage monitoring.
- **$I_{rms}$:** Root Mean Square of the Drain Current to detect switching anomalies.
- **$V_{pp}$:** Peak-to-Peak ripple analysis (Primary indicator for Capacitor health).

### 3. Machine Learning Architecture
We implemented a **Multi-class SVM (Support Vector Machine)** using a One-vs-One approach with an **RBF Kernel**.
- **Normalization:** Z-score scaling was applied to handle the varying magnitudes of voltage and current.
- **Validation:** Performance was verified using Confusion Matrices and ROC Curves, achieving near 100% classification accuracy.

## 🧠 Engineering Insights (From My Technical Notes)
During development, I resolved several critical hardware-software integration issues:
* **Thermal Isolation:** Fixed MOSFET Junction Temperature ($T_j$) at 25°C to ensure the model learns from *electrical degradation* rather than thermal noise.
* **Algorithm Selection:** * **Vs. KNN:** SVM is more efficient for **Edge Computing** as it doesn't need to store the entire dataset for inference.
    * **Vs. Neural Networks:** Since we have a structured dataset with 3 key features, SVM provides a clear mathematical margin without the "overkill" of a Deep Learning model.
* **Realistic Fault Injection:** Chose a 0.9 $\Omega$ fault resistance to simulate **early-stage wear-and-tear** instead of a total short-circuit, which is crucial for true predictive maintenance.

## 📂 Repository Contents
- `/Model`: Simulink `.slx` file and circuit diagrams.
- `/Scripts`: MATLAB scripts for data generation and SVM training.
- `/Report`: Full Minor Project Report and Synopsis.
- `Final_Dataset.csv`: The generated synthetic dataset.

## 👥 Team
- **Yash Srivastava** (Lead Developer)
- **Md Nawaz Alam**
