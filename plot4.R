#Plot4.R: creates grid of 4 plots


#######Get and clean data######
housePower <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",colClasses=c("character","character","character","character","character","character","character","character","numeric")) #get the data

housePower <- subset(housePower,as.Date(housePower$Date,format="%d/%m/%Y") >= "2007-02-01" & as.Date(housePower$Date,format="%d/%m/%Y") <= "2007-02-02") #get the dates we want

housePower <- transform(housePower, Global_active_power = as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power),Voltage=as.numeric(Voltage),Global_intensity=as.numeric(Global_intensity),Sub_metering_1 = as.numeric(Sub_metering_1),Sub_metering_2 = as.numeric(Sub_metering_2),Sub_metering_3=as.numeric(Sub_metering_3)) #convert all but dates to numeric

housePower <- subset(housePower,!is.na(Global_active_power) & !is.na(Global_reactive_power) & !is.na(Voltage) & !is.na(Global_intensity) & !is.na(Sub_metering_1) & !is.na(Sub_metering_2) & !is.na(Sub_metering_3)) #get rid of na's

housePower <- within(housePower, {timestamp = strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")}) #add timestamp

####make plot####
png(filename="plot4.png")
par(mfrow=c(2,2))
plot(housePower$timestamp,housePower$Global_active_power,'l',xlab="",ylab="Global Active Power (kilowatts)",main="") 
plot(housePower$timestamp,housePower$Voltage,'l',xlab="",ylab="Voltage",main="")
plot(housePower$timestamp,housePower$Sub_metering_1,'l',col="black",main="",xlab="",ylab="Energy sub metering")
lines(housePower$timestamp,housePower$Sub_metering_2,col="red")
lines(housePower$timestamp,housePower$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(housePower$timestamp,housePower$Global_reactive_power,'l',xlab="",ylab="Global_reactive_power",main="")
dev.off()
