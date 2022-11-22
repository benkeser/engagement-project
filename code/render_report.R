# Code to render the final report
here::i_am(
  "code/render_report.R"
)

rmarkdown::render(
  here::here("engagement_report.Rmd")
)