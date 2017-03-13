plot3 <- function() {
  if (!exists("household_power_consumption")) {
    if (!exists("read_format_data")) {
      source("read_format_data.R")
    }
    household_power_consumption <- read_format_data()
  }
  
  png(filename = "plot3.png")
  plot(household_power_consumption$DateTime,
       household_power_consumption$Sub_metering_1, 
       ylab = "Energy sub metering",
       xlab = "",
       type = "n")
  points(household_power_consumption$DateTime,
         household_power_consumption$Sub_metering_1,
         type = "l",
         col = "black")
  points(household_power_consumption$DateTime,
         household_power_consumption$Sub_metering_2,
         type = "l",
         col = "red")
  points(household_power_consumption$DateTime,
         household_power_consumption$Sub_metering_3,
         type = "l",
         col = "blue")  
  legend("topright",
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), 
         lty = c(1, 1, 1))
  dev.off()
}