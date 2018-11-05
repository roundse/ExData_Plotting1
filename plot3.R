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
new_data <- sub_data[!is.na(sub_data$Sub_metering_1) &
                       !is.na(sub_data$Sub_metering_2) & 
                       !is.na(sub_data$Sub_metering_3),]

# Combine the dates/times into one variable.
new_data$Date <- as.Date(new_data$Date, format="%d/%m/%Y")
new_data$Time <- strptime(paste(new_data$Date, new_data$Time), 
                          "%Y-%m-%d %H:%M:%S")

# Step 2: Make the line plot.

plot(new_data$Time, new_data$Sub_metering_1, type="l", 
     ylab = "Energy sub metering", xlab = "")
lines(new_data$Time, new_data$Sub_metering_2, col = "red")
lines(new_data$Time, new_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), 
       lty = c(1, 1, 1, 1),
       col = c("black", "red", "blue"))

#Step 3: Save plot to PNG device.

dev.copy(png, "plot3.png")
dev.off()
