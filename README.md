# ⚡ Predictive Maintenance: Intelligent Fault Diagnosis for Power Converters
> **Bridging Power Electronics and Machine Learning to prevent industrial downtime.**

![MATLAB](https://img.shields.io/badge/MATLAB-R2024b-orange.svg)
![Simulink](https://img.shields.io/badge/Simulink-Modeling-blue.svg)
![ML](https://img.shields.io/badge/Algorithm-Multi--class%20SVM-green.svg)
![ECE](https://img.shields.io/badge/Domain-Electronics%20%26%20Communication-red.svg)

---

## 📺 Project Showcase
| **Simulink Model Architecture** | **Fault Classification Results** |
|---|---|
| <img src="path/to/your/simulink_image.png" width="400"> | <img src="path/to/your/confusion_matrix.png" width="400"> |
| *High-fidelity Buck Converter Model* | *100% Accuracy using RBF-SVM* |

---

## 🚀 The Challenge: "When Hardware Fails Silently"
Traditional maintenance is either **Reactive** (too late) or **Preventive** (too early). Our system implements **Predictive Maintenance (PdM)**—detecting the *onset* of degradation in MOSFETs and Capacitors before they explode or cause system failure.

### 🧠 The Engineering "Alpha" (Key Insights)
<details>
<summary><b>1. Solving the Thermal Noise Paradox</b></summary>
During simulation, MOSFET temperature fluctuations were masking electrical faults. I implemented a custom script to fix $T_{j}$ at 25°C using `assignin`, isolating $R_{ds(on)}$ degradation signatures.
</details>

<details>
<summary><b>2. Solver Optimization (Tustin vs Continuous)</b></summary>
Algebraic loops were crashing the data generation. By switching to the **Discrete/Tustin Solver** in Powergui, I boosted simulation speed by 4x without losing signal integrity.
</details>

<details>
<summary><b>3. Why SVM for Edge Computing?</b></summary>
I chose **SVM with RBF Kernel** over Deep Learning. Why? Because it's lightweight. In a real-world industrial plant, you want this running on a low-power microcontroller (Edge), not a heavy server.
</details>

---

## 🛠️ Technical Stack & Workflow

### 🟢 Phase A: Physical Modeling
- **Component Level:** Modeled ESR degradation in Capacitors and $R_{on}$ in MOSFETs.
- **Environment:** Simscape Electrical / Simulink.

### 🟡 Phase B: Automated Feature Extraction
We don't just use raw data. We extract **Statistical Signatures**:
- **$V_{pp}$ (Peak-to-Peak):** The "Heartbeat" of Capacitor health.
- **$I_{rms}$ (Drain Current):** Detecting switching anomalies.
- **$V_{mean}$:** Monitoring voltage stability.

### 🔴 Phase C: Intelligent Classification
- **Algorithm:** Multi-class SVM (One-vs-One).
- **Outcome:** Successful detection of "Early-Stage" faults (using 0.9 $\Omega$ resistance—crucial for predictive detection).

---

## 📂 Project Structure
```text
├── Model/              # .slx files & Circuit Diagrams
├── Scripts/            # run_project.m & train_svm.m
├── Data/               # Final_Dataset.csv
├── Documentation/      # Minor-2 Report & Synopsis
└── Results/            # Confusion Matrix & ROC Curves
