#download and unzip file from course site in working directory

#subset out necessary data from overall txt file
df <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
        header = FALSE, skip = grep("31/1/2007;23:59:00", 
        readLines("household_power_consumption.txt")), nrow = 2880)

#assign variable names
colnames(df) <- c("Date","Time", "Global_active_power", "Global_reactive_power", 
        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
        "Sub_metering_3")

#mutate Date and Time variable
library(dplyr)
df <- mutate(df, DateTime = as.character(paste(Date, Time, sep = " ")))
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %H:%M:%S")

#code for plot
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
with(df, {
        plot(DateTime, Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power (kilowatts)")
        plot(DateTime, Sub_metering_1, type = "n", 
             xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_1)
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               bty = "n")
        plot(DateTime, Voltage, type = "l")
        plot(DateTime, Global_reactive_power, type = "l")
})
dev.off()
