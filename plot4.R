# read full data
hpc_full <- read.csv('household_power_consumption.txt', sep=';',na.strings = "?")

# convert data
hpc_full$dtc <- paste(as.character(hpc_full$Date), as.character(hpc_full$Time))
hpc_full$dtp <- as.POSIXlt(hpc_full$dtc, format="%d/%m/%Y %T")

# select subset
hpc <- hpc_full[which(hpc_full$dtp >= as.POSIXlt("2007-02-01 00:00:00") & hpc_full$dtp < as.POSIXlt("2007-02-03 00:00:00")), ]

# prepare system
Sys.setlocale(category = "LC_TIME", locale = "C") # set locale -- necessary on german system e.g. to get englisch weekday names

# plot to png
attach(hpc)
png(file="plot4.png")
par(mfrow = c(2,2)) # grid for subplots
plot(dtp, Global_active_power, type="l", xlab="", ylab="Global Active Power") # subplot 1
plot(dtp, Voltage, type="l", xlab="datetime") # subplot 2
plot(dtp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering") # start subplot 3
lines(dtp, Sub_metering_2, col="red")
lines(dtp, Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(dtp, Global_reactive_power, type="l", xlab="datetime") # subplot 4
par(mfrow=c(1,1)) # reset grit
dev.off()

# reset system 
Sys.setlocale(category = "LC_ALL", locale = "") # reset locale to default (on my system: german)
