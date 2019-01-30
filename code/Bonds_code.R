#############################################################
##########    Financial Econometrics Project   ##############
#############################################################

#loading the required packages
#loading rmsfuns
library(rmsfuns)
packagestoload <- c("xts", "tidyverse", "devtools", "rugarch", "forecast", "tbl2xts", "PerformanceAnalytics", "dplyr",  
                    "lubridate", "glue", "ggthemes", "ggplot2", "Texevier", "parallel", "readr", "readxl", "xtable")
load_pkg(c("devtools", "rugarch", "forecast", "tidyr", "tbl2xts", "lubridate", "readr", "PerformanceAnalytics"))
load_pkg(packagelist = packagestoload)
library(Texevier)
############################

#loading the data
data.bonds <- 
  read_rds("data/Bonds_10Y.rds") %>% rename(Country=Name)



################################
####   cleaning the data  ######

load_pkg("tbl2xts")
load_pkg("DEoptimR")
load_pkg("robustbase")
#################################

#removing ticker and value column
data.bonds <- data.bonds[-4]
data.bonds <- data.bonds[-2]

data.bonds <- data.bonds %>% 
  filter(Country %in% c("AUS_10Yr","Canada_10Yr", "Korea_10Yr", "NZ_10Yr", "UK_10Yr", "US_10Yr"))

############
# Pre-crisis
############
sample_pre_start <- ymd(20010207)
sample_pre_end <- ymd(20071226)

data_pre <-   
  data.bonds %>% filter(date >= sample_pre_start & date<= sample_pre_end)
#############
# Post-crisis
#############
sample_post_start <- ymd(20091007)
sample_post_end <- ymd(20180627)

data_post <-   
  data.bonds %>% filter(date >= sample_post_start & date<= sample_post_end)  


#making data wide for cleaning below

wide_pre <- spread(data_pre, Country,Weekly_Returns)
colnames(wide_pre) <- colnames(wide_pre) %>% gsub("_10Yr","",.) 
wide_pre <- tbl_xts(wide_pre[, 1:length(wide_pre[1,]), drop = FALSE])
#### Now that it is wide, I can apply boudt's cleaning technique

clean_pre <- Return.clean(wide_pre, method = "boudt", alpha = 0.01)
clean_pre <- log(clean_pre + (1-min(clean_pre)))

wide_post <- spread(data_post, Country,Weekly_Returns)
colnames(wide_post) <- colnames(wide_post) %>% gsub("_10Yr","",.) 
wide_post <- tbl_xts(wide_post[, 1:length(wide_post[1,]), drop = FALSE])

#### Now that it is wide, I can apply boudt's cleaning technique
clean_post <- Return.clean(wide_post, method = "boudt", alpha = 0.01)
clean_post <- log(clean_post + (1-min(clean_post)))


##################################
#  Plotting each of the countries data to see from an initial perspective which countries may covary

# Getting data in tidy format again in order to graph the log returns
#### PRE
data_pre <- 
  clean_pre %>% 
  xts_tbl() %>% 
  gather(Country, Weekly_Returns, -date) %>%
  arrange(date)
### Post
data_post <- 
  clean_post %>% 
  xts_tbl() %>% 
  gather(Country, Weekly_Returns, -date) %>%
  arrange(date) 
  
  
data.bonds %>% ungroup() %>% ggplot() + geom_line(aes(date, Weekly_Returns)) + facet_wrap(~Country, scales = "free_y")

data_pre %>% ungroup() %>% ggplot() + geom_line(aes(date, Weekly_Returns)) + facet_wrap(~Country, scales = "free_y")

data_post %>% ungroup() %>% ggplot() + geom_line(aes(date, Weekly_Returns)) + facet_wrap(~Country, scales = "free_y")










