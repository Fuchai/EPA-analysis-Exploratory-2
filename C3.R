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
Balt_by_type<-summarize(group_by(Balt,type,year),sum(Emissions))
Balt_by_type<-rename(Balt_by_type,Emissions=`sum(Emissions)`)

# plot
png("plot3.png")
ggplot(data=Balt_by_type,aes(y=Emissions,x=year,group=type))+
    ggtitle("Four Types of Emissions in Baltimore")+
    geom_line(aes(color=type))+
    labs(y="Emissions (tons)",x="Year",color="Type")+ # in labs you change the legend name
    theme(legend.position="bottom")
dev.off()