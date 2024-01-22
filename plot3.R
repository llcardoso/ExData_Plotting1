#As these exercises have common ground with the previous ones, I will keep simple the commentary.

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

#check ranges to devide Y axis limits:
range(elec_2d$Sub_metering_1)
range(elec_2d$Sub_metering_2)
range(elec_2d$Sub_metering_3)

#Highest maximum is from Sub metering_1, so I will use it to set the Y axis range.

#Here goes the graph. Notice that I decided to introduce a figure design expression, par(new = TRUE), so that I could overlay 3 graphs.

par(mfrow = c(1,1))
plot(elec_2d$Sub_metering_1 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", ylim = c(0,38)) 
par(new = TRUE)
plot(elec_2d$Sub_metering_2 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", yaxt = "n", col = "red",ylim = c(0,38) )
par(new = TRUE)
plot(elec_2d$Sub_metering_3 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n",yaxt = "n", col = "blue",ylim = c(0,38) )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))

#Now for the PNG save:

png("plot3.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
plot(elec_2d$Sub_metering_1 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", ylim = c(0,38)) 
par(new = TRUE)
plot(elec_2d$Sub_metering_2 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n", yaxt = "n", col = "red",ylim = c(0,38) )
par(new = TRUE)
plot(elec_2d$Sub_metering_3 , type = "l",ylab = "Energy sub metering",xlab = "", xaxt = "n",yaxt = "n", col = "blue",ylim = c(0,38) )
axis(1, at = c(1,1440,2880), labels = c("Thu","Fri","Sat"))
dev.off()

#Done.

