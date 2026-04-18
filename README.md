# Dry Bean Classification Project (Random Forest)

## Overview
This project applies a random forest classifier to a dry bean dataset in order to predict bean type based on geometric features. The dataset contains 13,611 observations across seven bean classes, with 16 numerical features describing size and shape properties.

---

## Deliverable #1 — Initial Prompt

I am working on a machine learning classification project based on a dry bean dataset. The dataset has 13,611 observations from seven different bean types and includes 16 numerical features that describe the geometric properties of each bean, such as area, perimeter, major and minor axis lengths, aspect ratio, eccentricity, compactness, and shape factors. The goal is to use these features to predict the bean class. I am implementing the project in MATLAB using the Statistics and Machine Learning Toolbox. I want to use a random forest classifier and understand why that method is a good fit for this kind of problem. I also need help understanding the workflow in MATLAB, including how to split the data into training and validation sets, train the model, and evaluate it with a confusion matrix. I want the explanation to focus on the reasoning behind each step, not just the code.

---

## Deliverable #2 — Random Forest Summary

A random forest is an ensemble learning method that builds many decision trees using different random subsets of the training data and features. Each tree makes a prediction, and the final classification is determined by a majority vote. This reduces overfitting and improves generalization.

This approach is well suited for this dataset because:
- The features are numerical and likely have nonlinear relationships with the output
- Many features are correlated (e.g., area, perimeter, axis lengths)
- The problem involves multiclass classification (7 bean types)

The workflow involves splitting the dataset into training and validation sets, training the model, and evaluating it using a confusion matrix. The confusion matrix allows us to assess accuracy and identify where misclassifications occur.

---

## Deliverable #3 — Model 1 (Baseline)

### Confusion Matrix — Model 1

![Confusion Matrix Model 1](<img width="975" height="603" alt="image" src="https://github.com/user-attachments/assets/90503e90-8d93-41a9-9b54-22e5fe602969" />
)

### Discussion

The baseline random forest model performs well overall, with most predictions concentrated along the diagonal of the confusion matrix, indicating high classification accuracy.

The Bombay class is perfectly classified, suggesting it is highly distinct in feature space. Other classes such as Dermason, Seker, and Cali also show strong performance with minimal errors.

The weakest performance occurs for the Sira class (~85.8%), which is frequently misclassified as Dermason. This indicates these two classes share similar geometric properties. Smaller amounts of confusion also occur between Barbunya and Cali, as well as between Horoz and other classes.

Overall, the model captures the main structure of the dataset and provides a strong baseline for further iteration.

---

## Deliverable #4 — Model 2 (Tuned Random Forest)

### Confusion Matrix — Model 2

![Confusion Matrix Model 2](<img width="975" height="603" alt="image" src="https://github.com/user-attachments/assets/92de13a2-f397-4e1e-a4c9-3e90b806b625" />
)

### Discussion

The random forest model was modified by increasing the number of trees and adjusting parameters such as the minimum leaf size and the number of predictors sampled at each split. These changes were intended to improve model stability, reduce overfitting, and encourage greater diversity among the individual trees.

The tuned model maintains strong overall performance, but the improvement over the baseline model is limited. Some classes show slightly reduced accuracy compared to Model 1. For example, Barbunya decreases from approximately 92.4% to 90.5%, and Cali decreases from about 94.5% to 91.1%. The Sira class shows a modest improvement, increasing from approximately 85.8% to 87.1%, but it remains the most difficult class to classify.

The confusion between Sira and Dermason continues to be the dominant source of error, indicating that these classes share similar geometric characteristics that are difficult for the model to separate. This suggests that the limitation is not due to model tuning, but rather inherent overlap in the feature space.

Overall, the tuned model does not significantly outperform the baseline model, which indicates that the original model was already performing near its practical limit. This iteration demonstrates how adjusting hyperparameters can affect model behavior, even when improvements are small or mixed.

---

## Deliverable #5 — Feature Importance and Correlation Analysis

### Feature Importance — Model 2

![Feature Importance](<img width="975" height="681" alt="image" src="https://github.com/user-attachments/assets/ed54e961-dd82-4ffa-9163-2d3a1bce5a24" />
)

### Correlation Heatmap

![Correlation Heatmap](<img width="975" height="617" alt="image" src="https://github.com/user-attachments/assets/bdbfc377-156c-4619-87aa-4bf4a8f3e3f3" />
)

### Discussion

The feature importance plot shows that shape-based features are the most influential predictors in the model. In particular, roundness and ShapeFactor4 have the highest importance scores, followed by solidity and other shape-related features. These variables describe how closely the beans resemble ideal geometric shapes, which appears to be a key factor in distinguishing between different bean types.

Moderately important features include compactness, ShapeFactor1, ShapeFactor3, and minor axis length. These features capture additional geometric relationships that help refine classification when primary shape distinctions are not sufficient.

Lower importance features include extent and several size-related measurements such as area and perimeter. While these variables still contribute to the model, they are less dominant in determining classification outcomes.

The correlation heatmap provides important context for interpreting these results. Many of the size-related features—such as area, perimeter, convex area, and equivalent diameter—are highly correlated with one another. Because these features contain overlapping information, the random forest distributes importance across them rather than assigning a high importance to any single one.

Overall, the model relies more heavily on shape characteristics than size alone. The combination of feature importance and correlation analysis provides a clearer understanding of how the model distinguishes between bean types and explains why certain misclassifications persist.

## Summary

This project demonstrates the use of a random forest classifier for multiclass classification of beans using geometric features. The model performs well, with most errors occurring between classes that are geometrically similar. Feature importance and correlation analysis provide additional insight into how the model makes its predictions.
