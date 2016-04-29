library(data.table)
library(dplyr)
library(ggplot2)

# Read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEItab<-data.table(NEI)
SCCtab<-data.table(SCC)
remove(NEI,SCC)

# Filter Baltimore motor vehicles
Balt<-filter(NEItab,fips=="24510")
MotorCode<-filter(SCCtab,grepl('Motor|Vehicle',Short.Name))
Balt<-filter(Balt,SCC%in%MotorCode$SCC)
Balt<-summarize(group_by(Balt,year),sum(Emissions))

# Filter Los Angeles County

LA<-filter(NEItab,fips=="06037")
LA<-filter(LA,SCC%in%MotorCode$SCC)
LA<-summarize(group_by(LA,year),sum(Emissions))
png("plot6.png")
ggplot()+
    ggtitle("Motor Vehicle Emissions in Los Angeles and Baltimore")+
    geom_line(data = Balt,aes(x=year,y=`sum(Emissions)`,color="Baltimore"))+
    geom_line(data = LA,aes(x=year,y=`sum(Emissions)`,color="Los Angeles"))+
    theme(legend.position="right")+
    labs(y="Emissions",x="Year",color=NULL)
dev.off()
