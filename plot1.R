#load packages
library("data.table")
library(tidyverse)

#read the fles
NEI <- read_rds("C:/Users/vasilieva/Desktop/datasciencecoursera/exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- read_rds("C:/Users/vasilieva/Desktop/datasciencecoursera/exdata_data_NEI_data/Source_Classification_Code.rds")

#look base information about dfs
summary(NEI)
str(NEI)

summary(SCC)
str(SCC)

#find total emissions by years
total_NEI <- tapply((NEI$Emissions/1000),NEI$year,sum)
total_NEI

#making a vector with years for axis
years <- unique(NEI$year)

#saving plot
png("plot1.png", width=480, height=480)

#drawing plot
plot(total_NEI,type="o",xaxt ="n", xlab = "Year",ylab="Emissions (in kilotons)",main = 
       "Emissions over the Years in the U.S", col="red", cex = 3, lwd = 3)
axis(side=1,labels=as.character(years),at=1:length(years))

dev.off()