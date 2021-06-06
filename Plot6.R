source('~/RStudio/EDA-Course-Project-2/Common.R')
library(dplyr)

if(!exists("LA")){
    #Added code to create LA in the code
    NEI[NEI$fips=="06037",1:6]->LA
}

if(!exists("motorb")){
    #Search for all the SCC codes corresponding to vehicles
    SCC$SCC[grep("Vehicle", SCC$SCC.Level.Two)] -> codes
    #Find matches in NEI (time consuming and inefficient, but it works)
    scclist = matches(as.character(codes),vars = baltimore$SCC)
    motorb <- baltimore[scclist,1:6]
    scclist = matches(as.character(codes),vars = baltimore$SCC)
    motorl <- LA[scclist,1:6]
}

motorb %>%
    group_by(year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->motorbsum #finds the sum of emissions by year

motorl %>%
    group_by(year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->motorlsum #finds the sum of emissions by year

#create the graph, with appropriate labels and axes
with(motorlsum, plot(year, log(Emissions), type ="n"))
with(motorlsum, lines(year,log(Emissions), col ="blue"))
with(motorbsum, lines(year,log(Emissions), col ="red"))