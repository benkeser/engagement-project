report: engagement_report.Rmd \
  summary_stats popular_and_demographics correlation
	Rscript code/render_report.R

summary_stats: code/Monica/statistics_summary.R course_engagement.csv
	Rscript code/Monica/statistics_summary.R

popular_and_demographics: code/Xinyi/engagement.R course_engagement.csv
	Rscript code/Xinyi/engagement.R

correlation: code/Alessia/correlation.R course_engagement.csv
	Rscript code/Alessia/correlation.R

.PHONY: clean
clean:
	rm -f output/Alessia/*.png && rm -f output/Alessia/*.rds \
	&& rm -f output/Monica/*.csv && rm -f output/Xinyi/*.csv && \
	&& rm -f *.pdf && rm -f *.html

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"