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

#Load in data found in provided Github resource
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
#patient id: 0043 has missing data for $ baseline_esr, will correct for such in future steps

#Convert Strep Dosage into a factor variable
strep_tb_data$dose_strep_g <- factor(strep_tb_data$dose_strep_g,
                                         levels = c(0,2), 
                                         labels = c("0.00g", "2.00g"))

#Renaming Group labels within a variable in the df
levels(strep_tb_data$baseline_condition) <- c("Good", "Fair", "Poor")
levels(strep_tb_data$baseline_temp) <- c("98-98.9F", "99-99.9F", "100-100.9F", "100F+")
levels(strep_tb_data$baseline_esr) <- c("0-10", "11-20", "21-50", "51+")
levels(strep_tb_data$strep_resistance) <- c("Sensitive", "Moderate Resistance", "Resistant")
levels(strep_tb_data$radiologic_6m) <- c("Considerable Improvement", "Moderate Improvement", "No Change", "Moderate Deterioration", "Considerable Deterioration", "Death")
levels(strep_tb_data$baseline_cavitation) <- c("No", "Yes")
levels(strep_tb_data$improved) <- c("True","False")
levels(strep_tb_data$gender) <- c("Female", "Male")

#Question 1: Create a {gtsummary} table of descriptive statistics about your data
tbl_tbl_summary(
  strep_tb_data,
  by = arm,
  include = c(dose_strep_g, gender, baseline_condition, baseline_temp, baseline_esr, strep_resistance, radiologic_6m, improved),
  label = list(
    dose_strep_g ~ "Dose of Streptomycin (g)",
    gender ~ "Sex",
    baseline_condition ~ "Condition of Pt at Baseline",
    baseline_temp ~ "Oral Temperature at Baseline (°F)",
    baseline_esr ~ "Erythrocyte Sedimentation Rate at Baseline (mm/hr)",
    strep_resistance ~ "Resistance to Streptomycin at month 6",
    radiologic_6m ~ "Radiologic outcome of Chest X-Ray at month 6",
    improved ~ "Improved (Yes)"
  ),
  missing_text = "Missing"
)

#Question 2: Fit a regression and present well-formatted results
