
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


total_by_year <- aggregate(Emissions ~ year, NEI, sum)

# Plot

png("./plot1.png")

barplot(total_by_year$Emissions, names.arg = total_by_year$year, xlab="Year", ylab="PM Emissions", main = "Total PM Emissions by Year")

dev.off()