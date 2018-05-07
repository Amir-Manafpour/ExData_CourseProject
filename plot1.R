#Read .rds data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")

#Create total PM2.5 emmision vs year plot
yrsum <- with(NEI, tapply(Emissions, year, sum))
barplot(yrsum, names.arg = names(yrsum), main = "Total PM2.5 emissions by year", xlab = "Year", ylab = "PM2.5 Emissions (Tons)", ylim = c(0, 8000000))

#Save plot to file
dev.copy(png, "plot1.png")
dev.off()
