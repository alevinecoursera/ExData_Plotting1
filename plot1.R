#Plot1.R: creates global active power histogram


#######Get and clean data######
housePower <- read.csv("household_power_consumption.txt",header=TRUE,sep=";",colClasses=c("character","character","character","character","character","character","character","character","numeric")) #get the data

housePower <- subset(housePower,as.Date(housePower$Date,format="%d/%m/%Y") >= "2007-02-01" & as.Date(housePower$Date,format="%d/%m/%Y") <= "2007-02-02") #get the dates we want

housePower <- transform(housePower, Global_active_power = as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power),Voltage=as.numeric(Voltage),Global_intensity=as.numeric(Global_intensity),Sub_metering_1 = as.numeric(Sub_metering_1),Sub_metering_2 = as.numeric(Sub_metering_2),Sub_metering_3=as.numeric(Sub_metering_3)) #convert all but dates to numeric

housePower <- subset(housePower,!is.na(Global_active_power) & !is.na(Global_reactive_power) & !is.na(Voltage) & !is.na(Global_intensity) & !is.na(Sub_metering_1) & !is.na(Sub_metering_2) & !is.na(Sub_metering_3)) #get rid of na's

####make plot####
png(filename="plot1.png")
hist(housePower$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
dev.off()