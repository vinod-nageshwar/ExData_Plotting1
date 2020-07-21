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
#
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
#
dfFinal <- df %>% filter(Date>="2007-02-01" &  Date<="2007-02-02")

dfFinal$Date <- as.POSIXct(paste(dfFinal$Date,dfFinal$Time),format="%Y-%m-%d%H:%M:%OS")
#
dfFinal$Global_active_power <- as.numeric(dfFinal$Global_active_power)
dfFinal$Global_reactive_power <- as.numeric(dfFinal$Global_reactive_power)
dfFinal$Voltage <- as.numeric(dfFinal$Voltage )
dfFinal$Sub_metering_1 <- as.numeric(dfFinal$Sub_metering_1)
dfFinal$Sub_metering_2 <- as.numeric(dfFinal$Sub_metering_2)
dfFinal$Sub_metering_3 <- as.numeric(dfFinal$Sub_metering_3)
#
png(file="plot4.png",width=480, height=480)
par(mfrow=c(2,2))
#
# #Plot 1
hist(dfFinal$Global_active_power,col="red", xlab="Global Active Power(kilowats)",main="")

#Plot 2
plot(dfFinal$Date,dfFinal$Voltage,type="l",xlab="datetime",ylab="Voltage")

# #Plot 3
plot(dfFinal$Date,dfFinal$Sub_metering_1,type = "l",xlab = "", ylab = "Energy sub metering", main = "")
lines(dfFinal$Date,dfFinal$Sub_metering_2,col="red")
lines(dfFinal$Date,dfFinal$Sub_metering_3,col="blue")
#
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",cex=0.1)
#
# #Plot 4
plot(dfFinal$Date,dfFinal$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()