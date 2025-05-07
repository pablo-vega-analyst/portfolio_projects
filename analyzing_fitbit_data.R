# analyzing fitbit data

# counting the number of participants in each data frame

n_distinct(daily_activity_merged1$Id)
n_distinct(daily_activity_merged2$Id)
n_distinct(sleep_day_merged1$Id)
n_distinct(sleep_day_merged2$Id)

# there are 35 participants in daily_activity_merged1, 33 in daily_activity_merged2,
# 23 in sleep_day_merged1, and 24 in sleep_day_merged2.

# creating a new column that counts the total active minutes for each person
# for each day in the daily activity data frames

daily_activity_merged1 <- daily_activity_merged1 %>%
  mutate(TotalActiveMinutes = VeryActiveMinutes 
         + FairlyActiveMinutes 
         + LightlyActiveMinutes)

daily_activity_merged2 <- daily_activity_merged2 %>%
  mutate(TotalActiveMinutes = VeryActiveMinutes 
         + FairlyActiveMinutes 
         + LightlyActiveMinutes)

# quick summary statistics for each data frame

daily_activity_merged1 %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes,
         VeryActiveMinutes,
         FairlyActiveMinutes,
         LightlyActiveMinutes,
         TotalActiveMinutes) %>%
  summary()

# create summary table

summary_table1 <- daily_activity_merged1 %>%
  summarise(
    num_participants = n_distinct(Id),
    avg_steps = mean(TotalSteps, na.rm = TRUE),
    avg_sedentary_hours = mean(SedentaryMinutes/60, na.rm = TRUE),
    avg_calories = mean(Calories),
    avg_active_hours = mean(TotalActiveMinutes/60)
  )

print(summary_table1)

# turn summary table into pivot table

summary_table1 <- summary_table1 %>%
  pivot_longer(
    cols = c(num_participants, avg_steps, avg_sedentary_hours, avg_calories, avg_active_hours), # Columns to be pivoted
    names_to = "statistic",
    values_to = "value"
  )

install.packages("ggplot2")
install.packages("gridExtra")

library(ggplot2)
library(gridExtra)
library(grid)

# create .pdf of pivot table

summary_table1_plot <- tableGrob(summary_table1, rows = NULL)

  # Add a title
title <- textGrob("Summary Statistics: Daily Activity", gp = gpar(fontsize = 20, fontface = "bold"))

  # Add a subtitle
subtitle <- textGrob("3.12.16 - 4.11.16", gp = gpar(fontsize = 14, fontface = "italic"))

  # Add vertical space (empty grob) to push the table down
spacer <- textGrob(" ", gp = gpar(fontsize = 10))

  # Combine title, subtitle, spacer, and table
table_with_title <- arrangeGrob(title, subtitle, spacer, summary_table1_plot, ncol = 1, heights = c(0.3, 0.2, 0.05, 1))

  # Save the table with the title and subtitle as a PDF
ggsave("output_with_title_subtitle1.pdf", table_with_title, width = 8, height = 5)

daily_activity_merged2 %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes,
         VeryActiveMinutes,
         FairlyActiveMinutes,
         LightlyActiveMinutes,
         TotalActiveMinutes) %>%
  summary()

# create summary table

summary_table2 <- daily_activity_merged2 %>%
  summarise(
    num_participants = n_distinct(Id),
    avg_steps = mean(TotalSteps, na.rm = TRUE),
    avg_sedentary_hours = mean(SedentaryMinutes/60, na.rm = TRUE),
    avg_calories = mean(Calories),
    avg_active_hours = mean(TotalActiveMinutes/60)
  )

print(summary_table2)

# turn summary table to pivot table

summary_table2 <- summary_table2 %>%
  pivot_longer(
    cols = c(num_participants, avg_steps, avg_sedentary_hours, avg_calories, avg_active_hours), # Columns to be pivoted
    names_to = "statistic",
    values_to = "value"
  )

# turn pivot table to .pdf file

summary_table2_plot <- tableGrob(summary_table2, rows = NULL)

  # Add a title
title <- textGrob("Summary Statistics: Daily Activity", gp = gpar(fontsize = 20, fontface = "bold"))

  # Add a subtitle
subtitle2 <- textGrob("4.12.16 - 5.12.16", gp = gpar(fontsize = 14, fontface = "italic"))

  # Add vertical space (empty grob) to push the table down
spacer <- textGrob(" ", gp = gpar(fontsize = 10))

  # Combine title, subtitle, spacer, and table
table_with_title2 <- arrangeGrob(title, subtitle2, spacer, summary_table2_plot, ncol = 1, heights = c(0.3, 0.2, 0.05, 1))

  # Save the table with the title and subtitle as a PDF
ggsave("output_with_title_subtitle2.pdf", table_with_title2, width = 8, height = 5)


# for the group in the first month, mean total steps is 6812, mean total
# distance is 4.853 km, mean sedentary minutes is 1023, mean very active
# minutes is 17.06, mean fairly active minutes is 13.69, mean lightly active
# minutes is 177.9, and mean total active minutes is 208.6. for the group in
# the second month, mean total steps is 7638, mean total distance is 5.49 km,
# mean sedentary minutes is 991.2, mean very active minutes is 21.16, mean
# fairly active minutes is 13.56, mean lightly active minutes is 192.8, and mean
# total active minutes is 227.5. it seems like this is an active group of
# participants; the groups are active for 3.48 hours per day on average in the 
# first month and 3.79 hours per day on average in the second month.

sleep_day_merged1 %>%  
  select(TotalMinutesAsleep) %>%
  summary()

# create summary table
summary_table3 <- sleep_day_merged1 %>%
  ungroup() %>%
  summarise(
    num_participants = n_distinct(Id),
    avg_hours_asleep = mean(TotalMinutesAsleep/60)
  )

print(summary_table3)

# turn summary table to pivot table
summary_table3 <- summary_table3 %>%
  pivot_longer(
    cols = c(num_participants, avg_hours_asleep), # Columns to be pivoted
    names_to = "statistic",
    values_to = "value"
  )

# turn pivot table to .pdf file
summary_table3_plot <- tableGrob(summary_table3, rows = NULL)

  # Add a title
title3 <- textGrob("Summary Statistics: Daily Sleep", gp = gpar(fontsize = 20, fontface = "bold"))

  # Add a subtitle
subtitle3 <- textGrob("3.12.16 - 4.11.16", gp = gpar(fontsize = 14, fontface = "italic"))

  # Add vertical space (empty grob) to push the table down
spacer <- textGrob(" ", gp = gpar(fontsize = 10))

  # Combine title, subtitle, spacer, and table
table_with_title3 <- arrangeGrob(title3, subtitle3, spacer, summary_table3_plot, ncol = 1, heights = c(0.3, 0.2, 0.05, 1))

  # Save the table with the title and subtitle as a PDF
ggsave("output_with_title_subtitle3.pdf", table_with_title3, width = 8, height = 5)


sleep_day_merged2 %>%  
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed) %>%
  summary()

# create summary table
summary_table4 <- sleep_day_merged2 %>%
  #ungroup() %>%
  summarise(
    num_participants = n_distinct(Id),
    avg_hours_asleep = mean(TotalMinutesAsleep/60),
    avg_hours_in_bed = mean(TotalTimeInBed/60)
  )

print(summary_table4)

# turn summary table to pivot table
summary_table4 <- summary_table4 %>%
  pivot_longer(
    cols = c(num_participants, avg_hours_asleep, avg_hours_in_bed), # Columns to be pivoted
    names_to = "statistic",
    values_to = "value"
  )

# turn pivot table to .pdf file
summary_table4_plot <- tableGrob(summary_table4, rows = NULL)

  # Add a title
title4 <- textGrob("Summary Statistics: Daily Sleep", gp = gpar(fontsize = 20, fontface = "bold"))

  # Add a subtitle
subtitle4 <- textGrob("4.12.16 - 5.12.16", gp = gpar(fontsize = 14, fontface = "italic"))

  # Add vertical space (empty grob) to push the table down
spacer <- textGrob(" ", gp = gpar(fontsize = 10))

  # Combine title, subtitle, spacer, and table
table_with_title4 <- arrangeGrob(title4, subtitle4, spacer, summary_table4_plot, ncol = 1, heights = c(0.3, 0.2, 0.05, 1))

  # Save the table with the title and subtitle as a PDF
ggsave("output_with_title_subtitle4.pdf", table_with_title4, width = 8, height = 5)

# in the first month, the group mean total minutes alseep is 399.4, in the
# second month, the group mean total minutes asleep is 419.2, and the mean
# total time in bed is 458.5. it seems like the groups are a little on the under-
# slept side. in the first month, the group sleeps for 6.66 hours per night on average,
# and in the second month, the group sleeps for 6.99 hours per night on average.
# considering that people should get 8 hours of sleep per night, these groups
# aren't getting enough sleep.

# plot the relationship between total steps and sedentary minutes

ggplot(data=daily_activity_merged1, aes(x=TotalSteps, y=SedentaryMinutes)) + geom_point()

# the plot shows two clusters where for each cluster there is a general trend
# that as total steps increase, sedentary minutes decrease. a couple more details
# of note are that there are many points in the upper left corner of the graph where
# sedentary minutes are 1000-1500 and total steps are less than 10000. there are
# a lot of points right below that corner where sedentary minutes are 500-1000
# and total steps are less than 10000. then there are some people that takes more
# than 10000 steps per day. let's divide the participants into those that have
# medium-to-high sedentary minutes (500-1500) and low total steps (<10000),
# medium-to-high sedentary minutes (500-1500) and medium total steps (10000-20000),
# and those who have high total steps (>20000). for the first group, we could
# make a marketing campaign that encourages them to use a bellabeat product to
# motivate them to start walking more and to track their steps. for the first group,
# we could highlight that a bellabeat product can help them track the steps that
# they're already taking. and for the third group, we can higlight that a bellabeat
# product can help optimize that steps that they're already taking by giving them
# details about their activity such as intensity and heart rate.

# plot the relationship between total active minutes and sedentary minutes
ggplot(data=daily_activity_merged1, aes(x=TotalActiveMinutes, y=SedentaryMinutes)) +
  geom_point() +
  ggtitle("Relationship Between Active Minutes and Sedentary Minutes") +
  xlab("Active Minutes") +
  ylab("Sedentary Minutes")
# strong negative correlation, maybe leverage this

# plot the relationship between total steps and calories
ggplot(data=daily_activity_merged1, aes(x=TotalSteps, y=Calories)) +
  geom_point() +
  ggtitle("Relationship Between Total Steps and Calories Burned") +
  xlab("Total Steps") +
  ylab("Calories Burned")
# decent positive correlation, maybe leverage this

# plot the relationship between total active minutes and calories
ggplot(data=daily_activity_merged1, aes(x=TotalActiveMinutes, y=Calories)) + geom_point()
# decent positive correlation, maybe leverage this

# plot the relationship between very active distance and calories
ggplot(data=daily_activity_merged1, aes(x=VeryActiveDistance, y=Calories)) + geom_point()
# okay positive correlation

# plot the relationship between light active distance and calories
ggplot(data=daily_activity_merged1, aes(x=LightActiveDistance, y=Calories)) + geom_point()
# kind of a postive correlation

# plot the relationship between very active minutes and calories
ggplot(data=daily_activity_merged1, aes(x=VeryActiveMinutes, y=Calories)) + geom_point()
# decent positive correlation

# plot the relationship between lightly active minutes and calories
ggplot(data=daily_activity_merged1, aes(x=LightlyActiveMinutes, y=Calories)) + geom_point()
# kind of a positive correlation

#plot the relationship between total minutes asleep and total tome in bed

sleep_day_merged2.1 <- sleep_day_merged2 %>%
  mutate(hours_asleep = TotalMinutesAsleep / 60) %>%
  mutate(hours_in_bed = TotalTimeInBed / 60)

ggplot(data=sleep_day_merged2.1, aes(x=hours_asleep, y=hours_in_bed)) +
  geom_point() +
  ggtitle("Relationship Between Hours Asleep and Hours In Bed") +
  xlab("Hours Asleep") +
  ylab("Hours In Bed")
# strong positive correlation. there are several points above the general trend line,
# so there were times where some participants were getting less sleep than expected
# for their time in bed. this suggests that there are outside factors that could
# disrupt a participant's sleep such as doom-scrolling, difficulty falling asleep,
# or waking up in the middle of the night. perhaps we market to people who doom-
# scroll in bed before going to bed by running ads on their tiktok feed about how
# a bellabeat product can help them track their sleep, improve sleep efficiency,
# and ultimately reduce the time they spend rotting in bed.

daily_activity_merged2 <- daily_activity_merged2 %>% 
  rename(date = ActivityDate)

sleep_day_merged2 <- sleep_day_merged2 %>% 
  rename(date = SleepDay)

combined_daily_activity_sleep2 <- merge(daily_activity_merged2, sleep_day_merged2, by = c("Id", "date")) 

n_distinct(combined_daily_activity_sleep2$Id) # 24 participants

# plot relationsip between total steps and total minutes asleep
ggplot(data=combined_daily_activity_sleep2, aes(x=TotalSteps, y=TotalMinutesAsleep)) + geom_point()
# doesn't seem to be much of a relationship

# plot relationship between total active minutes and total minutes asleep
ggplot(data=combined_daily_activity_sleep2, aes(x=TotalActiveMinutes, y=TotalMinutesAsleep)) + geom_point()
# doesn't seem to be much of a relationship

# plot relationship between total distance and total minutes asleep
ggplot(data=combined_daily_activity_sleep2, aes(x=TotalDistance, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation

# plot relationship between total very active minutes and total minutes asleep
ggplot(data=combined_daily_activity_sleep2, aes(x=VeryActiveMinutes, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation

# plot relationship between fairly active minutes and total minutes asleep
ggplot(data=combined_daily_activity_sleep2, aes(x=FairlyActiveMinutes, y=TotalMinutesAsleep)) + geom_point()
# not much of a relationship

# plot relationship between lightly active minutes and total minutes asleep
ggplot(data=combined_daily_activity_sleep2, aes(x=LightlyActiveMinutes, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation

# plot relationship between sedentary minutes and total minutes asleep
ggplot(data=combined_daily_activity_sleep2, aes(x=SedentaryMinutes, y=TotalMinutesAsleep)) + geom_point()
# there seems to be somewhat of a negative correlation, maybe leverage this

# merge the following data frames

combined_daily_activity_sleep_heartrate2 <- merge(combined_daily_activity_sleep2, heartrate_merged2, by = c("Id", "date")) 

ggplot(data=combined_daily_activity_sleep_heartrate2, aes(x=mean_heart_rate, y=TotalMinutesAsleep)) + geom_point()
# not much correlation

ggplot(data=combined_daily_activity_sleep_heartrate2, aes(x=resting_heart_rate, y=TotalMinutesAsleep)) + geom_point()
# not much correlation

ggplot(data=combined_daily_activity_sleep_heartrate2, aes(x=max_heart_rate, y=TotalMinutesAsleep)) + geom_point()
# not much correlation

ggplot(data=combined_daily_activity_sleep_heartrate2, aes(x=resting_heart_rate, y=TotalSteps)) + geom_point()
# not much correlation

ggplot(data=combined_daily_activity_sleep_heartrate2, aes(x=resting_heart_rate, y=SedentaryMinutes)) + geom_point()
# not much correlation

ggplot(data=combined_daily_activity_sleep_heartrate2, aes(x=resting_heart_rate, y=TotalActiveMinutes)) + geom_point()
# not much correlation

ggplot(data=combined_daily_activity_sleep_heartrate2, aes(x=resting_heart_rate, y=Calories)) + geom_point()
# somewhat of a negative correlation


daily_activity_merged1 <- daily_activity_merged1 %>% 
  rename(date = ActivityDate)

sleep_day_merged1 <- sleep_day_merged1 %>% 
  rename(date = SleepDay)

combined_daily_activity_sleep1 <- merge(daily_activity_merged1, sleep_day_merged1, by = c("Id", "date")) 

combined_daily_activity_sleep_heartrate1 <- merge(combined_daily_activity_sleep1, heartrate_merged1, by = c("Id", "date")) 

n_distinct(combined_daily_activity_sleep_heartrate1$Id) # only 11 participants

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=TotalSteps, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation, if anything kind of a negative trend

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=TotalSteps, y=resting_heart_rate)) + geom_point()
# not much of a correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=TotalMinutesAsleep, y=resting_heart_rate)) + geom_point()
# not much of a correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=TotalActiveMinutes, y=resting_heart_rate)) + geom_point()
# not much of a correlation, if anything there's a somewhat of a positive correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=TotalActiveMinutes, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation, if anything there's kind if negative correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=SedentaryMinutes, y=resting_heart_rate)) + geom_point()
# not much of a correlation, kind of a positive correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=SedentaryMinutes, y=TotalMinutesAsleep)) + geom_point()
# somewhat of a negative correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=Calories, y=resting_heart_rate)) + geom_point()
# not much of a correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=Calories, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=Calories, y=resting_heart_rate)) + geom_point()
# not much of a correlation

ggplot(data=combined_daily_activity_sleep_heartrate1, aes(x=Calories, y=SedentaryMinutes)) + geom_point()
#not much of a correlation


n_distinct(super_combined_fitbit_data$Id) # only 12 participants

ggplot(data=super_combined_fitbit_data, aes(x=TotalSteps, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation

ggplot(data=super_combined_fitbit_data, aes(x=TotalSteps, y=resting_heart_rate)) + geom_point()
# not much of a correlation

ggplot(data=super_combined_fitbit_data, aes(x=resting_heart_rate, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation

ggplot(data=super_combined_fitbit_data, aes(x=TotalActiveMinutes, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation. kinda negative

ggplot(data=super_combined_fitbit_data, aes(x=TotalActiveMinutes, y=resting_heart_rate)) + geom_point()
# not much of a correlation

ggplot(data=super_combined_fitbit_data, aes(x=sedentary_hours, y=hours_asleep)) + 
  geom_point() + 
  ggtitle("Relationship Between Sedentary Hours and Hours Asleep") +
  xlab("Sedentary Hours") +
  ylab("Hours Asleep")
# somewhat of a negative correlation, maybe leverage this. this plot shows a
# general trend that as sedentary hours increase, hours asleep decrease. one possible
# reason for this correlation is work. as participants spend more time working
# (or studying if they're students) late, the less time they sleep. we could
# highlight that a bellabeat product can help people track how much time they are
# sedentary and set reminders to go to sleep by some time.

super_combined_fitbit_data <- super_combined_fitbit_data %>% 
  mutate(hours_asleep = TotalMinutesAsleep / 60) %>%
  mutate(sedentary_hours = SedentaryMinutes / 60)

ggplot(data=super_combined_fitbit_data, aes(x=SedentaryMinutes, y=resting_heart_rate)) + geom_point()
# not much of a correlation

ggplot(data=super_combined_fitbit_data, aes(x=SedentaryMinutes, y=Calories)) + geom_point()
# not much of a correlation

ggplot(data=super_combined_fitbit_data, aes(x=Calories, y=TotalMinutesAsleep)) + geom_point()
# not much of a correlation

ggplot(data=super_combined_fitbit_data, aes(x=Calories, y=resting_heart_rate)) + geom_point()
# not much of a correlation kind of a negative correlation

ggplot(data=super_combined_fitbit_data, aes(x=TotalActiveMinutes, y=resting_heart_rate)) + geom_point()
# not much of a correlation







