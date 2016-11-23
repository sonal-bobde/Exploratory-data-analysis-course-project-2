rm(list=ls()) #Remove all objects
cat("\014") #Clear console
getwd()
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
balt <- subset(NEI, fips == "24510")


# subsetting SCC with vehicle values
vehicleMatches  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
subsetSCC <- SCC[vehicleMatches, ]

# merging dataframes
NEISCC <- merge(balt, subsetSCC, by="SCC")

# sum of emission data per year per type
totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

# plot5
png(filename='plot5.png')
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from motor sources in Baltimore")
dev.off()