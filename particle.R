# Exploratory Data Analysis Course Project 2

require("dplyr")
require("reshape2")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "./particle.zip",method="curl")
unzip("./particle.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Join SCC data to NEI

NEI <- left_join(NEI, SCC, by = c("SCC" = "SCC"))

# Data Subsets

# baltimore <- 


# Questions to Address:

# 1)  Have total emissions from PM2.5 decreased in the united states from 99 to 08? USE BASE PLOTTING SYSTEM
# make a plot showing TOTAL pm2.5 emissions from all sources for each years (looks like data skips some years)
# Looks like this will be a scatter plot & trend line?  do by year?

# 2) Have tootal PM2.5 decrease in Balt City, Maryland (fips == 24510).  same plot as above

# 3) Of four types of sources indicated by 'type', which have seen decreases in balt city?  
# use ggplot and facets here.

# 4) Accrss US, how have emissions from coal combustion sources changed..

# 5) same for motor vehicles for balt city.

# 6) compare balt city emissions for motor ehicle to LA (fips 06037).  which city has seen greater changes
# over time.

# CONSTRUCT EACH PLOT TO A PNG FILE.  