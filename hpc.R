# read full data
# http://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html -- read.. + options
# http://www.cookbook-r.com/Data_input_and_output/Loading_data_from_a_file/ -- strings as factors or characters!!
hpc_full <- read.csv('household_power_consumption.txt', sep=';',na.strings = "?")

# optional 
# check first data, NA Data, structure
head(hpc_full, 5)
hpc_full[6840, ]

# convert dates -- trial
# http://rfunction.com/archives/1912 -- as.Date, strptime for dates or dates with times
# d123 <- as.Date(x123$Date, format="%d/%m/%Y") # ok
# t123 <- strptime(x123$Time, format="%H:%M:%S") # adds current date - unwanted
# t123 <- strptime(x123$Time, format="%T") # adds current date - unwanted
# weekdays(d123) # ok - may help later
# dtc123 <- paste(as.character(x123$Date), as.character(x123$Time)) # ok, first conversion to string
# dt123 <- as.POSIXlt(dtc123, format="%d/%m/%Y %T") # ok then final conversion to POSIXlt DateTime
# dt123[1] < dt123[3] # ok theese dates can be compared
# weekdays(dt123) # ok - and converted to weekdays -- ups language is german

# convert dates .. -- do it now
hpc_full$dtc <- paste(as.character(hpc_full$Date), as.character(hpc_full$Time))
hpc_full$dtp <- as.POSIXlt(hpc_full$dtc, format="%d/%m/%Y %T")
# hpc_full$wd <- weekdays(hpc_full$dtp) # not necessary

# select subset
hpc <- hpc_full[which(hpc_full$dtp >= as.POSIXlt("2007-02-01 00:00:00") & hpc_full$dtp < as.POSIXlt("2007-02-03 00:00:00")), ]

# check subset
head(hpc, 3)
tail(hpc, 3)

# set locale -- necessary on german system e.g. to get englisch weekday names, see below
Sys.setlocale(category = "LC_TIME", locale = "C") # set locale 
# Sys.setlocale(category = "LC_ALL", locale = "") # reset locale -- do this later

# tests for plot 1
hist(Global_active_power)
hist(Global_active_power, xlab="Global Active Power (kilowatts)")
hist(Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power") 

# plot 1
hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# tests for plot 2 + plot 2
# for english weekday names locale must be set. this wwas done above
plot(dtp, Global_active_power)
plot(dtp, Global_active_power, type="l")
plot(dtp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# plot 3
plot(dtp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dtp, Sub_metering_2, col="red")
lines(dtp, Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# tests for subplots to plot 4
plot(dtp, Voltage, type="l", xlab="datetime") # subplot
plot(dtp, Global_reactive_power, type="l", xlab="datetime") # subplot

# plot 4
par(mfrow = c(2,2)) # grid for subplots
plot(dtp, Global_active_power, type="l", xlab="", ylab="Global Active Power") # subplot 1
plot(dtp, Voltage, type="l", xlab="datetime") # subplot 2
plot(dtp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering") # start subplot 3
lines(dtp, Sub_metering_2, col="red")
lines(dtp, Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(dtp, Global_reactive_power, type="l", xlab="datetime") # subplot 4
par(mfrow=c(1,1)) # reset grit

Sys.setlocale(category = "LC_ALL", locale = "") # reset locale
