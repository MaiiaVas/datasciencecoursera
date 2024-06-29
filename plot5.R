#load packages
library("data.table")
library(tidyverse)
library(ggplot2)

#read the fles
NEI <- read_rds("C:/Users/vasilieva/Desktop/datasciencecoursera/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- read_rds("C:/Users/vasilieva/Desktop/datasciencecoursera/exdata_data_NEI_data/Source_Classification_Code.rds")

#look base information about dfs
summary(NEI)
str(NEI)

summary(SCC)
str(SCC)

Baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
Baltimore$year <- factor(Baltimore$year, levels = c('1999', '2002', '2005', '2008'))
BaltimoreNEI <- aggregate(Baltimore[, "Emissions"], by = list(Baltimore$year), sum)
colnames(BaltimoreNEI) <- c("year", "Emissions")

#saving plot
png("plot5.png")

#drawing plot
ggplot(BaltimoreNEI, aes(x = year, y = Emissions)) + 
  geom_bar(aes(fill=year), stat="identity") +  
  ylab("Emissions  (in tons)") + xlab("Year") + 
  scale_fill_brewer(palette="Spectral") +
  ggtitle("Total Emissions of Motor Vehicles in Baltimore") 

dev.off()