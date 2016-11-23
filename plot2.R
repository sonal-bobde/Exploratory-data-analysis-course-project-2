rm(list=ls()) #Remove all objects
cat("\014") #Clear console
getwd()

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Have total emissions from PM2.5 decreased in the Baltimore City, 
##Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.

balt <- subset(NEI, fips == "24510")

# sum of emissions per year
totalEmissions <- tapply(balt$Emissions, balt$year, sum)

# plot2
png(filename='plot2.png')

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission per year in Baltimore")

dev.off()