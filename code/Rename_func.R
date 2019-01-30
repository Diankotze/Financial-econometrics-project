############################################################
##### Function to rename column names of the DCC ###########
############################################################
# I want to give each column names which are shortened, making graphing and everything else easier.

renamingdcc <- function(ReturnSeries, DCC.TV.Cor){ 
  ncolrtn<- ncol(ReturnSeries)
  namesrtn <- colnames(ReturnSeries)
  paste(namesrtn, collapse = "_")
  nam <- c()
  xx <- mapply(rep, times = ncolrtn:1, x = namesrtn)
  
# Now we have this function we need to save the names which correspond to each of the cloumns 
  nam <- c()
  for (j in 1:(ncolrtn)) {
    for (i in 1:(ncolrtn)) {
      nam[(i + (j-1)*(ncolrtn))] <- paste(xx[[j]][1], xx[[i]][1], sep="_")
    }}
  
  colnames(DCC.TV.Cor) <- nam
#Now in order to plot all the correlations and the respective pairs, lets first get the date back..
#Appending the date column that has was removed again. Bit repetitive but has to be done.
  DCC.TV.Cor <-
    data.frame( cbind( date = as.Date(index(ReturnSeries)), DCC.TV.Cor)) %>% # Add date column which dropped mutate(date = as.Date(date)) %>% tbl_df()
    mutate(date = as.Date(date)) %>% tbl_df()
    DCC.TV.Cor <- DCC.TV.Cor %>% gather(Pairs, Rho, -date)
  DCC.TV.Cor
}

# Now we can see if this function that was created, will work. 
Rhot_pre <-
  renamingdcc(ReturnSeries = RTN_pre, DCC.TV.Cor = Rhot_pre)

