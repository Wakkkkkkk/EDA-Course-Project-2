#source the common program so the data can be accessed
source('~/RStudio/EDA-Course-Project-2/Common.R')

#selects the baltimore data from the dataset
if(!exists("baltimore"))
    NEI[NEI$fips==24510,1:6]->baltimore

if(!exists("byrdat"))
    split(baltimore, baltimore$year)->byrdat

#creates a function which extracts the sum of emissions for each year
pmsum <- function(frame){
    #create a function which prints out the 
    sum(frame$Emissions)
}

#apply the function over the split-year data to find the total emissions by year
lapply(byrdat, pmsum) -> sums
unlist(sums) ->bvectform

png(file="plot2.png")
#create the graph, with appropriate labels and axes
plot(names(bvectform),bvectform, type="l", ylim = c(0,3500), ylab = "PM2.5 Emissions (tons)", xlab = "Year", main = "PM2.5 Emissions by Year in Baltimore")
dev.off()