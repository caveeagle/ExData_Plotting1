
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

## Plot 3
with(DATA, {
  plot(Sub_metering_1~DT, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DT,col='Red')
  lines(Sub_metering_3~DT,col='Blue')
})


# Draw legend 
legend("topright", col=c("black", "red", "blue"), 
       lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save to file

dev.copy(png, file="plot3.png", height=480, width=480)

dev.off()

