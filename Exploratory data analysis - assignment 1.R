#Config
dataDir <- "...\\Data\\exdata_data_household_power_consumption"
resultDir <- "...\\Results"
setwd(dataDir)

# Pull data
rawData <-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", dec=".")

# Prepare data
data <- data.frame()
data <- rbind(rawData[rawData$Date=="1/2/2007",],rawData[rawData$Date=="2/2/2007",]) # Needed subset
data$Date <- as.Date(data$Date, "%d/%m/%Y") # Plots require class Date
data <- cbind(data, "DateTime" = as.POSIXct(paste(data$Date, data$Time)))
data$Global_active_power <- as.numeric(data$Global_active_power) # Plot require numeric

# Plot 1
setwd(resultDir)
png("plot1.png", width=480, height=480)
hist(data$Global_active_power, col="Red", main="Global Active Power", xlab="Global Active power (kilowatts)", ylab="Frequency")
dev.off()

# Plot 2
setwd(resultDir)
png("plot2.png", width=480, height=480)
plot(data$Global_active_power ~ data$DateTime, type="l", xlab= "", ylab="Global Active power (kilowatts)")
dev.off()

# Plot 3
setwd(resultDir)
png("plot3.png", width=480, height=480)
with(data, {plot(Sub_metering_1 ~ DateTime, type="l", xlab= "", ylab="Energy sub metering")})
lines(data$Sub_metering_2 ~ data$DateTime, col = 'Red')
lines(data$Sub_metering_3 ~ data$DateTime, col = 'Blue')
legend("topright", lty=1, lwd =3, col=c("black","red","blue") ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

# Plot 4
setwd(resultDir)
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(data$Global_active_power ~ data$DateTime, type="l", xlab= "", ylab="Global Active Power")
plot(data$Voltage ~ data$DateTime, type="l", xlab= "datetime", ylab="Voltage")
with(data, {plot(Sub_metering_1 ~ DateTime, type="l", xlab= "", ylab="Energy sub metering")})
lines(data$Sub_metering_2 ~ data$DateTime, col = 'Red')
lines(data$Sub_metering_3 ~ data$DateTime, col = 'Blue')
plot(data$Global_reactive_power ~ data$DateTime, type="l", xlab= "datetime", ylab="Global_reactive_power")
dev.off()