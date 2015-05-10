#read the unzipped file and subset the data frame 
data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
subdata <- subset(data, as.Date(Date, format="%d/%m/%Y")>="2007-02-01" & as.Date(Date, format="%d/%m/%Y")<="2007-02-02")
#head(subdata)

#add a column of "date and time" into date frame
library(dplyr)
temp <- mutate(subdata, DateAndTime = as.POSIXct(strptime(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")))
#head(temp)

#plot
Sys.setlocale("LC_TIME", "English")
png("plot2.png")
with(temp, plot(DateAndTime, Global_active_power, type="l", xlab="", ylab="Gloabl Active Power(kilowatts)"))
dev.off()
