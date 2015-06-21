require("dplyr")
require("reshape2")

# Download required data if NEI data is not present

if(!exists("NEI")){
  
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url, "./particle.zip",method="curl")
  unzip("./particle.zip")
  
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # Join SCC data to NEI
  
  NEI <- left_join(NEI, SCC, by = c("SCC" = "SCC"))
  
}

# Data Subsets & aggregations


baltimore <- NEI[NEI$fips == "24510" & NEI$type=="ON-ROAD",]
baltimore_by_year <- aggregate(Emissions ~ year + fips + type, baltimore, sum)
los_angeles <- NEI[NEI$fips == "06037" & NEI$type=="ON-ROAD",]
los_angeles_by_year <- aggregate(Emissions ~ year + fips + type, los_angeles, sum)
combined_data <- rbind(baltimore_by_year, los_angeles_by_year)

# Plot

png("./plot6.png")

g <- ggplot(combined_data, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab("Total PM Emissions") +
  ggtitle("Total Motor Vehicle Emissions by year - Los Angeles (06037) vs Baltimore (24510)")
print(g)

dev.off()