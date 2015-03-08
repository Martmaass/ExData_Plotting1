# load required packages
library(data.table)
library(lubridate)

# This script requires to have the raw data file saved in the current working directory
# read the raw data and subset 1/2/ and 2/2/ = 2 days
variable.class<-c(rep("character",2),rep("numeric",7))
  data<-read.table("household_power_consumption.txt",header=TRUE,
                                sep=";",na.strings="?",colClasses=variable.class)
  data<-data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

# clean up the variable names and convert date/time variables
  cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
          'SubMetering1','SubMetering2','SubMetering3')
  colnames(data)<-cols
  data$DateTime<-dmy(data$Date)+hms(data$Time)
  data<-data[,c(10,3:9)]

# write a clean data set to the directory
  write.table(data,file="data.txt",sep="|",row.names=FALSE)
	
# open device
png(filename="plot2.png",width=480,height=480,units="px")

# plot data
plot(data$DateTime,data$GlobalActivePower,ylab="Global Active Power (kilowatts)", xlab="", type="l")
# Turn off device
x<-dev.off()

