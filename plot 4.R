#Getting the data and Date Time files, in case they come in handy:

unzip ("D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption.zip", exdir = "D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption")
elec <- read.delim2(file ="D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", dec = ".")
elec_2d <- subset(elec,elec$Date == "1/2/2007"|elec$Date == "2/2/2007")

elec_2d_day_time <-elec_2d %>%
    select (everything())%>%
    mutate(Date_Time = paste(elec_2d$Date,elec_2d$Time, sep = " "))

elec_dt <-elec_2d_day_time %>%
    select(-c(Date,Time))
dt_vector <- elec_dt$Date_Time
dt_converted <- strptime(dt_vector, format = "%d/%m/%Y %H:%M:%S")

#Now for this exercise, we have to design 2 new graphs and co-opt the previous two, and set the 4 in a single figure.
#Let us set a figure with 4 graphs and start with the 2 previous graphs:

par(mfcol = c(2,2))
plot(elec_2d$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)",xlab = "", xaxt = "n", )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))

plot(elec_2d$Sub_metering_1 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", ylim = c(0,38)) 
par(new = TRUE)
plot(elec_2d$Sub_metering_2 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", yaxt = "n", col = "red",ylim = c(0,38) )
par(new = TRUE)
plot(elec_2d$Sub_metering_3 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n",yaxt = "n", col = "blue",ylim = c(0,38) )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))

#Let us now design the new ones:

plot(elec_2d$Voltage , type = "l",ylab = "Voltage",xlab = "", xaxt = "n")
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))

plot(elec_2d$Global_reactive_power , type = "l",ylab = "Global_reactive_power",xlab = "", xaxt = "n")
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))

#Nice! Now for the PNG, let us repeat the plotting on the appropriate device and close it.

png("plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2))
plot(elec_2d$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)",xlab = "", xaxt = "n", )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))
plot(elec_2d$Sub_metering_1 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", ylim = c(0,38)) 
par(new = TRUE)
plot(elec_2d$Sub_metering_2 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", yaxt = "n", col = "red",ylim = c(0,38) )
par(new = TRUE)
plot(elec_2d$Sub_metering_3 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n",yaxt = "n", col = "blue",ylim = c(0,38) )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))
plot(elec_2d$Voltage , type = "l",ylab = "Voltage",xlab = "", xaxt = "n")
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))
plot(elec_2d$Global_reactive_power , type = "l",ylab = "Global_reactive_power",xlab = "", xaxt = "n")
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))
dev.off()

#Done!


