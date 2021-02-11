install.packages("tidyverse")
library(tidyverse)
install.packages("reshape2")
library(reshape2)

setwd('C:/Users/RyanB/Desktop/Tech_Academy/GitHub/DataScience')

housing = read.csv('housing.csv')

head(housing)

summary(housing)

par(mfrow=c(2,5))
colnames(housing)

ggplot(data = melt(housing), mapping = aes(x = value)) +
  geom_histogram(bins = 30) + facet_wrap(~variable, scales = 'free_x')

housing$total_bedrooms[is.na(housing$total_bedrooms)] = 
  median(housing$total_bedrooms, na.rm = T)

housing$mean_beadrooms = housing$total_bedrooms/housing$households
housing$mean_rooms = housing$total_rooms/housing$households

drops = c('total_bedrooms', 'total_rooms')

housing = housing[ , !(names(housing) %in% drops)]

head(housing)

categories = unique(housing$ocean_proximity)
cat_housing = data.frame(ocean_proximity = housing$ocean_proximity)

for(cat in categories){
  cat_housing[,cat]= rep(0, times= nrow(cat_housing))
}

head(housing)
head(cat_housing)

for(i in 1:length(cat_housing$ocean_proximity)){
  cat = as.character(cat_housing$ocean_proximity[i])
  cat_housing[,cat][i] = 1
}

head(cat_housing)

cat_columns = names(cat_housing)
keep_columns = cat_columns[cat_columns != 'ocean_proximity']
cat_housing = select(cat_housing, one_of(keep_columns))

tail(cat_housing)

colnames(housing)

drops = c('ocean_proximity', 'median_house_value')
housing_num = housing[ , !(names(housing) %in% drops)]
head(housing_num)

scaled_housing_num = scale(housing_num)

head(scaled_housing_num)

cleaned_housing = cbind(cat_housing, scaled_housing_num, 
                        median_house_value=housing$median_house_value)
head(cleaned_housing)


set.seed(1738)
sample = sample.int(n = nrow(cleaned_housing), size=floor(.8*nrow(cleaned_housing)),
                    replace = F)

train = cleaned_housing[sample, ]
test = cleaned_housing[-sample, ]

head(train)
nrow(train) + nrow(test) == nrow(cleaned_housing)

install.packages("boot")
library('boot')

?cv.glm
glm_house = glm(median_house_value~median_income+mean_rooms+population,
                data=cleaned_housing)

k_fold_cv_error = cv.glm(cleaned_housing, glm_house, K=5)
k_fold_cv_error$delta

glm_cv_rmse = sqrt(k_fold_cv_error$delta)[1]
glm_cv_rmse

names(glm_house)
glm_house$coefficients

library(randomForest)
?randomForest
names(train)

set.seed(1738)

train_y = train[, 'median_house_value']
train_x = train[, names(train) != 'median_house_value']

head(train_y)
head(train_x)

rf_model = randomForest(train_x, y = train_y, ntree = 500, importance = T)
names(rf_model)

rf_model$importance

oob_prediciton = predict(rf_model)

train_mse = mean(as.numeric(oob_prediciton - train_y)^2)
oob_rmse = sqrt(train_mse)
oob_rmse

test_y = test[, 'median_house_value']
test_x = test[, names(test) != 'median_house_value']

y_pred = predict(rf_model, text_x)
test_mse = mean(((y_pred - test_y)^2))
test_rmse = sqrt(test_mse)
test_rmse


housing = read.csv('housing.csv')

head(housing$longitude)
head(housing$latitude)

colnames(housing)

plot(housing)

# alternative cleaning

data <- housing %>%
  mutate(mean_bedrooms = (total_bedrooms / households),
         mean_rooms = (total_rooms / households)) %>%
  select(-c(total_bedrooms, total_rooms)) %>%
  mutate(near_bay = ifelse(ocean_proximity == "NEAR BAY", 1, 0),
         h_ocean = ifelse(ocean_proximity == "<1H OCEAN", 1, 0),
         inland = ifelse(ocean_proximity == "INLAND", 1, 0),
         near_ocean = ifelse(ocean_proximity == "NEAR OCEAN", 1, 0),
         island = ifelse(ocean_proximity == "ISLAND", 1, 0))

head(data)

















