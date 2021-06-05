if(!exists("SCC"))
    SCC <- readRDS("~/RStudio/EDA-Course-Project-2/Source_Classification_Code.rds")
if(!exists("NEI"))
    NEI <- readRDS("~/RStudio/EDA-Course-Project-2/summarySCC_PM25.rds")

#selects the baltimore data from the dataset
if(!exists("baltimore"))
    NEI[NEI$fips==24510,1:6]->baltimore

#creates a function which extracts the sum of emissions for each year
pmsum <- function(frame){
    sum(frame$Emissions)
}