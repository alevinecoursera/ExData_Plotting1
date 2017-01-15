#Plot3.R: plots submetering vs time


#######Get and clean data######
housePower <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",colClasses=c("character","character","character","character","character","character","character","character","numeric"))

#get the dates we want
housePower <- subset(housePower,as.Date(housePower$Date,format="%d/%m/%Y") >= "2007-02-01" & as.Date(housePower$Date,format="%d/%m/%Y") <= "2007-02-02")

#convert all but dates to numeric
housePower <- transform(housePower, Global_active_power = as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power),Voltage=as.numeric(Voltage),Global_intensity=as.numeric(Global_intensity),Sub_metering_1 = as.numeric(Sub_metering_1),Sub_metering_2 = as.numeric(Sub_metering_2),Sub_metering_3=as.numeric(Sub_metering_3))

#get rid of na's
housePower <- subset(housePower,!is.na(Global_active_power) & !is.na(Global_reactive_power) & !is.na(Voltage) & !is.na(Global_intensity) & !is.na(Sub_metering_1) & !is.na(Sub_metering_2) & !is.na(Sub_metering_3))

#add timestamp
housePower <- within(housePower, {timestamp = strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")}) 

####make plot####
png(filename="plot3.png")
plot(housePower$timestamp,housePower$Sub_metering_1,'l',col="black",main="",xlab="",ylab="Energy sub metering")
lines(housePower$timestamp,housePower$Sub_metering_2,col="red")
lines(housePower$timestamp,housePower$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
