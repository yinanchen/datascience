# Data set description
There are 160 columns in data set,  'classe' is label column with 5 classes: 'A','B','C','D','E'. Other columns are feature columns.  
41 feature columns' value nearly 98% are NA, so I removed these columns.
(ex: max_roll_dumbbell, min_roll_dumbbell, amplitude_pitch_dumbbell....)  

# Build classification model
* Step 1: load library  
 ```R
 library(caret)
 library(randomForest)
 ```
* Step 2:  Build classifier by random forest and use 3-folds cross-validation
```R
set.seed(7826) 
control <- trainControl(method = "cv", number = 5)
model <- train(classe ~ ., data = train, method = "rf", trControl = control)
```
* Step 3: examine model performance
  ```R
  print(model)
  ```
  Resampling: Cross-Validated (3 fold) 
  Summary of sample sizes: 13080, 13082, 13082 
  Resampling results across tuning parameters:

  | mtry   |      Accuracy      |  Kappa |
  |----------|:-------------:|------:|
  | 2 |  0.9956684 | 0.9945210 |
  | 41 |    0.9998471   |   0.9998066 |
  | 81 | 0.9998471 |    0.9998066 |
  
  Accuracy is pretty good, so let's do testing.
