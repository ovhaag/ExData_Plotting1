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
png(file="plot1.png")
hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()

# reset system 
Sys.setlocale(category = "LC_ALL", locale = "") # reset locale to default (on my system: german)
