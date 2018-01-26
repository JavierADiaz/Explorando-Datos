# Create a working directory
library(data.table)


if(!file.exists("dataset")){
  dir.create("dataset")
}

# Data is downloaded and unzipped from the web site specified and unzipped
EPC<- tempepc()
fileUlr<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUlr,destfile = "./dataset/EPC")

unzip ("EPC","household_power_consumption.txt")
unlink("EPC")

# Read and get a subset of data for the days has been defined

hpcdata<-read.table("household_power_consumption.txt", sep =";", 
                    na.strings = "?", header=T)
hpcdata<- data.table(hpcdata)
setkey(hpcdata,Date)
hpcdata<- hpcdata[c("1/2/2007","2/2/2007")]


# Convert Date and Time in one vector datetime
x<- paste(hpcdata$Time,hpcdata$Date)
datetime<- strptime(x,"%H:%M:%S %d/%m/%Y " )

# PLOT 4
# Drawing 4 plots in a 2x2 frame: 
#     Global Active power Vs time, Voltages vs time
#     Energy sub metering vs time and Global reactive Power vs time
par(mfrow = c(2,2))

# Plot of the Global Active Power variable for the period defined
# in frame (1,1)
plot(datetime, hpcdata$Global_active_power,type="l", 
     xlab ="",ylab = "Global Active Power (kilowatts)")

# Plots variable voltage vs time
# in frame (1,2)
plot(datetime,hpcdata$Voltage, type= "l", xlab ="", ylab = "Voltage")

#Plot sub metering 1
# in frame (2,1)
plot(datetime,hpcdata$Sub_metering_1, type ="l", 
     xlab = "", ylab =" Energy sub metering")

# Plot Sub meterin 2 and 3
lines(datetime,hpcdata$Sub_metering_2, type = "l", col = "red")
lines(datetime,hpcdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), 
       legend= c("Sub metering 1","Sub metering 2","Sub metering 3"))

#Plots variables Goble  Reactive power vs time
# in frame (2,2)
plot(datetime,hpcdata$Global_reactive_power, type= "l",
     xlab ="", ylab ="Gloabal reactive power")

# Copy in a PNG file
dev.copy(png,"Plot4.png")
dev.off()


