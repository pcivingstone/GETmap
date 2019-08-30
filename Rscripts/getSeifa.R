# getSeifa.R

# myFilename <- 'c://Projects/commonData/seifa.txt'
# myFilename <- 'c:/Users/Paul/projects/common/seifa.txt'
myFilename <- 'data/seifa.txt'
sesData <- fread(myFilename)
# sesData[, blank := NULL]
# sesData[, population := stripComma(population)]
setorder(sesData, postcode)
str(sesData)
tables()
