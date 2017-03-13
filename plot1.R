plot1 <- function() {
  if (!exists("household_power_consumption")) {
    if (!exists("read_format_data")) {
      source("read_format_data.R")
    }
    household_power_consumption <- read_format_data()
  }
  
  png(filename = "plot1.png")
  hist(household_power_consumption$Global_active_power, 
       xlab = "Global Active Power (kilowatts)",
       ylab = "Frequency", 
       main = "Global Active Power", 
       col = "red")
  dev.off()
}