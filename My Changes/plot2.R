library(sqldf) # To extract the desired data from the data file
library(dplyr) # To manipulate the Data as we see fit for our goal
library(lubridate) # To take care of the time and date columns 


#Loading the Data in R
Data <- read.csv.sql( 
                      "household_power_consumption.txt", 
                      # We only want the observation between 1/2/2007 and 2/2/2007'
                      sql = "select * from file where Date in ('1/2/2007','2/2/2007')",
                      sep = ";",
                     
                      header = TRUE
                   )

# Turning the Date and Time variables into a single variable DateTime
Data <- mutate(
                  Data, 
                  DateTime = dmy_hms(paste(Data$Date, Data$Time))
              )

# Getting rid of the Date and Time columns.
Data <- Data[, names(Data) != c("Date", "Time")]



# Now, we do some plotting 

# Opening a png graphics device
png(file = "plot2.png")

plot(
     Data$DateTime, 
     Data$Global_active_power, 
     ylab = "Global Active Power (kilowatts)", xlab = "",
     type = "l"
     )

dev.off()