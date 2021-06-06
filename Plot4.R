source('~/RStudio/EDA-Course-Project-2/Common.R')
library(dplyr)

if(!exists("coal")){
    #Search for all the SCC codes corresponding to coal combustion
    SCC$SCC[grep("Coal", SCC$Short.Name)] -> codes
    #Find matches in NEI (time consuming and inefficient, but it works)
    scclist = matches(as.character(codes),vars = NEI$SCC)
    coal <- NEI[scclist,1:6]
}

coal %>%
    group_by(year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->coalsum #finds the sum of emissions by year

png(file="plot4.png")
#create the graph, with appropriate labels and axes
plot(coalsum$year,coalsum$Emissions, type="l", ylim = c(0,700000), ylab = "PM2.5 Emissions (tons)", xlab = "Year", main = "PM2.5 Emissions by Coal-Related Sources in the US by Year")
dev.off()