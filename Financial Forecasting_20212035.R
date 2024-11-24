library(readxl)
library(neuralnet)
library(dplyr)
library(MLmetrics)
library(Metrics)

rate_data <- read_excel("C:/Users/krishan_s/Desktop/ML/Assessmet/ExchangeUSD.xlsx")
head(as.data.frame(data))

exchange_rate <- data$'USD/EUR'
str(exchange_rate)

lagged_exchange_data <- bind_cols(
  t_4 = lag(exchange_rate, 4),
  t_3 = lag(exchange_rate, 3),
  t_2 = lag(exchange_rate, 2),
  t_1 = lag(exchange_rate, 1),
  t = exchange_rate
)

head(as.data.frame(lagged_exchange_data))

lagged_exchange_data <- na.omit(lagged_exchange_data)

head(lagged_exchange_data)

normalize_data <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}
unnormalize_data <- function(x, min, max) {
  return((max - min)*x + min)
}
norm_data <- normalize_data(lagged_exchange_data)

train_data <- norm_data[1:400,]
train_data
test_data <- norm_data[401:nrow(norm_data),]
test_data

stat_indices <- function(act_output, pred_output){
  
  rmse <- RMSE(act_output, pred_output)
  mae <- MAE(act_output, pred_output)
  mape <- MAPE(act_output, pred_output)
  smape <- smape(act_output, pred_output)
  
  cat("RMSE:", rmse, "\n")
  cat("MAE:", mae, "\n")
  cat("MAPE", mape, "\n")
  cat("sMAPE", smape, "\n")
}

# model 1
MLP1 <- neuralnet(t ~ t_1, data = train_data, hidden = c(3), act.fct = "logistic", linear.output = FALSE)
plot(MLP1)
prediction1 <- predict(MLP1, test_data)
stat_indices(test_data$t, prediction1)
unnorm_prediction1 <- unnormalize_data(prediction1, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction1

# model 2
MLP2 <- neuralnet(t ~ t_1 + t_2 + t_3, data = train_data, hidden = c(5), act.fct = "tanh", linear.output = TRUE)
plot(MLP2)
prediction2 <- predict(MLP2, test_data)
stat_indices(test_data$t, prediction2)
unnorm_prediction2 <- unnormalize_data(prediction2, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction2

# model 3
MLP3 <- neuralnet(t ~ t_1 + t_2 + t_3 + t_4,data =train_data, hidden = c(5),act.fct = "logistic",linear.output = FALSE)
plot(MLP3)
prediction3 <- predict(MLP3, test_data)
stat_indices(test_data$t, prediction3)
unnorm_prediction3 <- unnormalize_data(prediction3, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction3

# model 4
MLP4 <- neuralnet(t ~ t_1 + t_4, data = train_data, hidden = c(7), act.fct = "tanh", linear.output = TRUE)
plot(MLP4)
prediction4 <- predict(MLP4, test_data)
stat_indices(test_data$t, prediction4)
unnorm_prediction4 <- unnormalize_data(prediction4, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction4

# model 5
MLP5 <- neuralnet(t ~ t_1 + t_2 + t_4, data = train_data, hidden = c(9), act.fct = "logistic", linear.output = FALSE)
plot(MLP5)
prediction5 <- predict(MLP5, test_data)
stat_indices(test_data$t, prediction5)
unnorm_prediction5 <- unnormalize_data(prediction5, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction5

# model 6
MLP6 <- neuralnet(t ~ t_1 + t_2 + t_3 + t_4, data = train_data, hidden = c(2,3), act.fct = "logistic", linear.output = FALSE)
plot(MLP6)
prediction6 <- predict(MLP6, test_data)
stat_indices(test_data$t, prediction6)
unnorm_prediction6 <- unnormalize_data(prediction6, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction6

# model 7
MLP7 <- neuralnet(t ~ t_2 + t_3 + t_4, data = train_data, hidden = c(3,5), act.fct = "tanh", linear.output = FALSE)
plot(MLP7)
prediction7 <- predict(MLP7, test_data)
stat_indices(test_data$t, prediction7)
unnorm_prediction7 <- unnormalize_data(prediction7, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction7

# model 8
MLP8 <- neuralnet(t ~ t_1 + t_2 , data = train_data, hidden = c(3,5), act.fct = "logistic", linear.output = FALSE)
plot(MLP8)
prediction8 <- predict(MLP8, test_data)
stat_indices(test_data$t, prediction8)
unnorm_prediction8 <- unnormalize_data(prediction8, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction8

# model 9
MLP9 <- neuralnet(t ~ t_1 + t_4, data = train_data, hidden = c(5,9), act.fct = "tanh", linear.output = TRUE)
plot(MLP9)
prediction9 <- predict(MLP9, test_data)
stat_indices(test_data$t, prediction9)
unnorm_prediction9 <- unnormalize_data(prediction9, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction9

# model 10 
MLP10 <- neuralnet(t ~ t_1 + t_2 + t_3, data = train_data, hidden = c(5,10), act.fct = "logistic", linear.output = FALSE)
plot(MLP10)
prediction10 <- predict(MLP10, test_data)
stat_indices(test_data$t, prediction10)
unnorm_prediction10 <- unnormalize_data(prediction10, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction10

# model 11
MLP11 <- neuralnet(t ~ t_4 + t_2 + t_1, data = train_data, hidden = c(3,8), act.fct = "logistic", linear.output = FALSE)
plot(MLP11)
prediction11 <- predict(MLP11, test_data)
stat_indices(test_data$t, prediction11)
unnorm_prediction11 <- unnormalize_data(prediction11, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction11

# model 12
MLP12 <- neuralnet(t ~ t_1 + t_2 + t_3 + t_4, data = train_data, hidden = c(4,2), act.fct = "tanh", linear.output = TRUE)
plot(MLP12)
prediction12 <- predict(MLP12, test_data)
stat_indices(test_data$t, prediction12)
unnorm_prediction12 <- unnormalize_data(prediction12, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction12

# model 13
MLP13 <- neuralnet(t ~ t_1 + t_2 + t_3, data = train_data, hidden = c(2,7), act.fct = "logistic", linear.output = FALSE)
plot(MLP13)
prediction13 <- predict(MLP13, test_data)
stat_indices(test_data$t, prediction13)
unnorm_prediction13 <- unnormalize_data(prediction13, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction13

# model 14
MLP14 <- neuralnet(t ~ t_2, data = train_data, hidden = c(5,2), act.fct = "logistic", linear.output = FALSE)
plot(MLP14)
prediction14 <- predict(MLP14, test_data)
stat_indices(test_data$t, prediction14)
unnorm_prediction14 <- unnormalize_data(prediction14, min(lagged_exchange_data), max(lagged_exchange_data) )
unnorm_prediction14

unnorm_test_data_actual <- unnormalize_data(test_data$t, min(lagged_exchange_data), max(lagged_exchange_data) )

# Combine predicted and actual values into a frame
prediction_table <- data.frame(predicted = unnorm_prediction5, actual = unnorm_test_data_actual)

# Print table
print(prediction_table)


plot(test_data$t, ylab = "Predicted vs Real", type = "l", col = "green")
par(new = TRUE)
plot(prediction5, ylab = "", yaxt = "n", type = "l", col = "red")
legend('topleft', c('Predicted', 'Real'), fill = c("red", "green"))