# San Francisco Poverty versus Crime
# Chris Sinclair

# This analysis is performed on the 2014 American Community Survey provided by the U.S. Census Bureau,
# and comprises an annual 5 year aggregate dataset.



# San Francisco Districts match up                                Poverty percentage
# 
# 
# 
# Which districts overlap?
#   
# District                                                                  Poverty   Population        Overlap Percentage        Weighted Poverty    Weighted Population   
#   
# Supervisor District 1 - Richmond                                             11%    78,060              100%                        11%                   78,060                          
# 
# Supervisor District 2 - Northern (North of Geary Blvd)                        6%    67,190              65%                         3.9%                  43,673
# 
# Supervisor District 3 - Central                                              18%    75,750              100%                        18%                   75,750
# 
# Supervisor District 4 - Taraval (Upper Taraval - north of Sloat Blvd)        10%    75,120              50%                         5%                    37,560
# 
# Supervisor District 5 - Park and Northern (Northern Park, southern Northern) 15%    80,760              35% and 35%            5.25% and 5.25%          28,266 and 28,266
# 
# Supervisor District 6 - Southern and Tenderloin (full)                       23%    66,430 + 72,820     100% and 100%           23% and 23%             66,430 and 72,820
# 
# Supervisor District 7 - Taraval (lower Taraval)                              10%    72,820              50%                           5%                 36,410 
# 
# Supervisor District 8 - Park (rest of park)                                   7%    71,040              65%                          4.55%               46,176
# 
# Supervisor District 9 - Mission (east side)                                  13%    83,680              35%                          4.55%                29,288
# 
# Supervisor District 10 - Bayview                                             18%    73,150              100%                          18%                 73,150
# 
# Supervisor District 11 - Ingleside (lower half, south of Ocean Avenue)       11%    85,090              45%                           4.95%               38,290
# 
# 
# 
# So... how much poverty is in each police district?
#   
#   
#   
# Poverty per police district:            Population per police district          # incidents per district      Crime rate
#   
# Richmond = 11%                                    78,060                                13,759                  17.6%
# 
# Northern = 3.9% + 5.25% = 9.15%                   71,939                                29,667                  41.2%
# 
# Central = 18%                                     75,750                                25,650                  33.9%
#     
# Southern and Tenderloin = 23%                     139,250                           48,453 + 23,154             51.4%
# 
# Park = 5.25% + 4.55% = 9.8%                       74,442                                15,735                  21.1%
# 
# Mission = 4.55%                                   29,288                                35,392                  120.1%
# 
# Bayview = 18%                                     73,150                                27,169                  37.1%
# 
# Taraval = 5% + 5% = 10%                           73,970                                19,561                  26.4%
# 
# Ingleside = 4.95%                                 38,290                                23,370                  61%





# Averages over all years

# Which districts overlap?
#   
# District                                                                  Poverty   Population        Overlap Percentage        Weighted Poverty    Weighted Population   
#   
# Supervisor District 1 - Richmond                                             11%    78,060              100%                        11%                   78,060                          
# 
# Supervisor District 2 - Northern (North of Geary Blvd)                        6%    67,190              65%                         3.9%                  43,673
# 
# Supervisor District 3 - Central                                              18%    75,750              100%                        18%                   75,750
# 
# Supervisor District 4 - Taraval (Upper Taraval - north of Sloat Blvd)        10%    75,120              50%                         5%                    37,560
# 
# Supervisor District 5 - Park and Northern (Northern Park, southern Northern) 15%    80,760              35% and 35%            5.25% and 5.25%          28,266 and 28,266
# 
# Supervisor District 6 - Southern and Tenderloin (full)                       23%    66,430 + 72,820     100% and 100%           23% and 23%             66,430 and 72,820
# 
# Supervisor District 7 - Taraval (lower Taraval)                              10%    72,820              50%                           5%                 36,410 
# 
# Supervisor District 8 - Park (rest of park)                                   7%    71,040              65%                          4.55%               46,176
# 
# Supervisor District 9 - Mission (east side)                                  13%    83,680              35%                          4.55%                29,288
# 
# Supervisor District 10 - Bayview                                             18%    73,150              100%                          18%                 73,150
# 
# Supervisor District 11 - Ingleside (lower half, south of Ocean Avenue)       11%    85,090              45%                           4.95%               38,290
# 
# 
#




# So... how much poverty is in each police district?
#   
#   
#   
# Poverty per police district:            Population per police district          # incidents per district      Crime rate
#   
# Richmond = 11%                                    78,060                                13,759                  17.6%
# 
# Northern = 3.9% + 5.25% = 9.15%                   71,939                                29,667                  41.2%
# 
# Central = 18%                                     75,750                                25,650                  33.9%
#     
# Southern and Tenderloin = 23%                     139,250                           48,453 + 23,154             51.4%
# 
# Park = 5.25% + 4.55% = 9.8%                       74,442                                15,735                  21.1%
# 
# Mission = 4.55%                                   29,288                                35,392                  120.1%
# 
# Bayview = 18%                                     73,150                                27,169                  37.1%
# 
# Taraval = 5% + 5% = 10%                           73,970                                19,561                  26.4%
# 
# Ingleside = 4.95%                                 38,290                                23,370                  61%



# Low Poverty districts: Mission, Ingleside, Northern, Park
# High poverty districts: Richmond, Central, Southern and Tenderloin, Bayview
# Throw out Taraval

# Install aggregation package
install.packages("dplyr")
library("dplyr")

# Do not turn strings into factors
options(stringsAsFactors = FALSE)

# Read in data
df <- read.csv("Police_Department_Incident_Reports__Historical_2003_to_May_2018.csv", as.is = TRUE)

# Ensure dates are formatted as dates
df$Date <- as.Date(df$Date, "%m/%d/%Y")

# Split the data into observations for one year only
df <- df[df$Date > as.Date("2011-01-31"), ] # keep data after 2012
df <- df[df$Date < as.Date("2013-01-01"), ] # keep data numbefore 2013

# Save the file for later
write.csv(df, file = "san_fran_crime_2012.csv")

# Count number of incidents grouped by police district
#incidents <- df %>% group_by(df$PdDistrict) %>% tally()
blah <- df %>% group_by(df$Category) %>% tally()


# Create smaller dataset with only major crimes
df_major <- rbind(df[df$Category == 'ARSON', ],
                  df[df$Category == 'ASSAULT', ],
                  df[df$Category == 'BURGLARY', ],
                  df[df$Category == 'DRUGS', ],
                  df[df$Category == 'EMBEZZLEMENT', ],
                  df[df$Category == 'FAMILY OFFENSES', ],
                  df[df$Category == 'FRAUD', ],
                  df[df$Category == 'KIDNAPPING', ],
                  df[df$Category == 'LARCENY', ],
                  df[df$Category == 'MISSING PERSON', ],
                  df[df$Category == 'ROBBERY', ],
                  df[df$Category == 'SEX OFFENSES (FORCIBLE)', ],
                  df[df$Category == 'STOLEN PROPERTY', ],
                  df[df$Category == 'VEHICLE THEFT', ])


# Create smaller dataset with only minor crimes
df_minor <- rbind(df[df$Category == 'DISORDERLY',],
                  df[df$Category == 'DUI',],
                  df[df$Category == 'DRUNK',],
                  df[df$Category == 'FORGERY',],
                  df[df$Category == 'LIQUOR LAWS',],
                  df[df$Category == 'LOITERING',],
                  df[df$Category == 'RECOVERED VEHICLE',],
                  df[df$Category == 'RUNAWAY',],
                  df[df$Category == 'SUSPICIOUS',],
                  df[df$Category == 'TRESPASSING',],
                  df[df$Category == 'VANDALISM',],
                  df[df$Category == 'WEAPON LAWS',])

# Low poverty, minor crimes

low_minor <- rbind(df_minor[df_minor$PdDistrict == 'MISSION',],
                   df_minor[df_minor$PdDistrict == 'INGLESIDE',],
                   df_minor[df_minor$PdDistrict == 'NORTHERN',],
                   df_minor[df_minor$PdDistrict == 'PARK',],
                   df_minor[df_minor$PdDistrict == 'TARAVAL',])

# Low poverty, major crimes

low_major <- rbind(df_major[df_major$PdDistrict == 'MISSION',],
                   df_major[df_major$PdDistrict == 'INGLESIDE',],
                   df_major[df_major$PdDistrict == 'NORTHERN',],
                   df_major[df_major$PdDistrict == 'PARK',],
                   df_major[df_major$PdDistrict ==  'TARAVAL',])

# High poverty, minor crimes

high_minor <- rbind(df_minor[df_minor$PdDistrict == 'RICHMOND',],
                    df_minor[df_minor$PdDistrict == 'CENTRAL',],
                    df_minor[df_minor$PdDistrict == 'SOUTHERN',],
                    df_minor[df_minor$PdDistrict == 'TENDERLOIN',],
                    df_minor[df_minor$PdDistrict == 'BAYVIEW',])

# High poverty, major crimes

high_major <- rbind(df_major[df_major$PdDistrict == 'RICHMOND',],
                    df_major[df_major$PdDistrict == 'CENTRAL',],
                    df_major[df_major$PdDistrict == 'SOUTHERN',],
                    df_major[df_major$PdDistrict == 'TENDERLOIN',],
                    df_major[df_major$PdDistrict == 'BAYVIEW',])



# Chi-squared table

# low-minor   low-major
# high-minor  high-major

table_chi <- rbind(c(nrow(low_minor), nrow(low_major)), c(nrow(high_minor), nrow(high_major)))


# R correlation values
# Poverty percentage
pov <- c(11, 9.15, 18, 23, 9.8, 4.55, 18, 10, 4.95)
# Crime rate
crime <- c(17.6, 41.2, 33.9, 51.4, 21.1, 120.1, 37.1, 26.4, 61)

# Quadratic Regression
x2 <- pov^2
poly <- lm(log(crime) ~ x2 + pov)
summary(poly)
plot(pov, crime)
points(pov, exp(poly$fitted.values), type="l")

hist(log(crime))
