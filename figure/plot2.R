#Download and unzip file#
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp)
unlink(temp)

#Subset data from requested dates#
rawdata <- read.table("./household_power_consumption.txt",header=TRUE, sep = ";", na.strings = c("?",""))
rawdata$Date <- as.Date(rawdata$Date, format = "%d/%m/%Y")
predatapower<- subset(rawdata, Date == "2007-02-01" | Date == "2007-02-02")

#create a date/time column#
DT<-as.POSIXct(paste(predatapower$Date, predatapower$Time), format="%Y-%m-%d %H:%M:%S")
datapower<-cbind(DT,predatapower[,3:9])

##create the plot and save it to PNG 480x480 file#
Sys.setlocale("LC_TIME", "English")
png("plot2.png", width = 480, height=480, type="window")
par(ps=12)
with(datapower,plot(DT, Global_active_power, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)"))
dev.off()