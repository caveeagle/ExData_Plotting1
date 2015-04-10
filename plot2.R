
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

# Plot 2
# ( type: "l" for lines )

plot(DATA$Global_active_power~DATA$DT, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# Save to file

dev.copy(png, file="plot2.png", height=480, width=480)

dev.off()

