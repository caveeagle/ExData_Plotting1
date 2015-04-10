
# Download and unzip file 

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

zipdir <- file.path(getwd(),"Data")

dir.create(zipdir)

zipfile <- file.path(zipdir,"household_power_consumption.zip")

download.file(url, zipfile)

unzip(zipfile,exdir=zipdir)

# Read data, prepare dataset, clear unnecessary data

RAWDATA <- read.csv("./Data/household_power_consumption.txt", 
                    header=TRUE, sep=';', na.strings="?",)


RAWDATA$Date <- as.Date(RAWDATA$Date, format="%d/%m/%Y")

DATA <- subset(RAWDATA, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

rm(RAWDATA)

# convert date and time to datetime column 'DT'

DT <- paste(as.Date(DATA$Date),DATA$Time)

DATA$DT <- as.POSIXct(DT)

## Plot 4 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(DATA, {
  plot(Global_active_power~DT, type="l",
       ylab="Global Active Power", xlab="")
  
  plot(Voltage~DT, type="l",
       ylab="Voltage", xlab="datetime")
  
  plot(Sub_metering_1~DT, type="l",
       ylab="Energy sub metering", xlab="")
  
  lines(Sub_metering_2~DT,col='Red')
  lines(Sub_metering_3~DT,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~DT, type="l",
       xlab="datetime")
})

# Save to file

dev.copy(png, file="plot4.png", height=480, width=480)

dev.off()

