library(data.table)
library(dplyr)
library(ggplot2)

# Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEItab<-data.table(NEI)
SCCtab<-data.table(SCC)
remove(NEI,SCC)

# Summarize total
sum_by_year<-summarize(group_by(NEItab,year),sum(Emissions))

# Plot
png(filename = "plot1.png")
plot(sum_by_year$year,sum_by_year$`sum(Emissions)`/1000000,type='l',xlab="Year",
     ylab="Emissions (million tons)",main="USA Total Emissions from All Sources")
dev.off()