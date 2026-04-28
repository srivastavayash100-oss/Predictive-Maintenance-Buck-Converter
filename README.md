# Predictive Maintenance of a Power Converter Using Electrical Signal Features and Machine Learning in MATLAB

## 📌 Project Context
Developed as **Minor Project - 2 (Semester VI)** at JIIT Noida, under the supervision of **Dr. Ankur Bhardwaj**. This project focuses on moving from reactive to predictive maintenance in industrial power electronics.

## 🛠️ Technical Solution & Notes
### 1. The Simulation Environment (Simulink)
- **Closed-Loop Buck Converter:** Designed to simulate real-world hardware behavior.
- **Tustin Solver Optimization:** To handle switching frequencies and resolve **Algebraic Loops**, I implemented the Discrete/Tustin solver via the Powergui block.
- **Thermal Fix:** Fixed the MOSFET Junction Temperature ($T_j$) at 25°C using `assignin` logic. This was crucial to isolate electrical degradation ($R_{ds(on)}$) from thermal fluctuations.

### 2. Fault Classification Logic
The system identifies three distinct states based on feature extraction:
- **Healthy:** Nominal operation.
- **Capacitor Fault:** Detected via high **$V_{pp}$ (Voltage Ripple)** due to increased ESR.
- **MOSFET Fault:** Detected via abnormal **$I_{rms}$** and **$V_{mean}$** signatures.

### 3. Why SVM? (Technical Reasoning)
Based on my analysis, SVM was chosen over other algorithms because:
- **Vs. KNN:** SVM is more efficient for **Edge Computing** as it doesn't need to store the entire training set for inference.
- **Vs. Neural Networks:** With only 3-4 features, a Deep Learning model would be "overkill." SVM provides a clear mathematical margin with better interpretability.
- **Vs. Decision Trees:** SVM with an **RBF Kernel** is more robust to the switching noise inherent in Simulink models.

## 🚀 Key Engineering Challenges
- **Simulation Convergence:** Resolved errors where `sim_out` was returning empty data by fixing signal logging formats.
- **Early-Stage Detection:** Modeled a 0.9 $\Omega$ fault resistance to simulate degradation before a total short-circuit occurs.
