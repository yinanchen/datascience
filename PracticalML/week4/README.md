# Data set examination
There are 160 columns in data set, but 41 columns' value nearly 98% are NA.  
(ex: max_roll_dumbbell, min_roll_dumbbell, amplitude_pitch_dumbbell....)  
Remove these columns because there are useless.

# Build classification model
* Step 1: load library  
 ```R
 library(caret)
 library(randomForest)
 ```
* Step 2:  Build classifier by random forest and use 3-folds cross-validation
```R
control <- trainControl(method = "cv", number = 5)
model <- train(classe ~ ., data = train, method = "rf", trControl = control)
```
* Step 3: examine model performance
```R
print(model)
```
