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


png(file = "plot1.png", width = 480, height = 480)

hist(data$Global_active_power, 
     col = "Red", 
     main= "Global Active Power", 
     xlab="Global Active Powr (kw)")
dev.off()

