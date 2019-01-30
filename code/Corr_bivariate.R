# Dynamic Conditional Correlations Pre-crisis

AUS <-
  ggplot(Rhot_pre %>% filter(grepl("AUS_", Pairs ), !grepl("_AUS", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations pre-crisis: AUS")
print(AUS)

Canada <-
  ggplot(Rhot_pre %>% filter(grepl("Canada_", Pairs ), !grepl("_Canada", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations pre-crisis: Canada")
print(Canada)

UK <-
  ggplot(Rhot_pre %>% filter(grepl("UK_", Pairs ), !grepl("_UK", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations pre-crisis: UK")
print(UK)

Korea <-
  ggplot(Rhot_pre %>% filter(grepl("Korea_", Pairs ), !grepl("_Korea", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations pre-crisis: Korea")
print(Korea)

NZ <-
  ggplot(Rhot_pre %>% filter(grepl("NZ_", Pairs ), !grepl("_NZ", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations pre-crisis: NZ")
print(NZ)

US <-
  ggplot(Rhot_pre %>% filter(grepl("US_", Pairs ), !grepl("_US", Pairs)) ) +
  geom_line(aes(x = date, y = Rho, colour = Pairs)) +
  theme_hc() +
  ggtitle("Dynamic Conditional Correlations pre-crisis: US")
print(US)
