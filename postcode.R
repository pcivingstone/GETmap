# postcode.R
# written by Paul
# to summarise lat & long by postcode
# last modified Apr 2019

source('Rscripts/setup.R', T)

# library(data.table)

myFilename <- 'c://Projects/commonData/australian_postcodes.csv'
myData <- fread(file = myFilename, na.strings = 'NULL')
myData
str(myData)

# myData$longNum <- ifelse(myData$long == 'NULL', NA, as.numeric(long))
# myData[, temp := ifelse(long == 'NULL', NA, as.numeric(long))]

myData <- myData[complete.cases(myData[, .(lat, long)])]
dim(myData)

pcData <- myData[
  , .(
    long = mean(long, na.rm = T)
    ,lat = mean(lat, na.rm = T)
    )
  , by = .(postcode)
  ]
pcData
pcData <- pcData[ long > 100]


qplot(long, lat, data = pcData)

pcData

saveRDS(pcData, 'pcData.rds')
