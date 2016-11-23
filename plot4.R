rm(list=ls()) #Remove all objects
cat("\014") #Clear console
getwd()
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# subsetting SCC with coal values
coalMatches  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
subsetSCC <- SCC[coalMatches, ]

# merging dataframes
NEISCC <- merge(NEI, subsetSCC, by="SCC")

# sum of emission data per year
totalEmissions <- tapply(NEISCC$Emissions, NEISCC$year, sum)

# plot4
png(filename='plot4.png')

barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from coal sources")

dev.off()
