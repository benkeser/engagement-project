This README will tell you the layout of the repository and how to build 
the report!

### Contents and Organization of the Repository

The project folder currently contains the following:

1) README.md
2) output folder
- empty folder to store the code output
3) code folder
- code that will give us our course engagement data analysis
4) the data: `course_engagement.csv`
5) config.yml
- used for customizing the report (see below)
6) renv-related things (renv folder, renv.lock, .Rprofile)
- for synchonizing packages
7) `engagement_report.Rmd`
- code to create the final report
8) Makefile
- used to easily create the report from the command line (see below for instructions)

### How to build and customized the report

The elements of course engagement we're currently looking at for this report are: 

1) summary statistics of the video, that looks at video topic, length, and number of unique viewers
2) the most and least popular videos, as well video topic demographics (i.e. mean and standard deviation of video length, views, and unique viewers)
3) correlation between length of video and engagement

The reader will be able to pick and choose using the parameters to see which 
elements they would like to see: all, none, or one of the three options.

1) To see all, or the default, type `make` in your terminal
2) To see none, type `make REPORT_TYPE=none` into your terminal
3) To see only the summary statistics, type `make REPORT_TYPE=summary` into the terminal
4) To see only the popular videos and topic demographics, type `make REPORT_TYPE=demographics` into the terminal
4) To see only the correlation, type `make REPORT_TYPE=correlation` into the terminal