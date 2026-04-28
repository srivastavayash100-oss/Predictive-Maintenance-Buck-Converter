%% ================== INITIAL SETUP ==================
clc; clear; close all;
warning('off','all');

disp("==== LOADING DATASET ====");

%% ================== LOAD DATA ==================
data = readtable('Final_Dataset.csv');
fprintf("Dataset loaded: %d rows, %d columns\n", size(data,1), size(data,2));

%% ================== PREPROCESS ==================
% Last column = label
X = data(:,1:end-1);
Y = data(:,end);

% Convert formats
X = table2array(X);
Y = categorical(Y{:,1});

%% ================== TRAIN-TEST SPLIT ==================
cv = cvpartition(size(X,1),'HoldOut',0.2);

X_train = X(training(cv),:);
Y_train = Y(training(cv),:);

X_test  = X(test(cv),:);
Y_test  = Y(test(cv),:);

%% ================== NORMALIZATION ==================
[X_train, mu, sigma] = zscore(X_train);
X_test = (X_test - mu) ./ sigma;

%% ================== MODEL TRAINING (MULTI-CLASS SVM) ==================
disp("Training Multi-class SVM model...");

t = templateSVM('KernelFunction','rbf');

model = fitcecoc(X_train, Y_train, 'Learners', t);

disp("Training Completed");

%% ================== PREDICTION ==================
[Y_pred, score] = predict(model, X_test);

%% ================== ACCURACY ==================
accuracy = sum(Y_pred == Y_test) / numel(Y_test);
fprintf("\nFINAL ACCURACY = %.2f%%\n", accuracy * 100);

%% ================== CONFUSION MATRIX ==================
figure;
confusionchart(Y_test, Y_pred);
title('Confusion Matrix');

%% ================== ROC CURVE ==================
figure;
classes = categories(Y_test);
hold on;

for i = 1:length(classes)
    [Xroc,Yroc,~,AUC] = perfcurve(Y_test, score(:,i), classes{i});
    plot(Xroc,Yroc,'LineWidth',2);
end

xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('ROC Curve (Multi-class)');
legend(classes);
grid on;

%% ================== FEATURE IMPORTANCE ==================
treeModel = fitctree(X_train, Y_train);
imp = predictorImportance(treeModel);

figure;
bar(imp);
title('Feature Importance');
xlabel('Feature Index');
ylabel('Importance');

%% ================== PREDICTION vs ACTUAL ==================
figure;
plot(double(Y_test),'b');
hold on;
plot(double(Y_pred),'r--');
legend('Actual','Predicted');
title('Prediction vs Actual');

%% ================== SAVE MODEL ==================
save('trained_model.mat','model','mu','sigma');

disp("Model saved successfully!");

%% ================== SAMPLE PREDICTION ==================
sample = X_test(1,:);
result = predict(model, sample);

disp("Sample Prediction:");
disp(result);
