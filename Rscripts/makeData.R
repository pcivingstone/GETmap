# getData.R
# script to load and merge all of the source data sets

source('Rscripts/setup.R')

# lat and long ------------------------------------------------------------
# latitude and longitude, by postcode, from downloaded csv file
source('Rscripts/getLatlong.R')

# seifa -------------------------------------------------------------------
# socioeconomic data & population, by postcode, from downloaded text file
source('Rscripts/getSeifa.R')

# installations -----------------------------------------------------------
# small generation unit, solar panel, by postcode, from Green Energy Regulator
source('Rscripts/getInstallations.R')

# merge -------------------------------------------------------------------

myData <- merge(
  pcData
  , sesData
  , by = 'postcode'
  , all = F
  )

myData <- merge(
  myData
  ,longData
  # [, .SD[.N], by = .(postcode)]
  ,by = 'postcode'
  ,all = F
)

myData[
  , capPerK := round(1000*capacity/population,1)
]

# static data, without month ----------------------------------------------

temp <- myData[, .SD[.N], by = .(postcode)]

saveRDS(
  temp[
    ,.(postcode,State,long,lat,population,percentile,decile,capacity,capPerK,locale) # just these columns
    ]
  ,'pcData.rds'
  )


# by month ----------------------------------------------------------------

aggData <- myData[
  ,.(
    population = sum(population)
    ,cumulative = sum(capacity)
    ,perMonth = sum(kW)
    ,lat = mean(lat)
    ,long = mean(long)
  )
  ,by = .(
    State
    ,decile
    ,month
  )
  ]

saveRDS(aggData, 'byMonth.rds')


message('successful completion.')

