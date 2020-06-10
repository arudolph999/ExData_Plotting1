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

# Note the plot does not get produced in R directory, just as a png file.

png("plot4.png")

par(mfrow=c(2,2))

x1<-ymd_hms(paste(dat$Date,dat$Time))
y1<-as.numeric(as.character(dat$Global_active_power))
plot(x1,y1,type="l",ylab = "Global Active Power")

x2<-ymd_hms(paste(dat$Date,dat$Time))
y2<-as.numeric(as.character(dat$Voltage))
plot(x2,y2,type="l",xlab = "datetime",ylab = "Voltage")

x3<-ymd_hms(paste(dat$Date,dat$Time))
y3a<-as.numeric(as.character(dat$Sub_metering_1))
y3b<-as.numeric(as.character(dat$Sub_metering_2))
y3c<-as.numeric(as.character(dat$Sub_metering_3))
plot(x3,y3a,type="l",ylab = "Energy sub metering")
lines(x3,y3b,col = "red")
lines(x3,y3c,col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n", lwd = 1, col = c('black', 'red', 'blue'))

x4<-ymd_hms(paste(dat$Date,dat$Time))
y4<-as.numeric(as.character(dat$Global_reactive_power))
plot(x4,y4,type="l",xlab = "datetime",ylab = "Global_reactive_power")

dev.off()
  