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

# find coal combustion related NEI data
index <- which( grepl("coal",SCC[,"Short.Name"]) ) 
index2 <- which( grepl("Coal",SCC[,"Short.Name"]) ) 
allindex <- unique (sort (c(index,index2)))
SCC_coal <- SCC[allindex,]
#get data subset for coal, caculate total emission
NEI_coal <- NEI[which(NEI$SCC %in% Source_db_coal$SCC),]
combustionNEI <- tapply(NEI_coal$Emissions,NEI_coal$year,sum)

#making a vector with years for axis
years <- unique(NEI$year)

#saving plot
png("plot4.png")

#drawing plot
plot(combustionNEI,type="o",xaxt ="n",xlab = "Year",ylab="Emissions",main = "Total Emissions from coal combustion-related sources",col="red", cex = 3, lwd = 3)
axis(side=1,labels=as.character(years),at=1:length(years))

dev.off()

