#read the unzipped file and subset the data frame 
data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
subdata <- subset(data, as.Date(Date, format="%d/%m/%Y")>="2007-02-01" & as.Date(Date, format="%d/%m/%Y")<="2007-02-02")
#head(subdata)

#add a column of "date and time" into date frame
library(dplyr)
temp <- mutate(subdata, DateAndTime = as.POSIXct(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")))
head(temp)

#plot
Sys.setlocale("LC_TIME", "English")
png("plot4.png")
#parametres
par(mfrow=c(2,2), mar=c(4,4,4,2))
#(1,1)
with(temp, plot(DateAndTime, Global_active_power, type="l", xlab="", ylab="Gloabl Active Power"))
#(1,2)
with(temp, plot(DateAndTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))
#(2,1)
plot(temp$DateAndTime, temp$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering", ylim=range(c(0,40)))
par(new=TRUE)
plot(temp$DateAndTime, temp$Sub_metering_2, type="l", col="red", xlab="", ylab="", ylim=range(c(0,40)))
par(new=TRUE)
plot(temp$DateAndTime, temp$Sub_metering_3, type="l", col="blue", xlab="", ylab="", ylim=range(c(0,40)))
legend("topright", lty=1, bty="n", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#(2,2)
with(temp, plot(DateAndTime, Global_reactive_power, type="l", xlab="datetime"))
#close
dev.off()
