source('~/RStudio/EDA-Course-Project-2/Common.R')
library(dplyr)

if(!exists("LA")){
    #Added code to create LA in the code
    NEI[NEI$fips=="06037",1:6]->LA
}

if(!exists("motorb")){
    #Search for all the SCC codes corresponding to vehicles
    SCC$SCC[grep("Vehicle", SCC$EI.Sector)] -> codes
    #Find matches in NEI (time consuming and inefficient, but it works)
    scclist = matches(as.character(codes),vars = baltimore$SCC)
    motorb <- baltimore[scclist,1:6]
    scclist = matches(as.character(codes),vars = baltimore$SCC)
    motorl <- LA[scclist,1:6]
}

motorb %>%
    group_by(year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->motorbsum #finds the sum of emissions by year

LA[LA$type=="ON-ROAD", 1:6] -> lroad
lroad %>%
    group_by(year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->motorlsum #finds the sum of emissions by year

baltimore[baltimore$type=="ON-ROAD", 1:6] -> road
road %>%
    group_by(year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->motorbsum #finds the sum of emissions by year

#create the graph, with appropriate labels and axes
with(motorbsum, plot(year, log(Emissions), type ="n", main = "Vehicle PM2.5 Emissions by Locality", ylim = c(0,10)))
with(motorlsum, lines(year,log(Emissions), col ="blue"))
with(motorbsum, lines(year,log(Emissions), col ="red"))
legend("topright",col = c("red","blue"),lty = 1, legend = c("Baltimore", "Los Angeles"))