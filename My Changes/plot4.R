

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
png(file = "plot4.png") 

# Making space for 4 graphs as an empty 2X2 matrix
par(mfrow =c(2,2)) 


# The first Graph
plot(
        Data$DateTime, 
        Data$Global_active_power, 
        ylab = "Global Active Power (kilowatts)", xlab = "",
        type = "l"
    )

# The second
plot(    
         Data$DateTime, 
         Data$Voltage, 
         type="l", 
         xlab = "datetime", 
         ylab="Voltage"
     )


#the Third
plot(
      Data$DateTime,
      Data$Sub_metering_1,
      ylab = "Energy sub metering", xlab = "",
      type = "l"
    )

lines(Data$DateTime, Data$Sub_metering_2,type ="l", col ="red")
lines(Data$DateTime, Data$Sub_metering_3,type ="l", col ="blue")

legend(           
        "topright", 
        lty = 1,
        legend = c(
                      "Sub_metering_1", 
                      "Sub_metering_2",
                      "Sub_metering_3"
                   ),
        col= c("black","red","blue") 
        
        )

#The last one

plot(
     Data$DateTime, 
     Data$Global_reactive_power, 
     xlab = "datetime", 
     type = "l"
     )


# ending our plotting and closing the png graphics device.
dev.off()