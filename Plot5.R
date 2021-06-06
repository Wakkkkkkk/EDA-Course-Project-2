source('~/RStudio/EDA-Course-Project-2/Common.R')
library(dplyr)

if(!exists("motor")){
    #Search for all the SCC codes corresponding to vehicles
    SCC$SCC[grep("Vehicle", SCC$SCC.Level.Two)] -> codes
    #Find matches in NEI (time consuming and inefficient, but it works)
    scclist = matches(as.character(codes),vars = baltimore$SCC)
    motor <- baltimore[scclist,1:6]
}

motor %>%
    group_by(year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->motorsum #finds the sum of emissions by year

png(file="plot5.png")
#create the graph, with appropriate labels and axes
plot(motorsum$year,motorsum$Emissions, type="l", ylim = c(0,500), ylab = "PM2.5 Emissions (tons)", xlab = "Year", main = "Baltimore Vehicle-Related PM2.5 Emissions by Year")
dev.off()