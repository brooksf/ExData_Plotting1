## first grab the column names
column_names <- read.table('household_power_consumption.txt', sep=';', stringsAsFactors=F, nrows=1)

## from a quick grep, 'grep -n -w "1/2/2007" household_power_consumption.txt | head -1'
## we know exactly where to begin reading the given file without reading it all into R
## we also know from either another grep or arithmetic that we want 2880 rows of data
## note that this row counting works because the requested date range is complete (no NAs)
## if there were missing values, we could simply count them then change nrows accordingly

## read in the data while assigning the columns their proper names -- it's FAST!
data <- read.table('household_power_consumption.txt', sep=';', stringsAsFactors=F, skip=66637, nrows=2880, col.names=column_names)

## create a new variable that combines the given date and time into a single time
data$datetime <- strptime(paste(data$Date,data$Time), format='%d/%m/%Y %H:%M:%S')

## set the output device
png('plot4.png', bg='transparent')

## set the plot layout
par(mfrow=c(2,2))

## top-left plot
plot(data$datetime,data$Global_active_power,xlab='',ylab='Global Active Power',type='l')

## top-right plot
with(data, plot(datetime, Voltage,type='l'))

## bottom-left plot
plot(data$datetime,data$Sub_metering_1,xlab='',ylab='Energy sub metering',type='l')
lines(data$datetime,data$Sub_metering_2,type='l',col='red')
lines(data$datetime,data$Sub_metering_3,type='l',col='blue')

## bottom-right plot
with(data, plot(datetime,Global_reactive_power,type='l'))

## close the device (this is required to actually save the file)
dev.off()
