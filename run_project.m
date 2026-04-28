%% ===== DATA GENERATION FROM SIMULINK =====
clear; clc; close all;

model_name = 'my_buck_model';
total_samples = 10000;

%% -------- Pre-allocation --------
Mean_V = zeros(total_samples,1);
RMS_I  = zeros(total_samples,1);
V_pp   = zeros(total_samples,1);
Label  = zeros(total_samples,1);

%% -------- Load Model --------
load_system(model_name);
set_param(model_name, 'FastRestart', 'on');

%% -------- Fix MOSFET Temperature Error --------
assignin('base','T_junction1',25);   % °C
assignin('base','T_junction2',25);   % °C

fprintf(' Starting REAL dataset generation from circuit...\n\n');

for i = 1:total_samples

    %% -------- Fault Assignment --------
    if i <= total_samples/3
        val_esr = 0.01;
        R_mosfet = 0.1;
        curr_label = 0;   % Healthy
    elseif i <= 2*total_samples/3
        val_esr = 2.0;
        R_mosfet = 0.1;
        curr_label = 1;   % Capacitor Fault
    else
        val_esr = 0.01;
        R_mosfet = 0.9;
        curr_label = 2;   % MOSFET Fault
    end

    assignin('base','val_esr',val_esr);
    assignin('base','R_mosfet',R_mosfet);

    %% -------- Run Simulation --------
    try
        sim_out = sim(model_name);

        %% -------- Extract Signals --------
        v_raw = sim_out.get('Vout').Data;
        i_raw = sim_out.get('Idrain').Data;

        if isempty(v_raw) || isempty(i_raw)
            error('Signal extraction failed');
        end

    catch
        error(" Simulation failed at sample %d. Check model signals/parameters.", i);
    end

    %% -------- Feature Extraction --------
    Mean_V(i) = mean(v_raw);
    RMS_I(i)  = rms(i_raw);
    V_pp(i)   = max(v_raw) - min(v_raw);
    Label(i)  = curr_label;

    %% -------- Progress Message --------
    fprintf(' Data %d generated from circuit\n', i);

    %% -------- Save after EACH sample --------
    tempTable = table(Mean_V(1:i), RMS_I(1:i), V_pp(1:i), Label(1:i), ...
        'VariableNames', {'V_Mean','I_RMS','V_pp','Class'});

    writetable(tempTable, 'Final_Dataset2.csv');

end

%% -------- Final Output --------
fprintf('\n Dataset generation COMPLETE (100%% from circuit)\n');

data = readtable('Final_Dataset2.csv');
disp(data(1:min(5,height(data)), :));
