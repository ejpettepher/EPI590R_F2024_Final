install.packages("medicaldata")
library(medicaldata)
data(package = "medicaldata")
here::here("data", "raw")
strep_tb_data <- medicaldata::strep_tb
