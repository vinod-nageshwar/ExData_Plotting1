library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
folder <- getwd()
datafile <- "household_power_consumption.txt"
downloadpath <- paste(folder,zipfile,sep="")
sourcefile <- paste(folder,"/",datafile,sep="")

if(!file.exists(downloadpath))
{
  download.file(url,destfile =downloadpath)
}

if(file.exists(downloadpath))
{
  unzip(downloadpath)
}

df <- read.csv2(sourcefile,sep=";",header = TRUE) 

df$Date <- as.Date(df$Date, format="%d/%m/%Y")

dfFinal <- df %>% filter(Date>="2007-02-01" &  Date<="2007-02-02") %>% select(Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)

dfFinal$Date <- as.POSIXct(paste(dfFinal$Date,dfFinal$Time),format="%Y-%m-%d%H:%M:%OS")
dfFinal$Sub_metering_1 <- as.numeric(dfFinal$Sub_metering_1)
dfFinal$Sub_metering_2 <- as.numeric(dfFinal$Sub_metering_2)
dfFinal$Sub_metering_3 <- as.numeric(dfFinal$Sub_metering_3)

png(file="plot3.png",width=480, height=480)
plot(dfFinal$Date,dfFinal$Sub_metering_1,type = "l",xlab = "", ylab = "Energy sub metering", main = "")
lines(dfFinal$Date,dfFinal$Sub_metering_2,col="red") 
lines(dfFinal$Date,dfFinal$Sub_metering_3,col="blue") 

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col=c("black","red", "blue"), lty=1:1, cex=0.8)
dev.off()