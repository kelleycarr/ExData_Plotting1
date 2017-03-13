plot2 <- function() {
  if (!exists("household_power_consumption")) {
    if (!exists("read_format_data")) {
      source("read_format_data.R")
    }
    household_power_consumption <- read_format_data()
  }
  
  png(filename = "plot2.png")
  plot(household_power_consumption$DateTime,
       household_power_consumption$Global_active_power, 
       ylab = "Global Active Power (kilowatts)",
       xlab = "",
       type = "l")
  dev.off()
}