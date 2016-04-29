library(data.table)
library(dplyr)
library(ggplot2)

# Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEItab<-data.table(NEI)
SCCtab<-data.table(SCC)
remove(NEI,SCC)

# Filter Baltimore
Balt<-filter(NEItab,fips=="24510")
Balt_total_by_year<-summarize(group_by(Balt,year),sum(Emissions))

# plot
png(filename = "plot2.png")
plot(Balt_total_by_year$year, Balt_total_by_year$`sum(Emissions)`,type='l',xlab="Year",
     ylab="Emissions (tons)",main="Baltimore Total Emissions from All Sources")
dev.off()
