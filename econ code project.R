#install.packages(tidyverse)
library(tidyverse)

#hypotheses
    #1) average disposable income per capita is positively related to the average selling price of yeezys. (TABLEAU MEAN OF SELL PRICE AND INCOME)
    #2) solid color yeezys appreciate faster than multicolored yeezys or striped yeezys (TABLEAU GROUP COLORS AND TAKE AVERAGE OR PLOT TWO LINES IN R)
    #3) does higher shoe size correlate to higher resale price (REGRESSION IN R)
    #4)  later order date, more recent correlate to higher resale price. (REGRESSION IN R)

#notes
    #fix a day and find the day that has the greatest variation in the cross section, a day where you have the most models being sold
    #looking for greatest degree of variation fixing the time period, CROSS SECTIONAL ANALYSIS. fix time period of sale
    #an option would be to only include common sizes so you have more observations that are more consistent

#proposed plan
    #find greatest number of observations on a given day, fix time, find sale date that gives largest # of observations of each make
    #find a day with greatest number of observations for each specific shoe, regress price on shoe size and quantity of shoes that was released (probably not available)


#if doing a cross sectional analysis, include variable days since release date, need to convert date to number and find number of days since the initial release date. Also only use one date
    #time frame should be dec 2018 to feb 2019 so you can have that time period where all of the shoes are on the market, and then add that extra variable of days since IPO
    #choose any one day from dec 20 2018 to feb 2 2019 that has the most sales of each shoe

#Creating binary regressors
    #col 1 price, col 2 = make, col 3 = size, col 4 = stripe, col 5 = time since release
    #turn stripe and color into a binary regressor of just 0 and 1. 0 for black 1 for white, then you can run a regression on it.
    #dependent var is shoe price, independent vars are days since initial drop, shoe size, and the binary regressor (light/dark-stripe ----> name (7 different 0s and 1s))

    #interpretation is how much higher in average the price of this shoe is relative to the base case. (base case is qualitative category that we aren't including specifically in our model)









#professor questions about using name as a binary regressor and using base cases.

    #is this a dummy variable situation, where we are only using 0s and 1s. And we have to choose a base case, which is an expected outcome of the regression.
        #0 is control and 1 is the treatment case. But each one is different, so I don't know which one would be the control group.

    #dummy variables act as like a switch for your model, where you can pick and choose different cases without having to run separate models
        #usually for example, if you wanted to look at houses that were built before 1900, you would do 0 for after 1900 and 1 for before 1900
        #Then there would be another category where it would be 1 for east side of city and 0 for west side. And it works like a combo of 0s and 1s


    #base case is just the 0 of the dummy variable, the control group, the one where you expect nothing to happen. and the 1s are where you expect 
        #something to change depending on the variables included. 

    #should there not be an actual base case, but just number each of the different shoes from 1-8? But then that wouldn't be a dummy variable/binary situation
        #because it wouldn't just be 1s and 0s. 

    #should we run all the binary regressor equations separately or include them together. the results vary greatly depending on what you do







    #remove beluga because beluga is the base case
    #interact IPO with each one of the binary regressors
    #18 regressors in total 8 binaries, shoe size, days since IPO, plus 8 extra variables with interaction





    #in interpreting coefficients
      #price in dollars on average (x dollars) higher or lower than the base case of beluga







`L`


#next we have to import the dataset, and you want to copy this command, but instead put your file path.
    #do this by going to the file in file explorer, and when you click on it once, an option on the top function bar should say
      #copy file path. copy that path and replace the "D:/r studio/datasets/stockxrstudio.csv" with your own

library(readr)
shoes <- read_csv("D:/r studio/datasets/stockxrstudio.csv", 
                  col_types = cols(`Order Date` = col_date(format = "%m/%d/%Y"), 
                                   `Sale Price` = col_number(), `Retail Price` = col_number(), 
                                   `Release Date` = col_date(format = "%m/%d/%Y")))

shoes <- shoes %>%
  filter(`Shoe Size` < 14)

randomlm <- lm(`Sale Price` ~ `Order Date`, data = butter)
summary(randomlm)




#now I will do this command that will work for you, but I am just separating out this dataframe to make one for each of the shoes
    
  #but first, lets look at that list of shoes that has the most pairs
shoecount <- count(shoes, shoes$`Sneaker Name`)
    #can filter by clicking the title of the column, and see what shoes have the highest count of sneakers










#now we see what ones we want, which are:	

#adidas-Yeezy-Boost-350-V2-Butter	

#Adidas-Yeezy-Boost-350-V2-Beluga-2pt0	

#Adidas-Yeezy-Boost-350-V2-Zebra	

#Adidas-Yeezy-Boost-350-V2-Blue-Tint	

#Adidas-Yeezy-Boost-350-V2-Cream-White	

#Adidas-Yeezy-Boost-350-V2-Sesame	

#adidas-Yeezy-Boost-350-V2-Static	

#Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow	

#Air-Jordan-1-Retro-High-Off-White-University-Blue	

#adidas-Yeezy-Boost-350-V2-Static-Reflective	


butter <- shoes %>%
  filter(grepl(pattern = ".*Butter", shoes$`Sneaker Name`))
beluga <- shoes %>%
  filter(grepl(pattern = ".*Beluga-2pt0$", shoes$`Sneaker Name`))
zebra <- shoes %>%
  filter(grepl(pattern = ".*Zebra$", shoes$`Sneaker Name`))
bluetint <- shoes %>%
  filter(grepl(pattern = ".*Blue-Tint$", shoes$`Sneaker Name`))
cream <- shoes %>%
  filter(grepl(pattern = ".*Cream-White$", shoes$`Sneaker Name`))
sesame <- shoes %>%
  filter(grepl(pattern = ".*Sesame$", shoes$`Sneaker Name`))
staticnon <- shoes %>%
  filter(grepl(pattern = ".*Static$", shoes$`Sneaker Name`))
frozen <- shoes %>%
  filter(grepl(pattern = ".*Semi-Frozen-Yellow$", shoes$`Sneaker Name`))
staticref <- shoes %>%
  filter(grepl(pattern = ".*Static-Reflective$", shoes$`Sneaker Name`))

      
#!!!!!!make sure to check these dataframes because I could have been wrong here and mixed up shoes. prob right but cant confirm






#now we have all of these separate dataframes. THIS WILL BE A GRAPHING TEMPLATE

library(ggplot2)
ggplot(butter, aes(x = `Order Date`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = "lm")

ggplot(frozen, aes(x = `Order Date`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = lm)
  

#to change to a different shoe, change the BUTTER part to another shoe, like make that part frozen, or cream, or beluga etc
    #everything else will stay the same here


library(scales)


#I also tested some log models, and compare the graphs, the one where I logged it looks a lot better

ggplot(butter, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
  geom_point() + geom_smooth(method = lm) +
  scale_y_log10() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b-%y")

ggplot(zebra, aes(x = `Order Date`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = lm) +
  scale_y_log10() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b-%y")
        #except this one doesnt look that much better logged, because it had a nice distribution to begin with. idk if this is important or not though






#now we can run some regressions, and the general format is::::
      
          #    yourRegressionName <- lm(`Sale Price` ~ `Predictor Variable You want`, dataframeYourePullingFrom)

ButterSizeReg <- lm(`Sale Price` ~ `Shoe Size`, butter)
summary(ButterSizeReg)

FrozenSizeReg <- lm(`Sale Price` ~ `Shoe Size`, frozen)
summary(FrozenSizeReg)




#and we can run regressions on different variables too. KEEP SALE PRICE AT SAME SPOT

ButterDateReg <- lm(`Sale Price` ~ `Order Date`, butter)
summary(ButterDateReg)





#and you can do multivariable regression too by this format

ButterMultipleReg <- lm(`Sale Price` ~ `Order Date` + `Shoe Size`, butter)
summary(ButterMultipleReg)







#forgot, but I should make a massive data frame where its just the shoes that we want

shoeswant <- c("adidas-Yeezy-Boost-350-V2-Butter", "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Blue-Tint", "Adidas-Yeezy-Boost-350-V2-Cream-White", "Adidas-Yeezy-Boost-350-V2-Sesame", "adidas-Yeezy-Boost-350-V2-Static", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", "adidas-Yeezy-Boost-350-V2-Static-Reflective")

shoestotal <- shoes %>%
  filter(`Sneaker Name` == c("adidas-Yeezy-Boost-350-V2-Butter" | "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0" | "Adidas-Yeezy-Boost-350-V2-Zebra" | "Adidas-Yeezy-Boost-350-V2-Blue-Tint" | "Adidas-Yeezy-Boost-350-V2-Cream-White" | "Adidas-Yeezy-Boost-350-V2-Sesame" | "adidas-Yeezy-Boost-350-V2-Static" | "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow" | "adidas-Yeezy-Boost-350-V2-Static-Reflective"))

shoestotal <- shoes %>%
  filter(`Sneaker Name` %in% shoeswant)





#now I want to add if its a light or dark color, and stripe vs no stripe. 

darkyeezys <- c("Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "adidas-Yeezy-Boost-350-V2-Static", "adidas-Yeezy-Boost-350-V2-Static-Reflective", "Adidas-Yeezy-Boost-350-V2-Sesame")
lightyeezys <- c("adidas-Yeezy-Boost-350-V2-Butter", "Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Blue-Tint", "Adidas-Yeezy-Boost-350-V2-Cream-White", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow")
shoestotal <- shoestotal %>%
  mutate("Light or Dark" = if_else(shoestotal$`Sneaker Name` %in% darkyeezys, "dark", "light"))

stripeyeezys <- c("Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", "Adidas-Yeezy-Boost-350-V2-Blue-Tint")
nostripeyeezys <- c("adidas-Yeezy-Boost-350-V2-Butter", "adidas-Yeezy-Boost-350-V2-Static", "adidas-Yeezy-Boost-350-V2-Static-Reflective", "Adidas-Yeezy-Boost-350-V2-Sesame", "Adidas-Yeezy-Boost-350-V2-Cream-White")

shoestotal <- shoestotal %>%
  mutate("Stripe" = if_else(shoestotal$`Sneaker Name` %in% stripeyeezys, "stripe", "nostripe"))




#now we want to only select 2/6 since that was when most pairs were sold

shoestotal <- shoestotal %>%
  filter(`Order Date` == "2019-02-06")


#now mutate a column(distance from release date)

shoestotal <- shoestotal %>%
mutate("Days Since IPO" = (difftime(shoestotal$`Order Date`, shoestotal$`Release Date`, units = c("days"))))


              binaries <- c("Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", "Adidas-Yeezy-Boost-350-V2-Blue-Tint", "Adidas-Yeezy-Boost-350-V2-Sesame", "adidas-Yeezy-Boost-350-V2-Static")


shoestotal <- shoestotal %>%
  select(-Brand) %>%
  mutate("Sneaker Binary" = if_else(`Sneaker Name` %in% binaries, 0, 1))


    #Temporary, because I don't know which shoe is a base case, and which ones should have 1 as that value. Or if they should all be different
count(shoestotal, `Sneaker Name`)

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Beluga" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Blue Tint" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Blue-Tint", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Butter" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Butter", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Cream White" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Cream-White", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Frozen Yellow" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Sesame" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Sesame", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Static" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Static", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Static Reflective" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Static-Reflective", 1, 0))
          
shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Zebra" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Zebra", 1, 0))

shoestotal <- shoestotal %>%
  select(-Beluga)

summary(lm(`Sale Price` ~ `Sneaker Binary`, data = shoestotal))

summary(lm(`Sale Price` ~ `Shoe Size` + `Days Since IPO` + `Blue Tint` + `Butter` + `Cream White` + `Frozen Yellow` + `Sesame` + `Static` + `Static Reflective` + `Zebra`, data = shoestotal))

summary(lm(`Sale Price` ~ `Shoe Size` + `Days Since IPO` + `Stripe` + `Light or Dark`, data = shoestotal))

shoestotal2 <- shoestotal %>%
  mutate(Beluga = )


#equation

#    B0 + B1ShoeSize + B2DaysSinceIPO + B3Beluga + B4BlueTint + B5Butter + B6CreamWhite + B7FrozenYellow + B8Sesame + B9Static + B10StaticReflective + B11Zebra


    #OR INDIVIDUAL
#    B0 + B1ShoeSize + B2DaysSinceIPO + B3Beluga
#    B0 + B1ShoeSize + B2DaysSinceIPO + B4BlueTint
#    B0 + B1ShoeSize + B2DaysSinceIPO + B5Butter


















#used this command to turn the dataframe into a csv file to export to other programs. 
#write.csv(map.df, "D:\\school files\\ECONOMETRICS\\butterCSVecon2.csv", row.names = FALSE)

#write.csv(shoesdf, "D:\\school files\\ECONOMETRICS\\EconShoeFinal.csv", row.names = FALSE)

write.csv(shoestotal, "D:\\school files\\ECONOMETRICS\\EconShoeFinal3.csv", row.names = FALSE)





#where i left off. I was trying to consolidate the 9 pairs of shoes and put them into tableau but there were 5 million records, so it didn't load properly
#I think the issue was when I tried to do the graphing in ggplot I needed to get really accurate coordinates, but on tableau I can just use the buyer region
#so i Dont think I need those massive datasets idk. 

#I think I need to separate out the dataframes into one big one, and 9 small ones. then I can run individual regressions etc on each and I can see the dates that all
#the sales start on and see what I want to keep. Tableau will be good for graphing and R is good forregressions.

#next step is to mutate on columns if its a light colored shoe or dark colored or neutral color shoe. AS WELL AS plain shoe vs striped shoe

#important note is to check for restocks because those could mess you up. 

#ALSO LAST THING I MADE THE SHOESTOTAL DATAFRAME FROM THIS shoestotal <- shoes %>%filter(`Sneaker Name` %in% shoeswant) AND JUST MADE A NORMAL DATAFRAME WITH THE SHOES I WANTED SECTIONED OUT


shoestotal <- shoestotal %>%
  mutate(`Light or Dark` = if_else(`Light or Dark` == "light", 0, 1))

shoestotal <- shoestotal %>%
  mutate(Stripe = if_else(`Stripe` == "nostripe", 0, 1))

shoestotal <- shoestotal %>%
  mutate(`Log Days Since IPO` = log(`Days Since IPO`))

shoestotal <- shoestotal %>%
  mutate(`Log Sale Price` = log(shoestotal$`Sale Price`))

shoestotal <- shoestotal %>%
  mutate(`Shoe Size Squared` = (`Shoe Size`)^2)


shoestotal <- shoestotal %>%
  mutate(`Interaction Color Stripe` = `Light or Dark` * `Stripe`)

#base REGRESSION
summary(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Log Days Since IPO` + `Stripe` + `Light or Dark` + `Interaction Color Stripe`, data = shoestotal))
#restricted
summary(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Log Days Since IPO` + `Interaction Color Stripe`, data = shoestotal))
#no shoe size after AIC wald test
summary(lm(`Log Sale Price` ~ `Shoe Size Squared` + `Log Days Since IPO` + `Stripe` + `Light or Dark` + `Interaction Color Stripe`, data = shoestotal))
summary(lm(`Log Sale Price` ~ `Shoe Size` + `Stripe` + `Light or Dark`, data = shoestotal))




####Aic stuff
AIC(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Log Days Since IPO` + `Interaction Color Stripe`, data = shoestotal)
)

#no shoe size
AIC(lm(`Log Sale Price` ~ `Shoe Size Squared` + `Log Days Since IPO` + `Interaction Color Stripe`, data = shoestotal)
)

#no shoe squared
AIC(lm(`Log Sale Price` ~ `Shoe Size` + `Log Days Since IPO` + `Interaction Color Stripe`, data = shoestotal)
)

#no log ipo
AIC(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Interaction Color Stripe`, data = shoestotal)
)

#no interaction
AIC(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Log Days Since IPO`, data = shoestotal)
)





#NOOOO INTERACTION
summary(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Log Days Since IPO` + `Stripe` + `Light or Dark`, data = shoestotal))
summary(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Log Days Since IPO`, data = shoestotal))

####Aic stuff
AIC(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared` + `Log Days Since IPO`, data = shoestotal)
)

#no shoe size
AIC(lm(`Log Sale Price` ~ `Shoe Size Squared` + `Log Days Since IPO` , data = shoestotal)
)

#no shoe squared
AIC(lm(`Log Sale Price` ~ `Shoe Size` + `Log Days Since IPO`, data = shoestotal)
)

#no interaction
AIC(lm(`Log Sale Price` ~ `Shoe Size` + `Shoe Size Squared`, data = shoestotal)
)


summary(lm(`Log Sale Price` ~ `Shoe Size` + `Log Days Since IPO` + `Stripe` + `Light or Dark` + `Interaction Color Stripe`, data = shoestotal))

sapply(shoestotal, class)

shoestotal$`Days Since IPO` <- as.numeric(shoestotal$`Days Since IPO`)
       #0 is light 1 is dark


#LAST LAST THING
    #should i adjust the dataframes so they have the same starting date?
      #pro-you can account for world events li
      #con-you are getting innacurate data because shoes follow the high initial price, lower after drop path, and if you chop off one of theke covid in all shoes, because they happen over same time frame. less variability there oldest shoes, price would seem lower overall.


#should i take out really big sizes because they skew data?
