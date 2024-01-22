#I start by unzipping the files and setting a data handle to work with. Notice that you have to switch "\" for "/" for  R to read the file path as a file path.
#To run this code, you will have to adapt the file path to yours.

unzip ("D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption.zip", exdir = "D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption")
elec <- read.delim2(file ="D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", dec = ".")

head(elec)
#Note: R automatically changes ; to . with the read.delim2 function, unless you state what the separator is. I was geting typos, so I checked the data manually and noticed this.
#In doubt, check the data manually or, for big datasets, use alternative R read methods or another program like Python to make sure your R raw header is indeed like the raw txt data header.

#Now to subset data to the requested 2-day period:
elec_2d <- subset(elec,elec$Date == "1/2/2007"|elec$Date == "2/2/2007")

#The next section is not required at all, but for the sake of having a meaningful dataset on the X axis,
# I am using dplyr to create a Date + Time column and then I am converting it into a a Date/Time R object.

library(dplyr)
library(lubridate)

elec_2d_day_time <-elec_2d %>%
    select (everything())%>%
    mutate(Date_Time = paste(elec_2d$Date,elec_2d$Time, sep = " "))

elec_dt <-elec_2d_day_time %>%
    select(-c(Date,Time))
dt_vector <- elec_dt$Date_Time
dt_converted <- strptime(dt_vector, format = "%d/%m/%Y %H:%M:%S")
dt_weekdays <- wday(dt_converted, label = TRUE)

#If you are not American, you may want to convert your local time just in case some exercises require an American English date output.
# Use -> Sys.setlocale("LC_TIME", "English")
#At the end I will run Sys.setlocale("LC_TIME", "Portuguese_Portugal") to set the time back to my local time.

#Now for the plot! Under normal conditions plotting x vs y should give you the right labels. But as 
#the exercise requires 3 weekday labels, specifically with the abbreviated day of the week, we have to change it.
#Furthermore, as the dataset we have comprises only 2 days of the week, we have not much use for the "dt_weekdays" object -
#- we simply have to create our own vector "c("Thu","Fri","Sat")".

#While plotting, use xaxt = "n" so we do not have a x axis when we start the plot. Use xlab = "" as well, since this object does not have an X label.
#All this said, let us proceed to the plot:

par(mfrow = c(1,1))
plot(elec_2d$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)",xlab = "", xaxt = "n" )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))

#There it is! Now let us create the PNG by designing the plot in a PNG graphic device:

png("plot2.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
plot(elec_2d$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)",xlab = "", xaxt = "n" )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))
dev.off()

#Done!





