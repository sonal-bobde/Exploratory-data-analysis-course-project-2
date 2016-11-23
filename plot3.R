rm(list=ls()) #Remove all objects
cat("\014") #Clear console
getwd()
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question

balt <- subset(NEI, fips == "24510")

# sum of emission data per year per type
data <- aggregate(Emissions ~ year + type, balt, sum)

# plot3
png(filename='plot3.png')

g <- ggplot(data, aes(year, Emissions, color = type))
g + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions per type in Baltimore")

dev.off()