## Programming Assignment 1
## Plot 1
library(data.table)

# Unzip and load data from zip file
baseWd <- getwd()
setwd('./data')
if (!file.exists('household_power_consumption.txt'))
  unzip(zipfile='household_power_consumption.zip', 
        files='household_power_consumption.txt')
hpc <- fread('household_power_consumption.txt') # Luckily this is pretty fast
setwd(baseWd)

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# Filter out the rest.
hpc <- hpc[(Date == '1/2/2007' | Date == '2/2/2007')]

# Format column data as specified
# Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
hpc$datetime <- as.POSIXct(paste(hpc$Date, hpc$Time), 
                           tz="GMT", format='%d/%m/%Y %H:%M:%S')
# Global_active_power: household global minute-averaged active power (in kilowatt)
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
# Voltage: minute-averaged voltage (in volt)
hpc$Voltage <- as.numeric(hpc$Voltage)
# Global_intensity: household global minute-averaged current intensity (in ampere)
hpc$Global_intensity <- as.numeric(hpc$Global_intensity)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3)

# Create Plot
png('./plot1.png', width = 480, height = 480)
hist(hpc$Global_active_power,
     col='red', 
     main='Global Active Power', 
     xlab='Global Active Power (kilowatts)')
dev.off()
