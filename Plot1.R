#source the common program so the data can be accessed
source('~/RStudio/EDA-Course-Project-2/Common.R')

#splits the data into different sets based on year
if(!exists("yrdat"))
    split(NEI, NEI$year)->yrdat

#apply the function over the split-year data to find the total emissions by year
lapply(yrdat, pmsum) -> sums
unlist(sums) ->vectform

png(file="plot1.png")
#create the graph, with appropriate labels and axes
plot(names(vectform),vectform, type="l", ylim = c(0,8000000), ylab = "PM2.5 Emissions (tons)", xlab = "Year", main = "PM2.5 Emissions by Year")
dev.off()