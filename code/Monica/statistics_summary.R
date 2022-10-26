
library(dplyr)

# read data
here::i_am("code/Monica/statistics_summary.R") 
data <- read.csv(here::here("course_engagement.csv"))

#transforming length variable to be numeric, set as minutes
convert_hh_mm_ss_to_numeric <- function(x){
  split_x <- strsplit(x, split = ":")
  get_minutes <- function(y){
    y <- as.numeric(y)
    if(length(y) == 1){
      # assume it's seconds
      y / 60
    }else if(length(y) == 2){
      y[1] + y[2]/60
    }else if(length(y) == 3){
      60 * y[1] + y[2] + y[3]/60
    }else{
      NA
    }
  }
  minutes <- unlist(lapply(split_x, get_minutes))
  return(minutes)
}
# convert the variable "lenght" from chr to num
data$video_length <- convert_hh_mm_ss_to_numeric(data$length)

# summarize statistics of video length and number of unique viewers by group of unique topics
data2 <- data %>% group_by(topic) %>% summarise_at(c("video_length", "unique_viewers"), mean, na.rm = TRUE)

#save the summary statistics table in a csv file
write.csv(data2, here::here("output/Monica/summary_statistics_by_topic.csv"))