#Load and prepare the household power consumption dataset for producing the corresponding plot
data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   colClasses = c("character", "character", rep("numeric",7)),
                   na = "?")
dim(data) # 2075259 9
attach(data)
## We only need data of 2 days.
subset <- Date == "1/2/2007" | Date == "2/2/2007"
newData <- data[subset, ]
attach(newData)
x <- paste(Date, Time)
newData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(newData) <- 1:nrow(newData)
dim(newData) # 2880   10
attach(newData)

#################################
#R scripts for producing plot 4##
#################################
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
par(mfrow = c(2, 2))
## Top-left
plot(DateTime, Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")

#####################
## Top-right plot  ##
#####################
plot(DateTime, Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")

#####################
## Bottom-left plot##     
#####################
plot(DateTime, Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(DateTime, Sub_metering_2, col = "red")
lines(DateTime, Sub_metering_3, col = "blue")

######################
# Borderless legend ##
######################
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
#######################
## Bottom-right plot ##
#######################
plot(DateTime, Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(newData)[4])
dev.off(

