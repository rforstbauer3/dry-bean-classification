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

%% Tuned random forest model
rng(42);
model2 = TreeBagger(300, Xtrain, Ytrain, ...
    'Method', 'classification', ...
    'MinLeafSize', 3, ...
    'NumPredictorsToSample', round(sqrt(width(Xtrain))), ...
    'OOBPrediction', 'on', ...
    'OOBPredictorImportance', 'on');

%% Predict on test set
Ypred_cell = predict(model2, Xtest);
Ypred = categorical(Ypred_cell);

%% Confusion matrix
figure;
cm = confusionchart(Ytest, Ypred);
cm.Title = 'Confusion Matrix - Model 2';
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';

%% Accuracy
accuracy2 = mean(Ypred == Ytest);
fprintf('Model 2 Accuracy: %.4f\n', accuracy2);

%% Save figure
exportgraphics(gcf, 'confusion_matrix_2.png', 'Resolution', 300);

%% Feature importance
figure;
bar(model2.OOBPermutedPredictorDeltaError);
xticks(1:width(Xtrain));
xticklabels(Xtrain.Properties.VariableNames);
xtickangle(45);
ylabel('Importance Score');
title('Feature Importance - Model 2');
grid on;
exportgraphics(gcf, 'feature_importance.png', 'Resolution', 300);





data = readtable('C:\Users\rgfor\Downloads\Oscillation measurements lab 4\DryBeanDataset\Dry_Bean_Dataset.xlsx');

X = data(:,1:end-1);
Xmat = table2array(X);

R = corrcoef(Xmat);

figure;
heatmap(X.Properties.VariableNames, X.Properties.VariableNames, R, ...
    'Colormap', parula, ...
    'ColorLimits', [-1 1]);

title('Correlation Heatmap of Bean Features');
exportgraphics(gcf, 'correlation_heatmap.png', 'Resolution', 300);