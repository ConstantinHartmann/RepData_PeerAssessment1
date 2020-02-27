library(tidyverse)
library(dplyr)
library(lubridate)

# Code for reading in the dataset and/or processing the data

data <- read.csv("C:\\Users\\USER\\Dropbox\\Statistik\\activity.csv", header = TRUE)

data$date <- ymd(data$date)

# Histogram of the total number of steps taken each day

steps_per_day <- data %>%
        group_by(date) %>%
        summarize("Steps_per_Day" := sum(steps, na.rm = TRUE))


ggplot(steps_per_day, aes(x = Steps_per_Day)) + geom_histogram(binwidth = 3000) + ggtitle("Total number of steps taken each day")

# Mean and median number of steps taken each day

steps <- data %>%
        group_by(date) %>%
        mutate(steps_per_day = sum(steps, na.rm = TRUE))

mean(steps$steps_per_day)
median(steps$steps_per_day)


# 4. Time series plot of the average number of steps taken

steps_avg <- data %>%
        group_by(date) %>%
        summarize(avg = mean(steps, na.rm = TRUE))
steps_avg        
ggplot(na.omit(steps_avg), aes(x = date, y = avg)) + geom_line(color = "steelblue") + geom_point()

# 5. The 5-minute interval that, on average, contains the maximum number of steps
interval_max <- data %>%
        group_by(interval) %>%
        summarize("Interval_Steps_Avg" := mean(steps, na.rm = TRUE)) %>%
        filter(Interval_Steps_Avg == max(Interval_Steps_Avg))

interval_max

# 6. Code to describe and show a strategy for imputing missing data


# 7. Histogram of the total number of steps taken each day after missing values are imputed

steps_avg <- data %>%
        group_by(date) %>%
        summarize("Steps_per_Day" := sum(steps, na.rum = TRUE))

ggplot(steps_avg, aes(x=Steps_per_Day)) + geom_histogram(binwidth = 3000)

# 8. Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends

z <- data %>%
        mutate(weekday = weekdays(date)) %>%
        mutate(daytype = case_when((weekday == "Samstag" | weekday == "Sonntag") ~ "Weekend", 
                                     (weekday == "Montag" | weekday == "Dienstag" | weekday == "Mittwoch" | weekday == "Donnerstag" | weekday == "Freitag") ~ "Workingday"))
  
t <- z %>%
        group_by(interval, daytype) %>%
        #group_by(interval) %>%
        mutate("mean_steps" = mean(steps, na.rm=TRUE))

z$daytype <- as.factor(z$daytype)
ggplot(t, aes(x=interval, y=mean_steps)) + geom_line() + facet_wrap( ~ daytype)

# 9. All of the R code needed to reproduce the results (numbers, plots, etc.) in the report





