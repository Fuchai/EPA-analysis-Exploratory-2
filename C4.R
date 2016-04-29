library(data.table)
library(dplyr)
library(ggplot2)

# Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEItab<-data.table(NEI)
SCCtab<-data.table(SCC)
remove(NEI,SCC)

# Filter coal combustion-related sources

CoalCombCode<-filter(SCCtab,grepl('Comb.*Coal|Coal.*Comb',EI.Sector))
CC<-filter(NEItab,SCC%in%CoalCombCode$SCC)
CC_by_year<-summarize(group_by(CC,year),sum(Emissions))

# plot
png("plot4.png")
qplot(data = CC_by_year,x=year,y=`sum(Emissions)`,geom="line",xlab = "Year",
      ylab="Emissions (tons)",main ="USA Coal Combustion Related Emission 1999-2008")
dev.off()
