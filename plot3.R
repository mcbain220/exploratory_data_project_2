require("dplyr")
require("reshape2")
require("ggplot2")

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

baltimore <- NEI[NEI$fips == "24510",]
baltimore_by_year_detailed <- aggregate(Emissions ~ year + type, baltimore, sum)

# Plot

png("./plot3.png")

g <- ggplot(baltimore_by_year_detailed, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab("Total PM Emissions") +
  ggtitle('Total Emissions by type in Baltimore City')
print(g)

dev.off()