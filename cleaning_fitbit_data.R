#data cleaning for 2016-03-12 to 2016-04-12 dailyActivity_merged.csv

daily_activity_merged <- read_csv("folder1/subfolder/dailyActivity_merged.csv")
daily_activity_merged1 <- daily_activity_merged

sum(is.na(daily_activity_merged1)) #checks for missing values in data frame

daily_activity_merged1 <- distinct(daily_activity_merged1) #removes any duplicate rows in the data frame

# checks if all values in a column are of the same datatype
sapply(daily_activity_merged1$Id, class)
sapply(daily_activity_merged1$ActivityDate, class)
sapply(daily_activity_merged1$TotalSteps, class)
sapply(daily_activity_merged1$TotalDistance, class)
sapply(daily_activity_merged1$TrackerDistance, class)
sapply(daily_activity_merged1$LoggedActivitiesDistance, class)
sapply(daily_activity_merged1$VeryActiveDistance, class)
sapply(daily_activity_merged1$ModeratelyActiveDistance, class)
sapply(daily_activity_merged1$LightActiveDistance, class)
sapply(daily_activity_merged1$SedentaryActiveDistance, class)
sapply(daily_activity_merged1$VeryActiveMinutes, class)
sapply(daily_activity_merged1$LightlyActiveMinutes, class)
sapply(daily_activity_merged1$FairlyActiveMinutes, class)
sapply(daily_activity_merged1$SedentaryMinutes, class)
sapply(daily_activity_merged1$Calories, class)

# replaces all of the slashes with hyphens in ActivityDate column
daily_activity_merged1$ActivityDate <- gsub("/", "-", daily_activity_merged1$ActivityDate)

# takes all of the values in the ActivityDate column and makes them of the class Date
# note that this changes the dates to yyyy-mm-dd format
daily_activity_merged1$ActivityDate <- as.Date(daily_activity_merged1$ActivityDate, format = "%m-%d-%Y")

# checks that all dates are within correct interval namely from 2016-03-12 to 2016-04-11

start_date <- as.Date("2016-03-12")
end_date <- as.Date("2016-04-11")
dates_in_range <- daily_activity_merged1$ActivityDate >= start_date & daily_activity_merged1$ActivityDate <= end_date
any(!dates_in_range)
filtered_daily_activity_merged1 <- filter(daily_activity_merged1, ActivityDate < start_date | ActivityDate > end_date)
daily_activity_merged1 <- filter(daily_activity_merged1, ActivityDate >= start_date & ActivityDate <= end_date)

# trims leading and trailing whitespace in columns
daily_activity_merged1$Id <- trimws(daily_activity_merged1$Id)
daily_activity_merged1$ActivityDate <- trimws(daily_activity_merged1$ActivityDate)
daily_activity_merged1$TotalSteps <- trimws(daily_activity_merged1$TotalSteps)
daily_activity_merged1$TotalDistance <- trimws(daily_activity_merged1$TotalDistance)
daily_activity_merged1$TrackerDistance <- trimws(daily_activity_merged1$TrackerDistance)
daily_activity_merged1$LoggedActivitiesDistance <- trimws(daily_activity_merged1$LoggedActivitiesDistance)
daily_activity_merged1$VeryActiveDistance <- trimws(daily_activity_merged1$VeryActiveDistance)
daily_activity_merged1$ModeratelyActiveDistance <- trimws(daily_activity_merged1$ModeratelyActiveDistance)
daily_activity_merged1$LightActiveDistance <- trimws(daily_activity_merged1$LightActiveDistance)
daily_activity_merged1$SedentaryActiveDistance <- trimws(daily_activity_merged1$SedentaryActiveDistance)
daily_activity_merged1$VeryActiveMinutes <- trimws(daily_activity_merged1$VeryActiveMinutes)
daily_activity_merged1$FairlyActiveMinutes <- trimws(daily_activity_merged1$FairlyActiveMinutes)
daily_activity_merged1$LightlyActiveMinutes <- trimws(daily_activity_merged1$LightlyActiveMinutes)
daily_activity_merged1$SedentaryMinutes <- trimws(daily_activity_merged1$SedentaryMinutes)
daily_activity_merged1$Calories <- trimws(daily_activity_merged1$Calories)

# previous block of code changes all datatypes to character
# so this block converts all columns back to their proper datatypes
daily_activity_merged1$Id <- as.numeric(daily_activity_merged1$Id)
daily_activity_merged1$ActivityDate <- as.Date(daily_activity_merged1$ActivityDate, format = "%Y-%m-%d")
daily_activity_merged1$TotalSteps <- as.numeric(daily_activity_merged1$TotalSteps)
daily_activity_merged1$TotalDistance <- as.numeric(daily_activity_merged1$TotalDistance)
daily_activity_merged1$TrackerDistance <- as.numeric(daily_activity_merged1$TrackerDistance)
daily_activity_merged1$LoggedActivitiesDistance <- as.numeric(daily_activity_merged1$LoggedActivitiesDistance)
daily_activity_merged1$VeryActiveDistance <- as.numeric(daily_activity_merged1$VeryActiveDistance)
daily_activity_merged1$ModeratelyActiveDistance <- as.numeric(daily_activity_merged1$ModeratelyActiveDistance)
daily_activity_merged1$LightActiveDistance <- as.numeric(daily_activity_merged1$LightActiveDistance)
daily_activity_merged1$SedentaryActiveDistance <- as.numeric(daily_activity_merged1$SedentaryActiveDistance)
daily_activity_merged1$VeryActiveMinutes <- as.numeric(daily_activity_merged1$VeryActiveMinutes)
daily_activity_merged1$FairlyActiveMinutes <- as.numeric(daily_activity_merged1$FairlyActiveMinutes)
daily_activity_merged1$LightlyActiveMinutes <- as.numeric(daily_activity_merged1$LightlyActiveMinutes)
daily_activity_merged1$SedentaryMinutes <- as.numeric(daily_activity_merged1$SedentaryMinutes)
daily_activity_merged1$Calories <- as.numeric(daily_activity_merged1$Calories)

#data cleaning for 2016-03-12 to 2016-04-11 minute_sleep_merged.csv

minute_sleep_merged1 <- read_csv("folder1/subfolder/minuteSleep_merged.csv")

# check the number of missing values in the minuste_sleep_merged1 data frame
sum(is.na(minute_sleep_merged1))

# remove any duplicate rows in minute_sleep_merged1
minute_sleep_merged1 <- distinct(minute_sleep_merged1)

# split date column into two columns: a date column and a time column
minute_sleep_merged1 <- separate(minute_sleep_merged1, col = "date", into = c("date", "time"),sep = " ", extra = "merge")

# change slashes to hyphens in date column
minute_sleep_merged1$date <- gsub("/", "-", minute_sleep_merged1$date)

# combine date and time columns into datetime column
minute_sleep_merged1 <-unite(minute_sleep_merged1, col = "datetime", c("date", "time"), sep = " ")

# turn values in datetime from characters to date-times
minute_sleep_merged1$datetime <- mdy_hms(minute_sleep_merged1$datetime)

# check to see if all values in a column are of the same datatype
sapply(minute_sleep_merged1$Id, class)
sapply(minute_sleep_merged1$value, class)
sapply(minute_sleep_merged1$logId, class)

# checks if all datetimes are within correct interval
# NOTE: dates are supposed to be between 2016-03-12 and 2016-04-11
initial_date <- ymd_hms("2016-03-12 00:00:00")
final_date <- ymd_hms("2016-04-11 23:59:59")
dates_in_interval <- minute_sleep_merged1$datetime >= initial_date & minute_sleep_merged1$datetime <= final_date
any(!dates_in_interval)

#checks datetimes out of correct interval
dates_out_of_interval <- minute_sleep_merged1[minute_sleep_merged1$datetime < initial_date | minute_sleep_merged1$datetime > final_date, ]

minute_sleep_merged1 <- filter(minute_sleep_merged1,datetime >= initial_date &datetime <= final_date)

# data cleaning for dailActivity_merged.csv (2016-04-12 to 2016-05-12)


daily_activity_merged2 <- read_csv("folder2/subfolder/dailyActivity_merged.csv")

# check the number of missing values
sum(is.na(daily_activity_merged2))

# remove any duplicate rows
daily_activity_merged2 <- distinct(daily_activity_merged2)

# change values in ActivityDate column from character to date datatype
# first change slashes to hyphens
daily_activity_merged2$ActivityDate <- gsub("/", "-", daily_activity_merged2$ActivityDate)

# then change from character datatype to date datatype
daily_activity_merged2$ActivityDate <- as.Date(daily_activity_merged2$ActivityDate, format = "%m-%d-%Y")

# checks if all values in a column are of the same datatype
sapply(daily_activity_merged2$Id, class)
sapply(daily_activity_merged2$ActivityDate, class)
sapply(daily_activity_merged2$TotalSteps, class)
sapply(daily_activity_merged2$TotalDistance, class)
sapply(daily_activity_merged2$TrackerDistance, class)
sapply(daily_activity_merged2$LoggedActivitiesDistance, class)
sapply(daily_activity_merged2$VeryActiveDistance, class)
sapply(daily_activity_merged2$ModeratelyActiveDistance, class)
sapply(daily_activity_merged2$LightActiveDistance, class)
sapply(daily_activity_merged2$SedentaryActiveDistance, class)
sapply(daily_activity_merged2$VeryActiveMinutes, class)
sapply(daily_activity_merged2$LightlyActiveMinutes, class)
sapply(daily_activity_merged2$FairlyActiveMinutes, class)
sapply(daily_activity_merged2$SedentaryMinutes, class)
sapply(daily_activity_merged2$Calories, class)

# checks that all dates are within correct interval namely from 2016-04-12 and 2016-05-12
start_date2 <- as.Date("2016-04-12")
end_date2 <- as.Date("2016-05-12")
dates_in_range2 <- daily_activity_merged2$ActivityDate >= start_date2 & daily_activity_merged2$ActivityDate <= end_date2

# checks if there is at least one date out of range
any(!dates_in_range2)


# data cleaning for minuteSleep_merged.csv (2016-04-12 to 2016-05-12)

minute_sleep_merged2 <- read_csv("folder2/subfolder/minuteSleep_merged.csv")

# check to see if there are any missing values
sum(is.na(minute_sleep_merged2))

# remove any duplicate rows
minute_sleep_merged2 <- distinct(minute_sleep_merged2)

# make sure that for a given column, all of the values are of the correct datatype

# change values in date column from character to datetime datatype
minute_sleep_merged2$date <- mdy_hms(minute_sleep_merged2$date)

# check that for a given column, all of the values are of the same datatype
unique(sapply(minute_sleep_merged2$Id, class))
unique(sapply(minute_sleep_merged2$value, class))
unique(sapply(minute_sleep_merged2$logId, class))
all(is.POSIXct(minute_sleep_merged2$date))

minute_sleep_merged2 <- minute_sleep_merged2 %>% 
  rename(datetime = date_time)

# check to see if the date-times are in the correct interval
initial_date2 <- ymd_hms("2016-04-12 00:00:00")
final_date2 <- ymd_hms("2016-05-12 23:59:59")


dates_in_interval2 <- minute_sleep_merged2$datetime >= initial_date2 & minute_sleep_merged2$datetime <= final_date2

any(!dates_in_interval2)

filtered_minute_sleep_merged2 <- filter(minute_sleep_merged2, datetime < initial_date2 | datetime > final_date2)
rows_in_both_minute_sleep_merged <- semi_join(minute_sleep_merged2, minute_sleep_merged1)
minute_sleep_merged2 <- filter(minute_sleep_merged2, datetime >= initial_date2 & datetime <= final_date2)

# data cleaning for sleepDay_merged.csv

# check for missing values

sum(is.na(sleep_day_merged))

# remove any duplicate rows

sleep_day_merged <- distinct(sleep_day_merged)

# for a given column, make sure all values are of the correct data type

sleep_day_merged$SleepDay <- mdy_hms(sleep_day_merged$SleepDay)

unique(sapply(sleep_day_merged$Id, class))
unique(sapply(sleep_day_merged$TotalSleepRecords, class))
unique(sapply(sleep_day_merged$TotalMinutesAsleep, class))
unique(sapply(sleep_day_merged$TotalTimeInBed, class))

# check to see if dates are within correct date range

initial_date3 <- ymd_hms("2016-04-12 00:00:00")
final_date3 <- ymd_hms("2016-05-12 23:59:59")


dates_in_interval3 <- sleep_day_merged$SleepDay >= initial_date3 & sleep_day_merged$SleepDay <= final_date3

any(!dates_in_interval3)

sleep_day_merged2 <- sleep_day_merged

# data manipulation for minute_sleep_merged1. summarizing the data so that
# we get the total number of minutes that each person slept each day

sleep_day_merged1 <- minute_sleep_merged1 %>%
  mutate(date = date(datetime)) %>%
  group_by(Id, date) %>%
  summarize(total_minutes_slept = sum(value == 1))

sleep_day_merged1 <- sleep_day_merged1 %>%
  rename(SleepDay = date, TotalMinutesAsleep = total_minutes_slept)

# data cleaning for heartrate seonds merged 2

heartrate_seconds_merged <- read_csv("folder2/subfolder/heartrate_seconds_merged.csv")
heartrate_seconds_merged2 <- heartrate_seconds_merged
rm(heartrate_seconds_merged)

# check for missing values

sum(is.na(heartrate_seconds_merged2))

# remove duplicate rows

heartrate_seconds_merged2 <- distinct(heartrate_seconds_merged2)

# change values in time column to date-time datatype

heartrate_seconds_merged2$Time <- mdy_hms(heartrate_seconds_merged2$Time)

heartrate_merged2 <- heartrate_seconds_merged2 %>% 
  group_by(Id, date = as.Date(Time)) %>%  # Group by ID and date
  summarise(
    mean_heart_rate = mean(Value),            # Calculate mean heart rate
    resting_heart_rate = min(Value),          # Calculate resting heart rate (assuming lowest value)
    max_heart_rate = max(Value),              # Calculate max heart rate
  )


# data cleaning for heart rate seconds merged 1

heartrate_seconds_merged1 <- read_csv("folder1/subfolder/heartrate_seconds_merged.csv")

# check for missing values

sum(is.na(heartrate_seconds_merged1))

# remove duplicate rows

heartrate_seconds_merged1 <- distinct(heartrate_seconds_merged1)

# change values in time column to date-time datatype

heartrate_seconds_merged1$Time <- mdy_hms(heartrate_seconds_merged1$Time)

heartrate_merged1 <- heartrate_seconds_merged1 %>% 
  group_by(Id, date = as.Date(Time)) %>%  # Group by ID and date
  summarise(
    mean_heart_rate = mean(Value),            # Calculate mean heart rate
    resting_heart_rate = min(Value),          # Calculate resting heart rate (assuming lowest value)
    max_heart_rate = max(Value),              # Calculate max heart rate
  )

reduced_combined_daily_activity_sleep_heartrate2 <- combined_daily_activity_sleep_heartrate2 %>% select(-TotalSleepRecords, -TotalTimeInBed)

super_combined_fitbit_data <- rbind(combined_daily_activity_sleep_heartrate1, reduced_combined_daily_activity_sleep_heartrate2)

