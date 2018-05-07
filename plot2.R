#Read .rds data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")

#Create subset of Baltimore City
bcsub <- NEI[NEI$fips == "24510",]
bcyrsum <- with(bcsub, tapply(Emissions, year, sum))
barplot(bcyrsum, names.arg = names(yrsum), main = "Total PM2.5 emissions in Baltimore City by year", xlab = "Year", ylab = "PM2.5 Emissions (Tons)", ylim = c(0, 3500))

#Save plot to file
dev.copy(png, "plot2.png")
dev.off()