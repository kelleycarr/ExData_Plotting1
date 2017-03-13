plot4 <- function() {
  if (!exists("household_power_consumption")) {
    # if (!exists("read_format_data")) {
    #   source("read_format_data.R")
    # }
    household_power_consumption <- read_format_data()
  }
  
  png(filename = "plot4.png")
  par(mfrow = c(2,2))
  
  ## Plot 1 of 4
  plot(household_power_consumption$DateTime,
       household_power_consumption$Global_active_power, 
       ylab = "Global Active Power",
       xlab = "",
       type = "l")
  
  ## Plot 2 of 4
  plot(household_power_consumption$DateTime,
       household_power_consumption$Voltage,
       xlab = "datetime",
       ylab = "Volgate",
       type = "l")
  
  ## Plot 3 of 4
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
         lty = c(1, 1, 1),
         bty = "n")
  
  ## Plot 4 of 4
  plot(household_power_consumption$DateTime,
       household_power_consumption$Global_reactive_power,
       xlab = "datetime",
       ylab = "Global_reactive_power",
       type = "l")
  dev.off()
}

read_format_data <- function() {
  if (!file.exists("household_power_consumption.txt")) {
    if (!file.exists("household_power_consumption.zip")) {
      print("Downloading file")
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                    "household_power_consumption.zip")
    }
    print("Unzipping file")
    unzip("household_power_consumption.zip")
  }
  
  lines_to_read <- grep("^1/2/2007|^2/2/2007", readLines("household_power_consumption.txt"))
  household_power_consumption <- read.table("household_power_consumption.txt", 
                                            header = FALSE, 
                                            sep = ";",
                                            na.strings = "?", 
                                            skip = min(lines_to_read) - 1,
                                            nrows = length(lines_to_read))
  
  header <- readLines("household_power_consumption.txt", n = 1)
  names(household_power_consumption) <- strsplit(header, ";")[[1]]
  
  household_power_consumption$DateTime <- strptime(with(household_power_consumption, 
                                                        paste(Date, Time)),
                                                   "%d/%m/%Y %H:%M:%S")
  household_power_consumption$Date <- NULL
  household_power_consumption$Time <- NULL
  
  return(household_power_consumption)
}