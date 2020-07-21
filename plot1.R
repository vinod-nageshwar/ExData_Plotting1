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
df$Global_active_power <- as.numeric(df$Global_active_power)

dfFinal <- df %>% filter(Date>=as.Date("2007-02-01") &  Date <=as.Date("2007-02-02")) 

png(file="plot1.png",width=480, height=480)
hist(dfFinal$Global_active_power,col="red", xlab="Global Active Power(kilowats)", main = "Global Active Power")
dev.off()