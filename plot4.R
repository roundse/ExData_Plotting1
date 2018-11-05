# Set the size of the figure window based on
# the number of panels there will be.

par(mfrow = c(2,2))

# Step 1: Prep the data for plotting.

# Unzip the downloaded data (assume this has already been done.)
# Read in the text file as a table.
# Since it is separated by semicolons, set sep to ";".
# Convert the table to a data frame.

data <- read.table("household_power_consumption.txt",sep=";",
                   header=TRUE,colClasses="character")

# Subset the data to get only the dates specified by the assignment.
sub_data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

# Remove NAs and NANs.
new_data <- sub_data[!is.na(sub_data$Global_active_power),]

# Combine the dates/times into one variable.
new_data$Date <- as.Date(new_data$Date, format="%d/%m/%Y")
new_data$Time <- strptime(paste(new_data$Date, new_data$Time), 
                          "%Y-%m-%d %H:%M:%S")

# Step 2: Make the line plots...

# Copy the first one from plot2.R
plot(new_data$Time, new_data$Global_active_power, type="l", 
     ylab = "Global Active Power (kilowatts)", xlab = "",
     cex = 0.5)

# Plot the voltage
plot(new_data$Time, new_data$Voltage, type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Copy the third one from plot3.R
plot(new_data$Time, new_data$Sub_metering_1, type="l", 
     ylab = "Energy sub metering", xlab = "")
lines(new_data$Time, new_data$Sub_metering_2, col = "red")
lines(new_data$Time, new_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), 
       lty = c(1, 1, 1, 1),
       col = c("black", "red", "blue"),
       cex = 0.5, y.intersp = 0.6)

# Plot global reactive power
Global_reactive_power <- new_data$Global_reactive_power
datetime <- new_data$Time

plot(datetime, Global_reactive_power, type = "l", ylim = c(0.0, 0.5))

#Step 3: Save plot to PNG device.

dev.copy(png, "plot4.png")
dev.off()

