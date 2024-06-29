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

#find total emissions by years in Baltimore
baltimoreNEI <- NEI[NEI$fips=="24510",]
total_BaltimoreNEI <- tapply(baltimoreNEI$Emissions,baltimoreNEI$year,sum)
total_BaltimoreNEI

#making a vector with years for axis
years <- unique(NEI$year)

#saving plot
png("plot2.png", width=480, height=480)

#drawing plot
plot(total_BaltimoreNEI,type="o",xaxt ="n",xlab = "Year",ylab="Emissions",main = "Emissions over the Years in Baltimore",col="red", cex = 3, lwd = 3)
axis(side=1,labels=as.character(years),at=1:length(years))

dev.off()