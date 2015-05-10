## first grab the column names
column_names <- read.table('household_power_consumption.txt', sep=';', stringsAsFactors=F, nrows=1)

## from a quick grep, 'grep -n -w "1/2/2007" household_power_consumption.txt | head -1'
## we know exactly where to begin reading the given file without reading it all into R
## we also know from either another grep or arithmetic that we want 2880 rows of data
## note that this row counting works because the requested date range is complete (no NAs)
## if there were missing values, we could simply count them then change nrows accordingly

## read in the data while assigning the columns their proper names -- it's FAST!
data <- read.table('household_power_consumption.txt', sep=';', stringsAsFactors=F, skip=66637, nrows=2880, col.names=column_names)

## set the output device
png('plot1.png', bg='transparent')

## generate the plot
hist(data$Global_active_power, main='Global Active Power', xlab='Global Active Power (kilowatts)', col='red')

## close the device (this is required to actually save the file)
dev.off()