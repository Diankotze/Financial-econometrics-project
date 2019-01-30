##### POST_CRISIS #####

sum_stat_table_post <- data_post %>% 
  ungroup() %>% group_by(Country) %>% 
  summarise(mean_returns = mean(Weekly_Returns), std_dev_returns = sd(Weekly_Returns))
