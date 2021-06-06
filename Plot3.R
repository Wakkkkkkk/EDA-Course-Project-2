#source the common program so the data can be accessed
source('~/RStudio/EDA-Course-Project-2/Common.R')
library(ggplot2)
library(dplyr)

baltimore %>%
    group_by(type,year) %>% #Groups the data so it can be processed by summarise
    summarise(Emissions=sum(Emissions))->summaries #finds the sum of emissions by year-type pair

# putting the graph together
g <- ggplot(summaries,aes(year,Emissions)) + geom_line(aes(year,Emissions,color=type)) + labs(title= "Yearly Emissions in Baltimore by Type") + labs(y = "Emissions (tons)")
ggsave("plot3.png")