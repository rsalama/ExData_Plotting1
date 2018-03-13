url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./household_power_consumption.zip", method="curl")
unzip("./household_power_consumption.zip")

colNames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# Feb starts at line 66637, one day has 1440 observations (1 per minute), 2 days, 2880
df <- read.table("household_power_consumption.txt", sep=";", skip=66637, nrows = 2880, col.names = colNames,  na.strings = "?")
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
png(filename="plot1.png")
hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()

plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(df$DateTime, df$Sub_metering_1,type="l",col="gray", ylab = "Energy sub metering", xlab = "")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("gray", "red", "blue"), bty = "n")

plot(df$DateTime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

