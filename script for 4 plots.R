


## Download and load the data
library(tidyverse)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "data/hpc.zip")

unzip(zipfile = "data/hpc.zip", exdir = "data")

hpc<-read.delim("data/household_power_consumption.txt",sep=";")


## Subset the data
library(lubridate)
hpc$Date<-dmy(hpc$Date)
hpc2<-hpc %>% filter(Date=="2007-02-01"|Date=="2007-02-02")



#### plot 1 ####

class(hpc2$Global_active_power)
hpc2$Global_active_power<-as.numeric(as.character(hpc2$Global_active_power))

png(filename = "reproduced plots/plot1.png", width = 480, height = 480)
hist(hpc2$Global_active_power,col="red",
     main="Global Active Power (My plot no fake)",
     xlab="Global Active Power (kilowatts)")

dev.off()



#### plot 2 ####


hpc2$Time<-as.character(hpc2$Time)
hpc2$Date<-as.character(hpc2$Date)

hpc2$ymdhms <- ymd_hms(paste(hpc2$Date, hpc2$Time,sep=" ")) 

png(filename = "reproduced plots/plot2.png", width = 480, height = 480)

plot(hpc2$ymdhms,hpc2$Global_active_power,type="l",main="My plot, real no fake")

dev.off()

## The days its in spanish.




#### plot 3 ####

hpc2$Sub_metering_1<-as.numeric(as.character(hpc2$Sub_metering_1))
hpc2$Sub_metering_2<-as.numeric(as.character(hpc2$Sub_metering_2))
hpc2$Sub_metering_3<-as.numeric(as.character(hpc2$Sub_metering_3))

hpc2$energy<-(hpc2$Sub_metering_1+hpc2$Sub_metering_2+hpc2$Sub_metering_3)

png(filename = "reproduced plots/plot3.png", width = 480, height = 480)

with(hpc2, plot(ymdhms, energy, main = "Real no fake",type = "n",ylim=c(0,30)))
with(hpc2, points(ymdhms, Sub_metering_1, type = "l"))
with(hpc2, points(ymdhms, Sub_metering_2, type = "l",col="red"))
with(hpc2, points(ymdhms, Sub_metering_3, type = "l",col="blue"))

dev.off()



#### plot 4 ####

png(filename = "reproduced plots/plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

plot(hpc2$ymdhms,hpc2$Global_active_power,type="l")
plot(hpc2$ymdhms,hpc2$Voltage,type="l")

with(hpc2, plot(ymdhms, energy,type = "n",ylim=c(0,30)))
with(hpc2, points(ymdhms, Sub_metering_1, type = "l"))
with(hpc2, points(ymdhms, Sub_metering_2, type = "l",col="red"))
with(hpc2, points(ymdhms, Sub_metering_3, type = "l",col="blue"))

hpc2$Global_reactive_power<-as.numeric(as.character(hpc2$Global_reactive_power))
plot(hpc2$ymdhms,hpc2$Global_reactive_power,type="l")
axis(2,c(0,0.5,0.1))

dev.off()











