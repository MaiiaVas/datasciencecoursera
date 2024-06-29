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

# Subset total emissions from motor vehicles in Baltimore
Baltimore <- subset(NEI, fips == "24510" & type == "ON-ROAD")
Baltimore$year <- factor(Baltimore$year, levels = c('1999', '2002', '2005', '2008'))
BaltimoreNEI <- cbind(aggregate(Baltimore[, "Emissions"], by = list(Baltimore$year), sum), City = "Baltimore")
colnames(BaltimoreNEI) <- c("year", "Emissions", "City")

# Aggregate total emissions from motor vehicles in Los Angeles
LosAng <- subset(NEI, fips == "06037" & type == "ON-ROAD")
LosAng$year <- factor(LosAng$year, levels = c('1999', '2002', '2005', '2008'))
LosAngNEI <- cbind(aggregate(LosAng[, "Emissions"], by = list(LosAng$year), sum), City = "Los Angeles")
colnames(LosAngNEI) <- c("year", "Emissions", "City")

Baltimore_LA <- rbind.data.frame (BaltimoreNEI, LosAngNEI)

#saving plot
png("plot6.png")

#drawing plot
ggplot(Baltimore_LA, aes(year, Emissions)) + geom_bar(aes(fill = year), stat = "identity") + 
  facet_grid(. ~ City) + 
  scale_fill_brewer(palette="Spectral")  + 
  ylab("Emissions (in tons)") + xlab("Year") +
  ggtitle("Emissions from motor vehicles in Baltimore and in Los Angeles")
dev.off()