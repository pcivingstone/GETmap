# getLatlong.R

myFilename <- 'c://Projects/commonData/australian_postcodes.csv'
myData <- fread(file = myFilename, na.strings = 'NULL')
dim(myData)
myData <- myData[type == 'Delivery Area']
dim(myData)
myData <- myData[complete.cases(myData[, .(lat, long)])]
dim(myData)
myData <- myData[ long > 100]
dim(myData)

pcData <- myData[
  , .(
    long = mean(long, na.rm = T)
    ,lat = mean(lat, na.rm = T)
    ,num = .N
    ,locale = paste(locality, collapse = ', ')
  )
  , by = .(postcode, State)
  ]
setorder(pcData, postcode, -num)
pcData <- pcData[, .SD[1], by = .(postcode)]

str(pcData)
tables()