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

balt_motor <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD", ]
balt_motor_by_year <- aggregate(Emissions ~ year, balt_motor, sum)

# Plot

png("./plot5.png")
g <- ggplot(balt_motor, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab("Total PM Emissions") +
  ggtitle('Total Emissions from Baltimore motor vehicle sources by year')
print(g)
dev.off()