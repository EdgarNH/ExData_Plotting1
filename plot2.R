# We create the data directory, download our data and unzip it.
if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="data/UCI HAR Dataset.zip",method="curl")
unzip(zipfile="data/UCI HAR Dataset.zip",exdir="data")

# We load the necessary data. We specify ? as NA and then 
# subset to pick only the dates we need.
data<-read.csv("data/household_power_consumption.txt",
               header = T,
               sep = ";",
               na.strings = "?"
)

data <- subset(data, Date == "1/2/2007"|Date=="2/2/2007")

#change local time to show days in english.
Sys.setlocale("LC_TIME", "C") 

#join hours, minutes and seconds with date to have a continuum time variable
data$Date <- as.Date(strptime(data$Date, "%d/%m/%Y"))

data$Date <-str_c(data$Date," ", data$Time) 

data$Date <- as.POSIXct(data$Date)

#and plot
png(file = "plot2.png", width = 480, height = 480)

plot(x=data2$Date, 
     y=data2$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")


dev.off()
