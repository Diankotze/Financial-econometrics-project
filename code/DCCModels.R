###################################################################################################################
############## Estimating the GARCH models for the DCC which will follow ##########################################

#loading the required packages again

library(rmsfuns)
load_pkg("MTS")
load_pkg(c("devtools", "rugarch", "forecast", "tidyr", "tbl2xts", "lubridate", "readr", "PerformanceAnalytics"))
  
###################################################################################
###################       Pre-crisis          #####################################

# First the data is spread to get it in wide format
RTN_pre <- data_pre %>% spread(Country, Weekly_Returns) %>% tbl_xts()

# Removing the first row(Not entirely sure why this is necessary)
RTN_pre <- RTN_pre[-1,]

# Centering the data:

RTN_pre <- scale(RTN_pre,center=T,scale=F)

# Now use code to clean the data using Boudt's technique: removing large spikes in the data

RTN_pre <- Return.clean(RTN_pre, method = c("none", "boudt", "geltner")[2], alpha = 0.01)

# DCCPre
# dccPre fits the univariate GARCH models to each series in our data frame of returns.
# For simplicity sake a VAR order of zero is selected for the mean equation, now I can simply use the mean of each series.

DCCPre_pre <- dccPre(RTN_pre, include.mean = T, p = 0)

# Then, for every series, a standard univariate GARCH(1,1) is run which gives us et and sigmat
# These values are then used to calculate the standardized residuals, zt, which is used in the DCC later on

names(DCCPre_pre)

# Now that I have the estimates of volatility for each of the series, lets graph this.

# Changing the  format to one that that is usable(usable xts)
Vol_pre <- DCCPre_pre$marVol
colnames(Vol_pre) <- colnames(RTN_pre)

# Volatility
Vol_pre <- 
  data.frame( cbind( date = as.Date(index(RTN_pre)), Vol_pre)) %>% # Add date column which dropped away...
  mutate(date = as.Date(date)) %>% tbl_df() # make date column a date column...

# Lets get the data in tidy format again, which is required to graph the volatility (sigma).
TidyVol_pre <- Vol_pre %>% gather(Country, Sigma, -date)

# Plot
ggplot(TidyVol_pre) + geom_line(aes(x = date, y = Sigma, colour = Country))

#Stoked! 

# Now I need to save the standardized residuals so that it can be used for the DCC

StdRes_pre <- DCCPre_pre$sresi

# Now we can use the standardized residuals as an input to our DCC model as per theory.

# As a result of the clash between the filter command between the 2 packages
# Lets detach dplyr and tidyr packages and run the dccfit and then reload the packages afterwards

detach("package:tidyr", unload=TRUE)
detach("package:tbl2xts", unload=TRUE)
detach("package:dplyr", unload=TRUE)
DCC_pre <- dccFit(StdRes_pre, type="Engle") #This takes a while

# now load it back in again!

load_pkg(c("tidyr","dplyr", "tbl2xts"))
library(rmsfuns)
#           DCC Model is estimated! what a feeling!
##########################################################################################

#From the equations above, we know that we can now calculate the bivariate correlation between all the pairs in the data set

Rhot_pre <- DCC_pre$rho.t
#######################################################################################
# Right, so it gives us all the columns together in the form:
# X1,X1 ; X1,X2 ; X1,X3 ; ....
#This gives 30 pairs from the 6 series(Countries)

##################   Now I repeat this for the period post-crisis   ###################
#######################################################################################
####################          Post-crisis      ########################################

RTN_post <- data_post %>% spread(Country, Weekly_Returns) %>% tbl_xts()


RTN_post <- RTN_post[-1,]
# Center the data:
RTN_post <- scale(RTN_post,center=T,scale=F)

# Now use code to clean the data using Boudt's technique: removing large spikes in the data
RTN_post <- Return.clean(RTN_post, method = c("none", "boudt", "geltner")[2], alpha = 0.01)

# DCCPre
DCCPre_post <- dccPre(RTN_post, include.mean = T, p = 0)
names(DCCPre_post)

# Change to format that is usable---usable xts
Vol_post <- DCCPre_post$marVol
colnames(Vol_post) <- colnames(RTN_post)

# Volatility
Vol_post <- 
  data.frame( cbind( date = as.Date(index(RTN_post)), Vol_post)) %>% # Add date column which dropped away...
  mutate(date = as.Date(date)) %>% tbl_df() # make date column a date column...

# Tidy format so that I am able to plot the volatility(sigma) of each of the countries
TidyVol_post <- Vol_post %>% gather(Country, Sigma, -date)

# Plot
ggplot(TidyVol_post) + geom_line(aes(x = date, y = Sigma, colour = Country))

# Now I need to save the standardized residuals so that it can be used for the DCC

StdRes_post <- DCCPre_post$sresi

# Now we can use the standardized residuals as an input to our DCC model as per theory.

# As a result of the clash between the filter command between the 2 packages
# Lets detach dplyr and tidyr packages and run the dccfit and then reload the packages afterwards

detach("package:tidyr", unload=TRUE)
detach("package:tbl2xts", unload=TRUE)
detach("package:dplyr", unload=TRUE)
DCC_post <- dccFit(StdRes_post, type="Engle")

# now load it back in again!

load_pkg(c("tidyr","dplyr", "tbl2xts"))

#           DCC Model is estimated! what a feeling!
##########################################################################################

#From the equations above, we know that we can now calculate the bivariate correlation between all the pairs in the data set

Rhot_post <- DCC_post$rho.t
#######################################################################################
# Right, so it gives us all the columns together in the form:
# X1,X1 ; X1,X2 ; X1,X3 ; ....
#This gives 30 pairs from the 6 series(Countries)

