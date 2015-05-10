#download the zip file and unzip it
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./household_power_consumption.zip"
download.file(url, destfile) 
unzip(destfile)

#read the unzipped file and subset the data frame 
data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
sub.data <- subset(data, as.Date(Date, format="%d/%m/%Y")>="2007-02-01" & as.Date(Date, format="%d/%m/%Y")<="2007-02-02")

#plot my histogram
png("plot1.png")
hist(sub.data$Global_active_power, freq=TRUE, main="Gloabl Active Power", xlab="Gloabl Active Power(kilowatts)", col="red")
dev.off()