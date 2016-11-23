rm(list=ls()) #Remove all objects
cat("\014") #Clear console
getwd()
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
los <- subset(NEI, fips == "06037")
balt <- subset(NEI, fips == "24510")
# subsetting SCC with vehicle values
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# merging dataframes, adding city variable
dataBalt <- merge(balt, subsetSCC, by="SCC")
dataBalt$city <- "Baltimore City"
dataLos <- merge(los, subsetSCC, by="SCC")
dataLos$city <- "Los Angeles County"
data <- rbind(dataBalt, dataLos)

# sum of emission data per year per type
data <- aggregate(Emissions ~ year + city, data, sum)

# plot6
png(filename='plot6.png')
g <- ggplot(data, aes(year, Emissions, color = city))
g + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from motor sources in Baltimore and Los Angeles")
dev.off()