#install.packages('tidyverse')
#install.packages('RCurl')
#install.packages('AICcmodavg')
library(AICcmodavg)
library(tidyverse)
library(RCurl)
library(scales)
library(readr)

#hypotheses
    #1) average disposable income per capita is positively related to the average selling price of yeezys. (TABLEAU MEAN OF SELL PRICE AND INCOME)
    #2) solid color yeezys appreciate faster than multicolored yeezys or striped yeezys (TABLEAU GROUP COLORS AND TAKE AVERAGE OR PLOT TWO LINES IN R)
    #3) higher shoe size correlates to higher resale price (REGRESSION IN R)
    #4) later order date (more recent) correlates to higher resale price. (REGRESSION IN R)

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
    #col 1 = price, col 2 = make, col 3 = size, col 4 = stripe, col 5 = time since release
    #turn stripe and color into a binary regressor of just 0 and 1. 0 for black 1 for white, then you can run a regression on it.
    #dependent var is shoe price, independent vars are days since initial drop, shoe size, and the binary regressor (light/dark-stripe ----> name (7 different 0s and 1s))

    #interpretation is how much higher in average the price of this shoe is relative to the base case. (base case is qualitative category that we aren't including specifically in our model)









#Extra information

    #dummy variables act as like a switch for your model, where you can pick and choose different cases without having to run separate models
        #usually for example, if you wanted to look at houses that were built before 1900, you would do 0 for after 1900 and 1 for before 1900
        #then there would be another category where it would be 1 for east side of city and 0 for west side. And it works like a combo of 0s and 1s


    #base case is just the 0 of the dummy variable, the control group, the one where you expect nothing to happen. and the 1s are where you expect 
        #something to change depending on the variables included. 

    #remove beluga because beluga is the base case. Interact IPO with each one of the binary regressors

    #in interpreting coefficients
      #price in dollars on average (x dollars) higher or lower than the base case of beluga




    #first import the dataset

shoesURL <- 'https://raw.githubusercontent.com/nstutelberg/Projects/main/sneaker_data.csv'

shoes <- read_csv(url(shoesURL),
                  col_types = cols(`Order Date` = col_date(format = "%m/%d/%Y"), 
                                   `Sale Price` = col_number(), `Retail Price` = col_number(), 
                                   `Release Date` = col_date(format = "%m/%d/%Y")))

shoes <- shoes %>%
  filter(`Shoe Size` < 14)


    #Test regression for interpretation reference. Predictor = Shoe Size | Response = Price
testlm <- lm(`Sale Price` ~ `Shoe Size`, data = shoes)
summary(testlm)

            #residuals are the differences between observed response values (price) and the response values that the model predicted (shoe size)
                  #Looking for symmetrical distribution, and since our data is not symmetrical, the model is predicting points that land far away from the actual observed points.
            #intercept coefficient of 361.21 is the expected value when considering average shoe size of all shoes in dataset. (avg price is 361.21) (statistically significant to 99%+ level)
            #standard error of 0.36 is showing average amount that coefficient estimates vary from the avg price (regression line) 
                  #our standard error is smaller than the coefficient. Say that if we ran the model again, the price should vary by $0.36 in relation to the avg price
            #p value of <2e-16 is the probability of observing a value larger than t (25.28).This value is small enough where the relationship between price and shoe size is unlikely due to chance. 
            #shoe Size coefficient of 9.17 shows inverse relationship between price and shoe size. (99% confidence level).
                #For every 1 unit increase in shoe size -> 9.17 unit increase in price
            #residual standard error of 254.5 is measuring the quality of the regression fit. It's the avg amount that the price will deviate from regression line (97,866 df)
                #given the mean price is $361.21 and the residual standard error is 254.5, the percentage error (the % any prediction would still be off by) is 70.46%
            #R Squared of 0.0065 shows that our predictor variable (shoe size) isn't accounting for much of the total variance (Only .65%)
            #F statistic of 638.9 is indicating whether there is a relationship between price and shoe size. F statistic is significantly larger than 1 so we can infer a relationship
        



    #test count of each shoe to see the distribution of data
view(count(shoes, shoes$`Sneaker Name`))
            #Select top 10 most commonly sold shoes so we can get a large enough sample size. Exclude other brands besides Yeezys


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



    #now we have all of these separate dataframes. Graphing template below for using ggplot to plot a regression line
library(ggplot2)
ggplot(butter, aes(x = `Order Date`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = "lm")

ggplot(frozen, aes(x = `Order Date`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = lm)


    #also tested some log models. Logging works when the data is covering a large range and when we are more concerned with percentage change in price rather than the numerical change

ggplot(butter, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
  geom_point() + geom_smooth(method = lm) +
  scale_y_log10() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b-%y")

ggplot(zebra, aes(x = `Order Date`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = lm) +
  scale_y_log10() +
  scale_x_date(date_breaks = "1 month", date_labels = "%b-%y")





    #Now to run regressions on the salr price and shoe size for various models. General format below
            # yourRegressionName <- lm(`Sale Price` ~ `Predictor Variable You want`, dataframeYourePullingFrom)
            # sale price stays in the same spot as the dependent variable

ButterSizeReg <- lm(`Sale Price` ~ `Shoe Size`, butter)
summary(ButterSizeReg)

FrozenSizeReg <- lm(`Sale Price` ~ `Shoe Size`, frozen)
summary(FrozenSizeReg)

           #can do multivariable regression as well with the same format

ButterMultipleReg <- lm(`Sale Price` ~ `Order Date` + `Shoe Size`, butter)
summary(ButterMultipleReg)







    #Creation of the main dataframe we will analyze

shoessubset <- c("adidas-Yeezy-Boost-350-V2-Butter", "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Blue-Tint", "Adidas-Yeezy-Boost-350-V2-Cream-White", "Adidas-Yeezy-Boost-350-V2-Sesame", "adidas-Yeezy-Boost-350-V2-Static", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", "adidas-Yeezy-Boost-350-V2-Static-Reflective")

shoestotal <- shoes %>%
  filter(`Sneaker Name` %in% shoessubset)


            #now I want to add if its a light or dark color, and stripe vs no stripe. 

DarkYeezys <- c("Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "adidas-Yeezy-Boost-350-V2-Static", "adidas-Yeezy-Boost-350-V2-Static-Reflective", "Adidas-Yeezy-Boost-350-V2-Sesame")
LightYeezys <- c("adidas-Yeezy-Boost-350-V2-Butter", "Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Blue-Tint", "Adidas-Yeezy-Boost-350-V2-Cream-White", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow")
shoestotal <- shoestotal %>%
  mutate("Light_Dark" = if_else(shoestotal$`Sneaker Name` %in% DarkYeezys, "dark", "light"))

StripeYeezys <- c("Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", "Adidas-Yeezy-Boost-350-V2-Blue-Tint")
SolidYeezys <- c("adidas-Yeezy-Boost-350-V2-Butter", "adidas-Yeezy-Boost-350-V2-Static", "adidas-Yeezy-Boost-350-V2-Static-Reflective", "Adidas-Yeezy-Boost-350-V2-Sesame", "Adidas-Yeezy-Boost-350-V2-Cream-White")

shoestotal <- shoestotal %>%
  mutate("Stripe" = if_else(shoestotal$`Sneaker Name` %in% StripeYeezys, "Stripe", "Solid"))


            #only select 2019-02-06 since that was when most pairs were sold

shoestotal <- shoestotal %>%
  filter(`Order Date` == "2019-02-06")

            #datediff function to get a numeric value for days since IPO

shoestotal <- shoestotal %>%
mutate("Days_Since_IPO" = (difftime(shoestotal$`Order Date`, shoestotal$`Release Date`, units = c("days"))))





    #Making a binary column for each model of Yeezy. Beluga will be excluded in the next script since it is acting as the base case, but the script is here if we want to use another model as the base case in the future.

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Beluga" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Blue_Tint" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Blue-Tint", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Butter" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Butter", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Cream_White" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Cream-White", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Frozen_Yellow" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Sesame" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Sesame", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Static" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Static", 1, 0))

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Static_Reflective" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Static-Reflective", 1, 0))
          
shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Zebra" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Zebra", 1, 0))


            #taking out Beluga because the Beluga model is acting as our base case. We are using Beluga as the default model for a shoe and comparing all other models to the Beluga model
shoestotal <- shoestotal %>%
  select(-Beluga)






    #regressions

           #regression with all models and their binary columns included
summary(lm(`Sale Price` ~  `Shoe Size` + `Days_Since_IPO` + `Blue_Tint` + `Butter` + `Cream_White` + `Frozen_Yellow` + `Sesame` + `Static` + `Static_Reflective` + `Zebra`, data = shoestotal))
           #results - High Rsquared at 92.1%, but there are so many independent variables here that the Rsquared is naturally going to be higher
                #hard to determine which variables are accounting for the most variation in the independent variable. Need to scale the model down


           #regression with the categorical columns. Stripe and Light_Dark only have two options so they are acting as binary regressors in this case
summary(lm(`Sale Price` ~ `Shoe Size` + `Days_Since_IPO` + `Stripe` + `Light_Dark`, data = shoestotal))
                #results - 29.17% Rsquared, but also using less variables. Stripe and Light_Dark having the most impact on the price here



    #Regression equations in statistical format
            #    B0 + B1ShoeSize + B2DaysSinceIPO + B3Beluga + B4BlueTint + B5Butter + B6CreamWhite + B7FrozenYellow + B8Sesame + B9Static + B10StaticReflective + B11Zebra
                #OR INDIVIDUAL
            #    B0 + B1ShoeSize + B2DaysSinceIPO + B3Beluga
            #    B0 + B1ShoeSize + B2DaysSinceIPO + B4BlueTint
            #    B0 + B1ShoeSize + B2DaysSinceIPO + B5Butter



    #Converting categorical variables into quantitative variables. Using 1's and 0's to compare the regression results to the base case. 
            #using the base case of Beluga to have 1s for dark yeezys and 1s for striped yeezys to match the Beluga characteristics
shoestotal <- shoestotal %>%
  mutate(`Light_Dark` = if_else(`Light_Dark` == "light", 0, 1))

shoestotal <- shoestotal %>%
  mutate(Stripe = if_else(`Stripe` == "Solid", 0, 1))


    #standardizing/transforming a few of the independent variables to be used in the AIC calculation
           #Can log both independent and dependent so that the interpretation is interpreted as a percentage change
           #Also can log to improve model fit, as sale price varies significantly depending on the date of sale and the type of sneaker
shoestotal <- shoestotal %>%
  mutate(`Days_Since_IPO` = as.numeric(shoestotal$Days_Since_IPO)) %>%
  mutate(`Log_Days_Since_IPO` = log(`Days_Since_IPO`))

shoestotal <- shoestotal %>%
  mutate(`Log_Sale_Price` = log(shoestotal$`Sale Price`))
            #logging the sale price may bring down the variation in the sale prices, since a sale of a sneaker can be worth 3x more at release than it is worth say a year down the line. Want to tame down that variation

shoestotal <- shoestotal %>%
  mutate(`Shoe_Size_Squared` = (`Shoe Size`)^2)
            #squaring the shoe size makes the larger sizes more prominent in the model. 

shoestotal <- shoestotal %>%
  mutate(`Interaction_Color_Stripe` = `Light_Dark` * `Stripe`)
            #Creating an interaction variable to account for stripe and light/dark. Use this interaction to account for the color and pattern differences in the sneakers without having separate independent variables for each color



    #AIC calculation to evaluate how well the model is fitting the data. Comparing various combinations of dependent variables to see which has the best fit
            #Trying to find the variables that explain the greatest amount of variation using the fewest independent variables as possibl
            #smaller the better

    #All variables
lm1 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal)  

    #no shoe size
lm2 <- lm(`Log_Sale_Price` ~ `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal)

    #no shoe squared
lm3 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal) 

    #no log ipo
lm4 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Interaction_Color_Stripe`, data = shoestotal)

    #no interaction
lm5 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO`, data = shoestotal)

models <- list(lm1, lm2, lm3, lm4, lm5)
aictab(cand.set = models, modnames = c('All Variables', 'No Shoe Size', 'No Shoe Size Squared', 'No Log Days Since IPO', 'No Color Stripe Interaction'))

      #results - Days Since IPO and Color Stripe Interaction appear to be the most influential independent variables in the model, with days since IPO being the most influential
                #Taking out shoe size/shoe size squared has little impact on the AIC calculation, so in our final regression we will remove this variable.




    #base regression
summary(lm(`Log_Sale_Price` ~ `Shoe Size` + `Log_Days_Since_IPO` + `Stripe` + `Light_Dark` + `Interaction_Color_Stripe`, data = shoestotal))
            #restricted to only include the most relevant variables

summary(lm(`Log_Sale_Price` ~  `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal))
summary(lm(`Sale Price` ~ `Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal))

    #no shoe size after AIC wald test
summary(lm(`Log_Sale_Price` ~ `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Stripe` + `Light_Dark` + `Interaction_Color_Stripe`, data = shoestotal))
summary(lm(`Log_Sale_Price` ~ `Shoe Size` + `Stripe` + `Light_Dark`, data = shoestotal))


    #testing if the interaction between solid and stripe is a good fit for our model

    #no interaction
summary(lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Stripe` + `Light_Dark`, data = shoestotal))
    #with interaction
summary(lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal))
    
    #summary - lose out on some Rsquared when using interaction, and harder to interpret. Final model should use Stripe and Light_Dark so you can see the impact on each of these characteristics more clearly






                                                  #Final results + regression 

summary(lm(`Sale Price` ~ `Days_Since_IPO` + `Stripe` + `Light_Dark`, data = shoestotal))


#results - not very high Rsquared for any of these models, but when using just a few variables, you can see the affect of these few independent variables in accounting for variability in the sneaker prices
      #Can see that shoe size, whether squared or not, is not a good predictor of resale price. This is likely because both small and large sizes sell for the most money, and the sale prices depend on the sneaker model itself. 