# Install relevant packages for data visualization and analysis
install.packages("medicaldata")
install.packages("here")
install.packages("gtsummary")
install.packages("ggplot2")
install.packages("broom")
library(here)
library(medicaldata)
library(gtsummary)
library(ggplot2)
library(broom)
# Load in data found in provided Github resource
data(package = "medicaldata")
here::here("data", "raw")
strep_tb_data <- medicaldata::strep_tb
#Save R dataframe as an .rds file and use {here} to load in the data and store it in the correct folder within the working directory
file_path <-here::here("data", "raw")
saveRDS(strep_tb_data, file = "data.rds")
source_path <- here("data.rds")
destination_path <- here("data", "data.rds")
file.rename(source_path, destination_path)
source_path <- here("data", "data.rds")
destination_path <- here("data/raw", "data.rds")
file.rename(source_path, destination_path)
#Begin basic data visualizations to identify data types and any errors that need to be corrected for
head(strep_tb_data)
str(strep_tb_data)
summary(strep_tb_data)
sum(is.na(strep_tb_data))
# patient id: 0043 has missing data for $ baseline_esr, will correct for such in future steps