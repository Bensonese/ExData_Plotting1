
#Assume the original data is in the working directory
#Read the data and subset them to the desired dates

setwd("C://4 Exploratory Data Analysis")
all_data <- read.table("power_consumption_data.txt", header = TRUE, sep = ";", 
                       na.strings = "?", stringsAsFactors = FALSE)
x <- subset(all_data, Date == "1/2/2007")
y <- subset(all_data, Date == "2/2/2007")
z <- rbind(x, y)
row.names(z) <- NULL

#Create a new variable "Date_Time" that contains the complete time in POSIXct format

z <- within(z, Instance <- paste(Date, Time))
tidy_data <- within(z, Date_Time <- as.POSIXct(strptime(Instance, 
                    format = "%d/%m/%Y %H:%M:%S")))

#Create the plot and save it as a PNG file

par(mfrow = c(2,2))
with(tidy_data, {
     plot(Global_active_power ~ Date_Time, type = "l", 
     xlab = "", ylab = "Global Active Power")
     plot(Voltage ~ Date_Time, type = "l", xlab = "datetime")
     plot(Sub_metering_1 ~ Date_Time, type = "l", xlab = "", ylab = "Energy sub metering")
     points(Sub_metering_2 ~ Date_Time, type = "l", col = "red")
     points(Sub_metering_3 ~ Date_Time, type = "l", col = "blue")
     #text(2, 2, lty = 1, col = "black", "sub metering 1")
     legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
            c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", 
            xjust = 0, y.intersp = 0.5)
     plot(Global_reactive_power ~ Date_Time, type = "l", xlab = "datetime")
})
dev.copy(png, width = 800, height = 480, file = "plot4.png")
dev.off()