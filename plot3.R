# plot3.R

# read file
col_name <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
col_class <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
x <- read.csv("household_power_consumption.txt", sep = ";", skip = 1, header = FALSE, col.names = col_name, colClasses = col_class, na.strings = "?")

# subset and convert Date/Time
x <- subset (x, x[,1]=="1/2/2007" | x[,1]=="2/2/2007")
x$Time <- strptime(paste(x$Date, x$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
#x$Date = as.Date(x$Date, "%d/%m/%Y")

# I need to change locale so that weekdays appear in english, not spanish
orginal_locale = Sys.getlocale("LC_TIME")
Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF-8")

#open PNG file and do the plot
png(filename="plot3.png", width = 480, height = 480)

plot (x$Time, x$Sub_metering_1, type = "n", xlab="", ylab = "Energy sub meterings")
lines (x$Time, x$Sub_metering_1)
lines (x$Time, x$Sub_metering_2,col="red")
lines (x$Time, x$Sub_metering_3,col="blue")
legend("topright", lty = "solid", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()

# Set back original locale
Sys.setlocale(category = "LC_TIME", locale = "es_ES.UTF-8")
