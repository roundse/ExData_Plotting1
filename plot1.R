# Step 1: Prep the data for plotting.

# Unzip the downloaded data (assume this has already been done.)
# Read in the text file as a table.
# Since it is separated by semicolons, set sep to ";".
# Convert the table to a data frame.

data <- read.table("household_power_consumption.txt",sep=";",
                   header=TRUE,colClasses="character")

# Subset the data to get only the dates specified by the assignment.
sub_data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

# Subset the data to get only GAP; remove NAs and NANs.
gap_data <- as.numeric(sub_data$Global_active_power[!is.na(sub_data$Global_active_power)])

# Step 2: Make the histogram.

# Plot histogram with specified titles, labels, and aesthetic features.
hist(gap_data, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", ylim = c(0,1200), col = "red")

dev.copy(png,"plot1.png")
dev.off()
