here::i_am("code/Alessia/correlation.R") #identifies root directory location
absolute_path_to_data <- here::here("course_engagement.csv")
data <- read.csv(absolute_path_to_data, header = TRUE)

#loading packages

library(ggpubr)
library(ggplot2)
library(hrbrthemes)

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

data$length_n <- convert_hh_mm_ss_to_numeric(data$length)

#cleaning data to remove outlier

data_clean <- data[!(data$length_n>63),]

#correlation between views and length of video

correlation <- cor(data_clean$length_n, data_clean$views, method = "pearson")

saveRDS(
  correlation,
  file = here::here("output/correlation.rds")
)

#making a scatter plot with a fitted line

corr_scatterplot <- ggplot(data_clean, aes(x=length_n, y=views)) +
  geom_point() +
  geom_smooth(method=lm , color="red", fill="#69b3a2", se=TRUE) +
  theme_ipsum() +
  ggtitle("Relationship Between Length of Video and Total Views") +
  xlab("Length of Video in Minutes") +
  ylab("Total Views of Video")

corr_scatterplot

ggsave(
  here::here("output/correlation_scatterplot.png"),
  plot = corr_scatterplot,
  device = "png"
)


