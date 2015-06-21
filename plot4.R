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
coal_in_NEI <- grepl("coal",NEI$Short.Name,ignore.case = TRUE)

coal <- NEI[coal_in_NEI,]
coal_by_year <- aggregate(Emissions ~ year, coal, sum)

# Plot

png("./plot4.png")
g <- ggplot(coal_by_year, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab("Total PM Emissions") +
  ggtitle('Total Emissions from coal sources by year')
print(g)
dev.off()