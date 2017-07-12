# Background
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here: http://groupware.les.inf.puc-rio.br/har (see the section on the Weight Lifting Exercise Dataset).

# Data set examination
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
control <- trainControl(method = "cv", number = 3)
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
* Step 4: prediction
  ```R
  predict(model, test)
  ```
