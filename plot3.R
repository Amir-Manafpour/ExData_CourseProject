library(ggplot2)
library(reshape2)

#Read .rds data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")

#Create subset of Baltimore City
bcsub <- NEI[NEI$fips == "24510",]
bctypesum <- data.frame(with(bcsub, tapply(Emissions, list(year, type), sum)))
#Reshape this data
plottable <- melt(as.matrix(bctypesum))
names(plottable) <- c("year", "type", "value")

#plot and save file
g <- ggplot(plottable, aes(year, value)) +
  geom_line(aes(color = type)) +
  ggtitle("PM2.5 emissions in Baltimore City by year and type") +
  ylab("PM2.5 emissions (Tons)") +
  theme_bw()

ggsave("plot3.png", plot = g, device = "png")