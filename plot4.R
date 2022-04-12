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

#and plot. First we tell prepare the graphic device to include 4 graphics

png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

#First
plot(x=data2$Date, 
     y=data2$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

#Second
plot (x=data3$Date, 
      y=data3$Voltage,
      type = "l",
      xlab = "datatime",
      ylab = "Voltage")

#Third
plot (x=data$Date, 
      y=data$Sub_metering_1,
      type = "l",
      ylab = "Energy sub metering",
      xlab = "")

lines(x=data$Date,
      y=data$Sub_metering_2,
      col="Red")

lines(x=data$Date,
      y=data$Sub_metering_3,
      col="Blue")

legend("topright", 
       legend = c("Sub_metering 1","Sub_metering 2", "Sub_metering 3"),
       lwd = 1,
       col = c("black", "red", "blue"),
       cex = 1)

#Fourth
plot (x=data3$Date, 
      y=data3$Global_reactive_power,
      type = "l",
      xlab = "datatime",
      ylab = "Global_reactive_power")

dev.off()

