la_mort <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv"
la_case <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"

my_covid <- vroom(file = la_case) %>% 
  pivot_longer(cols = -(1:4)) %>% 
  mutate(name = mdy(name)) %>% 
  janitor::clean_names() %>% 
  rename(date = name)  


my_covid.mort <- vroom(file = la_mort) %>% 
  pivot_longer(cols = -(1:4)) %>% 
  mutate(name = mdy(name)) %>% 
  janitor::clean_names() %>% 
  rename(date = name)  

my_covid.mort.mx <- 
my_covid.mort %>% 
  filter(country_region=="Mexico") %>% 
  rename(deaths = value)

my_covid.cases.mx <- 
  my_covid %>% 
  filter(country_region=="Mexico") %>% 
  rename(cases = value)

my_casedeath.mx <- 
full_join(my_covid.cases.mx, my_covid.mort.mx, by = c("date"="date", "country_region"="country_region")) %>% 
  select(date, cases, deaths, country_region) %>% 
  rename(country = country_region) %>% 
  mutate(geoid = "MX")




