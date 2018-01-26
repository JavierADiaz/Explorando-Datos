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


# PLOT 2
# Plot the variable Global Activity Power vs. time
# Convert Date and Time in one vector datetime
x<- paste(hpcdata$Time,hpcdata$Date)
datetime<- strptime(x,"%H:%M:%S %d/%m/%Y " )

# Plot of the Global Active Power variable for the period defined
plot(datetime, hpcdata$Global_active_power,type="l", 
     xlab ="",ylab = "Global Active Power (kilowatts)")

# Copy in a PNG file
dev.copy(png,"Plot2.png ")
dev.off()