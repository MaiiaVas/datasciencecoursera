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

#find total emissions in Baltimore
baltimoreNEI <- NEI[NEI$fips=="24510",]

#saving plot
png("plot3.png", width=480, height=480)

#drawing plot
ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  scale_fill_brewer(palette="Spectral") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y="Emission") + 
  labs(title="Emissions over the Years in Baltimore by Source Type")

dev.off()