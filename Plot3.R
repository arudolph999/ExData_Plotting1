# Libraries

library(dplyr)
library(lubridate)
library(datasets)

temp<-tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

hpc<-as.data.frame(read.table(unz(temp,"household_power_consumption.txt"),sep = ";", header = TRUE))

unlink(temp)

hpc$Date<-dmy(hpc$Date)

dat<-hpc %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

png("plot3.png")

par(mfrow=c(1,1))

x<-ymd_hms(paste(dat$Date,dat$Time))
y1<-as.numeric(as.character(dat$Sub_metering_1))
y2<-as.numeric(as.character(dat$Sub_metering_2))
y3<-as.numeric(as.character(dat$Sub_metering_3))

# Note the plot does not get produced in R directory, just as a png file.



plot(x,y1,type="l",xlab="",ylab = "Energy sub metering")
lines(x,y2,col = "red")
lines(x,y3,col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1, col = c('black', 'red', 'blue'))

dev.off()

