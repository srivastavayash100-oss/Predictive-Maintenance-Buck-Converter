# Predictive Maintenance of a Power Converter Using Electrical Signal Features and Machine Learning in MATLAB

## 📌 Project Overview
This project is part of my **Minor Project - 2 (Semester VI)** at JIIT. It focuses on the intelligent fault diagnosis of a DC-DC Buck Converter. By integrating **Simulink-based physical modeling** with **Multi-class SVM classification**, the system identifies early-stage degradation in MOSFETs and Electrolytic Capacitors.

## 🛠️ Technical Architecture
### 1. Physical Modeling (Simulink)
- **Converter:** Closed-loop Buck Converter.
- **Solver:** **Powergui (Discrete/Tustin)** to resolve algebraic loops and optimize simulation speed.
- **Fault Injection:** - **Capacitor Fault:** Increasing ESR (Equivalent Series Resistance).
    - **MOSFET Fault:** Varying Drain-Source 'On' Resistance ($R_{ds(on)}$).

### 2. Data Engineering (`run_project.m`)
The model extracts three key electrical signatures:
- **$V_{mean}$:** Average output voltage.
- **$I_{rms}$:** Root Mean Square of the drain current ($I_d$).
- **$V_{pp}$:** Peak-to-Peak voltage ripple (indicator of capacitor health).

### 3. Machine Learning (`train_svm.m`)
- **Algorithm:** Multi-class SVM (One-vs-One).
- **Kernel:** RBF (Radial Basis Function).
- **Metric:** Achieved high accuracy with robust validation via Confusion Matrix and ROC Curves.

## 🚀 Engineering Challenges Solved
- **Thermal Convergence:** Fixed MOSFET Junction Temperature ($T_j$) at 25°C using `assignin` to isolate electrical degradation from thermal noise.
- **Simulation Stability:** Implemented a Tustin solver to eliminate algebraic loop errors during high-speed data generation.
- **Early Detection:** Specifically modeled small fault resistances (0.9 $\Omega$) to detect "degradation" rather than "failure."

## 📊 Results
The model effectively distinguishes between:
1. **Healthy State**
2. **Capacitor Fault**
3. **MOSFET Fault**
