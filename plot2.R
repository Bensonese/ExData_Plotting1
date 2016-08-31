
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

par(mfrow = c(1,1))
plot(tidy_data$Global_active_power ~ tidy_data$Date_Time, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, width = 480, height = 480, file = "plot2.png")
dev.off()