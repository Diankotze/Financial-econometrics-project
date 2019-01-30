# Dynamic Conditional Correlations Post-crisis

# Making sure the function works
Rhot_post <-
  renamingdcc(ReturnSeries = RTN_post, DCC.TV.Cor = Rhot_post)

AUS_post <-
  ggplot(Rhot_post %>% filter(grepl("AUS_", Pairs ), !grepl("_AUS", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations post-crisis: AUS")
print(AUS_post)

Canada_post <-
  ggplot(Rhot_post %>% filter(grepl("Canada_", Pairs ), !grepl("_Canada", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations post-crisis: Canada")
print(Canada_post)

UK_post <-
  ggplot(Rhot_post %>% filter(grepl("UK_", Pairs ), !grepl("_UK", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations post-crisis: UK")
print(UK_post)

Korea_post <-
  ggplot(Rhot_post %>% filter(grepl("Korea_", Pairs ), !grepl("_Korea", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations post-crisis: Korea")
print(Korea_post)

NZ_post <-
  ggplot(Rhot_post %>% filter(grepl("NZ_", Pairs ), !grepl("_NZ", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations post-crisis: NZ")
print(NZ_post)

US_post <-
  ggplot(Rhot_post %>% filter(grepl("US_", Pairs ), !grepl("_US", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations post-crisis: US")
print(US_post)
