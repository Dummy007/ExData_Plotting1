library(sqldf) # To extract the desired data from the data file

#Loading the Data in R
Data <- read.csv.sql( 
                      "household_power_consumption.txt", 
                      # We only want the observation between 1/2/2007 and 2/2/2007'
                      sql = "select * from file where Date in ('1/2/2007','2/2/2007')",
                      sep = ";",
  
                      header = TRUE
                    )


# Now, we do some plotting 

# Opening a png graphics device
png(file = "plot1.png")

hist(
     
     Data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowats)"
    
    ) 

dev.off()