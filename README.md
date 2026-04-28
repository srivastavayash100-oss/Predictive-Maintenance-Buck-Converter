# Predictive Maintenance of a Power Converter Using Electrical Signal Features and Machine Learning in MATLAB

## 📌 Project Overview
This project focuses on the **Predictive Maintenance (PdM)** of DC-DC Buck Converters. By bridging **Simulink-based physical modeling** with **Multi-class SVM classification**, the system identifies early-stage degradation in MOSFETs and Electrolytic Capacitors. 

Developed as part of my **Minor Project - 2 (Semester VI)** at JIIT, Noida, under the guidance of **Dr. Ankur Bhardwaj**.

## 🛠️ Technical Implementation
The project follows a robust three-stage engineering pipeline:

### 1. High-Fidelity Simulink Implementation
A realistic Buck Converter was designed to simulate hardware behavior under various health conditions.
- **Solver Optimization:** Used **Powergui (Discrete/Tustin)** mode to resolve algebraic loops and optimize simulation speed for dataset generation.
- **Fault Injection:** - **Healthy:** Operating at nominal design parameters.
  - **Capacitor Fault:** Increasing ESR (Equivalent Series Resistance) causing high voltage ripple.
  - **MOSFET Fault:** Increasing $R_{ds(on)}$ to 0.9 $\Omega$ to simulate early-stage degradation.

### 2. Automated Data Engineering (`run_project.m`)
The system extracts high-dimensional electrical signatures from raw simulation data:
- **$V_{mean}$:** Average output voltage monitoring.
- **$I_{rms}$:** Root Mean Square of Drain Current to detect switching anomalies.
- **$V_{pp}$:** Peak-to-Peak voltage ripple analysis (Primary indicator for Capacitor health).

### 3. Machine Learning Architecture (`train_svm.m`)
- **Algorithm:** Multi-class SVM (One-vs-One approach).
- **Kernel:** RBF (Radial Basis Function) to handle inherent switching noise.
- **Preprocessing:** Z-score normalization for feature scaling.

## 🧠 Critical Engineering Insights (From My Notes)
During development, I addressed several high-level technical challenges:

* **Thermal-Electrical Isolation:** Resolved MOSFET Junction Temperature ($T_j$) convergence errors by fixing it at 25°C. This ensures the model learns purely from *electrical degradation* signatures rather than thermal noise.
* **Why SVM?**
    * **Vs. KNN:** SVM is computationally efficient for **Edge Computing** deployment as it doesn't store the entire dataset for inference.
    * **Vs. Neural Networks:** Given the structured dataset with 3 features, SVM provides a clear mathematical margin without the "overkill" and training overhead of Deep Learning.
* **Realistic Simulation:** Chose a 0.9 $\Omega$ fault resistance to model **early-stage wear-and-tear** rather than a catastrophic short-circuit, which is the core of "Predictive" maintenance.

## 📊 Results
The system achieved high classification accuracy, successfully distinguishing between Healthy, Capacitor-Faulty, and MOSFET-Faulty states, validated through Confusion Matrices and ROC Curves.

## 👥 Team
- **Yash Srivastava** 
- **Md Nawaz Alam**
