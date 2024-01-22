
#I start by unzipping the files and setting a data handle to work with. Notice that you have to switch "\" for "/" for  R to read the file path as a file path.
#To run this code, you will have to adapt the file path to yours.

unzip ("D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption.zip", exdir = "D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption")
elec <- read.delim2(file ="D:/Script_playground/datasciencecoursera/exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";", dec = ".")

head(elec)
#Note: R automatically changes ; to . with the read.delim2 function, unless you state what the separator is. I was geting typos, so I checked the data manually and noticed this.
#In doubt, check the data manually or, for big datasets, use alternative R read methods or another program like Python to make sure your R raw header is indeed like the raw txt data header.

#Now to subset data to the requested 2-day period:
elec_2d <- subset(elec,elec$Date == "1/2/2007"|elec$Date == "2/2/2007")

#Now for the figure, setting as a single graph figure, turning the data as numeric and building the histogram as requested. 
par(mfrow = c(1,1))
elec_2d$Global_active_power <- as.numeric(elec_2d$Global_active_power)
hist(elec_2d$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")


#Taking that into account, we have finished exercise 1 except for the graphic device storage.
# To do so, we just have to change the device, in this case to png, repeat the graph build up and close the png graphic device.

png("plot1.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
elec_2d$Global_active_power <- as.numeric(elec_2d$Global_active_power)
hist(elec_2d$Global_active_power,col = "red",main = "Global Active Power",xlab = "Global Active Power (kilowatts)")
dev.off()

#That's it!!
