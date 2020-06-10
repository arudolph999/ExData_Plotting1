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


x<-ymd_hms(paste(dat$Date,dat$Time))
y<-as.numeric(as.character(dat$Global_active_power))

png("plot2.png")
par(mfrow=c(1,1))

plot(x,y,type="l",ylab = "Global Active Power (kilowatts)")
dev.off()

