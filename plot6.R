library(ggplot2)
library(reshape2)
library(dplyr)

#Read .rds data files from working directory
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Merge NEI data frame with SCC data (only the EI.Sector variable needs to be added)
left_join(SCC, NEI, by = "SCC")
merged <- NEI %>% as_tibble() %>% left_join(SCC[, c("SCC", "EI.Sector")], by = "SCC")

#Subset and sum the data
motorsub <- merged[grep("vehicle", merged$EI.Sector, ignore.case=TRUE),]
bclasub <- motorsub[motorsub$fips == "24510" | motorsub$fips == "06037",]
yrsum <- with(bclasub, tapply(Emissions, list(year,fips), sum))

#Prepare plot data and save plot
plottable <- melt(yrsum)
names(plottable) <- c("year", "county", "value")
plottable$county[plottable$county == 6037] <- "Los Angeles County"
plottable$county[plottable$county == 24510] <- "Baltimore City"

g <- ggplot(plottable, aes(year, value)) +
  geom_line(aes(color = county)) +
  ggtitle("PM2.5 emissions in Baltimore City and Los Angeles County") +
  ylab("PM2.5 emissions (Tons)") +
  theme_bw()

ggsave("plot6.png", plot = g, device = "png")