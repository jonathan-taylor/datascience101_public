## Make this into a Markdown

library(readr)
stationData <- read_csv("201508_station_data.csv")

## How many stations?
stationData %>% nrow

## How many cities
stationData %>%
    distinct(landmark)

## How many docks per city
stationData %>%
    group_by(landmark) %>%
    summarize(count = n())


tripData <- read_csv("201508_trip_data.csv")
tripData

## What period does this data cover?
## Let us look at the column Start Date for example.



library(dplyr)
tripData %>% select(Start Date)

## The first read is not very useful for us, so we need to work harder
## Change the columns names

##
## 1. Give better names and convert Start Date to date time.
tripData <- read_csv("201508_trip_data.csv",
                     col_names = c("TripId", "Duration", "StartDate", "StartStation",
                                   "StartTerminal", "EndDate", "EndStation", "EndTerminal",
                                   "BikeNo", "SubscriberType", "ZipCode"),
                     skip = 1,
                     col_types = cols(
                         StartDate = col_datetime( format = "%m/%d/%Y %H:%S"),
                         EndDate = col_datetime( format = "%m/%d/%Y %H:%S")
                     ))

##
## A better way is to change the original names by stripping all spaces
## parse_datetime("8/21/2015 23:26", format="%m/%d/%Y %H:%S", locale=locale(tz="America/Los_Angeles"))
## How many trips
tripData %>% nrow

## Safer way
tripData %>% distinct(TripId) %>% nrow

## What period does this data cover?

tripData %>% summarize(start = as.Date(min(StartDate)), end = as.Date(max(EndDate)))

## What is the total riding time?

tripData %>% summarize(total = ((sum(Duration) / 3600) / 24) / 365)

## How many rides per week day, on average? How many per weekend day? Ignore holidays

## We need a factor called weekday

tripCounts <- tripData %>%
    mutate(Date = as.Date(StartDate), DayOfWeek = weekdays(Date), weekend = DayOfWeek %in% c("Saturday", "Sunday")) %>%
    group_by(Date, weekend) %>%
    summarize(count = n())

tripCounts %>%
    group_by(weekend) %>%
    summarize(avg = mean(count))

## Busiest day
tripCounts %>%
    select(Date, count) %>%
    arrange(desc(count))

## Laziest day
tripCounts %>%
    select(Date, count) %>%
    arrange(count)






