library(ggplot2)
library(reshape2)
library(dplyr)

#Read .rds data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Merge NEI data frame with SCC data (only the EI.Sector variable needs to be added)
left_join(SCC, NEI, by = "SCC")
merged <- NEI %>% as_tibble() %>% left_join(SCC[, c("SCC", "EI.Sector")], by = "SCC")

#Subset only motor vehicle related sources in Baltimore City
motorsub <- merged[grep("vehicle", merged$EI.Sector, ignore.case=TRUE),]
motorbcsub <- motorsub[motorsub$fips == "24510",]
yrsum <- with(motorbcsub, tapply(Emissions, year, sum))

#Plot barchart
barplot(yrsum, names.arg = names(yrsum), main = "Total PM2.5 emissions by year for vehicle sources", xlab = "Year", ylab = "PM2.5 Emissions (Tons)", ylim = c(0, 400))
dev.copy(png, "plot5.png")
dev.off()