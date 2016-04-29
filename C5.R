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
MotorCode<-filter(SCCtab,grepl('Motor|Vehicle',SCC.Level.Three)) # Regex search for a complete word.
Balt<-filter(Balt,SCC%in%MotorCode$SCC)
Balt<-summarize(group_by(Balt,year),sum(Emissions))
png("plot5.png")
qplot(data=Balt,x=year,y=`sum(Emissions)`,geom = "line",xlab="Year",ylab="Emissions (ton)",
      main="Emissions from Motor Vehicle Sources in Baltimore")
dev.off()
