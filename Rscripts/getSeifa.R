# getSeifa.R

myFilename <- 'c://Projects/commonData/seifa.txt'
sesData <- fread(myFilename)
sesData[, blank := NULL]
sesData[, population := stripComma(population)]
setorder(sesData, postcode)
str(sesData)
tables()
