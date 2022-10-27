
library(dplyr)

# read data
here::i_am("code/Xinyi/engagement.R") 
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

data$video_length <- convert_hh_mm_ss_to_numeric(data$length)

data=data[order(-data$unique_viewers,-data$views),]
##top5 popular
top5=data[1:5,]
#most popular
top_bot=top5[1,]
#bot, excluded the reuploaded video
top_bot[2,]=top5[nrow(top5)-1,]
top_bot_print=as.data.frame(c("Most Popular","Least Popular"))
top_bot_print=cbind(top_bot_print,top_bot)
colnames(top_bot_print)[1]=""
#bot5 popular
data=data[order(data$unique_viewers,data$views),]
bot5=data[2:6,]

#demographics summary
summary_table=table1::table1(~video_length+views+unique_viewers|topic,data=data)
result=as.data.frame(summary_table)

write.csv(top5, here::here("output/Xinyi/top5_popular.csv"))
write.csv(bot5, here::here("output/Xinyi/bot5_popular.csv"))
write.csv(result,here::here("output/Xinyi/demographics.csv"))
write.csv(top_bot_print,here::here("output/Xinyi/top_bottom_popular.csv"))
