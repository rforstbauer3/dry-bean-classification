clc;
clear;
close all;

%% Load data
data = readtable('C:\Users\rgfor\Downloads\Oscillation measurements lab 4\DryBeanDataset\Dry_Bean_Dataset.xlsx');

%% Separate predictors and response
X = data(:, 1:end-1);
Y = categorical(data.Class);

%% Create holdout split (80% train, 20% test)
cv = cvpartition(Y, 'HoldOut', 0.20);

Xtrain = X(training(cv), :);
Ytrain = Y(training(cv), :);

Xtest = X(test(cv), :);
Ytest = Y(test(cv), :);

%% Train random forest model
rng(42); % for reproducibility
model1 = TreeBagger(100, Xtrain, Ytrain, ...
    'Method', 'classification', ...
    'OOBPrediction', 'on', ...
    'OOBPredictorImportance', 'on');

%% Predict on test set
Ypred_cell = predict(model1, Xtest);
Ypred = categorical(Ypred_cell);

%% Confusion matrix
figure;
cm = confusionchart(Ytest, Ypred);
cm.Title = 'Confusion Matrix - Model 1';
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';

%% Accuracy
accuracy1 = mean(Ypred == Ytest);
fprintf('Model 1 Accuracy: %.4f\n', accuracy1);

%% Save figure
exportgraphics(gcf, 'confusion_matrix_1.png', 'Resolution', 300);