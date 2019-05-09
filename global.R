# global.R

source('Rscripts/setup.R',T)

# get data ----------------------------------------------------------------

# source('Rscripts/getData.R')
myData <- readRDS('pcData.rds')
df <- as.data.frame(myData)
df$Mw <- round(df$capacity/1000,3)

# df <- readRDS('pcData.rds')  # not a df
# tables()
str(df)

aggData <- readRDS('byMonth.rds')
x <- aggData
x[, id := paste(State,decile)]
x[, month := as.Date(month)]
x[, capPerPop := cumulative/population]
str(x)
