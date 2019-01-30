#############################
#####   PRE-CRISIS  #########

sum_stat_table <- data_pre %>% 
  ungroup() %>% group_by(Country) %>% 
  summarise(mean_returns = mean(Weekly_Returns), std_dev_returns = sd(Weekly_Returns))
