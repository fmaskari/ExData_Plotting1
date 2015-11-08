#download and unzip file from course site in working directory

#subset out necessary data from overall txt file
df <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", 
        header = FALSE, skip = grep("31/1/2007;23:59:00", 
        readLines("household_power_consumption.txt")), nrow = 2880)

#assign variable names
colnames(df) <- c("Date","Time", "Global_active_power", "Global_reactive_power", 
        "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
        "Sub_metering_3")

#code for plot
png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()