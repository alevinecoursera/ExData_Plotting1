#Plot2.R: plots global active power vs time


#######Get and clean data######
#get the data
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
png(filename="plot2.png")
plot(housePower$timestamp,housePower$Global_active_power,'l',xlab="",ylab="Global Active Power (kilowatts)",main="")
dev.off()
