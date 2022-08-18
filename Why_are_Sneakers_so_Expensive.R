#install.packages('tidyverse')
#install.packages('RCurl')
#install.packages('AICcmodavg')
#install.packages('aod')
library(aod)
library(AICcmodavg)
library(tidyverse)
library(RCurl)
library(scales)
library(readr)
library(ggthemes)
library(ggplot2)

#hypotheses
    #1) average disposable income per capita is positively related to the average selling price of yeezys.
    #2) solid color yeezys appreciate faster than striped yeezys.
    #3) dark color yeezys appreciate faster than light color yeezys.
    #3) higher shoe size correlates to higher resale price.
    #4) later order date (more recent date) correlates to higher resale price. 

#notes
    #fix a day and find the day that has the greatest variation in the cross section, a day where you have the most models being sold
    #looking for greatest degree of variation fixing the time period, CROSS SECTIONAL ANALYSIS. fix time period of sale
    #an option would be to only include common sizes so you have more observations that are more consistent

#proposed plan
    #find greatest number of observations on a given day, fix time, find sale date that gives largest # of observations of each sneaker model

#cross sectional analysis information
    #if doing a cross sectional analysis, include variable days since release date, need to convert date to number and find number of days since the initial release date. Also only use one date
    #time frame should be dec 2018 to feb 2019 so you can have that time period where all of the shoes are on the market, and then add that extra variable of days since IPO
    #choose any one day from dec 20 2018 to feb 2 2019 that has the most sales of each shoe

#binary regressor information
    #col 1 = price, col 2 = make, col 3 = size, col 4 = stripe, col 5 = time since release
    #turn stripe and color into a binary regressor of just 0 and 1. 0 for black 1 for white, then you can run a regression on it.
    #dependent var is shoe price, independent vars are days since initial drop, shoe size, and the binary regressor (light/dark-stripe ----> name (7 different 0s and 1s))
    #interpretation is how much higher on average the price of this shoe is relative to the base case. (base case is the Yeezy 350 v2 Beluga, which is a dark and striped model)


#Extra information

    #dummy variables act as like a switch for your model, where you can pick and choose different cases without having to run separate models
        #usually for example, if you wanted to look at houses that were built before 1900, you would do 0 for after 1900 and 1 for before 1900
        #then there would be another category where it would be 1 for east side of city and 0 for west side. And it works as a combo of 0s and 1s

    #base case is just the 0 of the dummy variable, the control group, the one where you expect nothing to happen. and the 1s are where you expect 
        #something to change depending on the variables included. 

    #remove beluga because beluga is the base case. Interact IPO with each one of the binary regressors

    #in interpreting coefficients, price in dollars on average (x dollars) higher or lower than the base case of beluga





#begin exploratory analysis

    #first import the dataset

shoesURL <- 'https://raw.githubusercontent.com/nstutelberg/Projects/main/sneaker_data.csv'

shoes <- read_csv(url(shoesURL),
                  col_types = cols(`Order Date` = col_date(format = "%m/%d/%Y"), 
                                   `Sale Price` = col_number(), `Retail Price` = col_number(), 
                                   `Release Date` = col_date(format = "%m/%d/%Y")))

    #take out sizes greater than 14 since there are so few observations with this criteria, and the prices are inconsistent
shoes <- shoes %>%
  filter(`Shoe Size` < 14)




    #example regression for interpretation reference. Predictor = Shoe Size | Response = Price
summary(lm(`Sale Price` ~ `Shoe Size`, data = shoes))

            #Residuals are the differences between observed response values (price) and the response values that the model predicted (shoe size)
                  #Looking for symmetrical distribution, and since our data is not symmetrical, the model is predicting points that land far away from the actual observed points.
                  #Can see in the large disparity between the quartile ranges and the min/max that the datset is not very symmetric.
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
shoes  %>% group_by(`Sneaker Name`) %>% dplyr::mutate(N=n()) %>% tally(sort = TRUE)
            #Select top 10 most commonly sold shoes so we can get a large enough sample size. Exclude other brands besides Yeezys


Butter <- shoes %>%
  filter(grepl(pattern = ".*Butter", shoes$`Sneaker Name`))
Frozen <- shoes %>%
  filter(grepl(pattern = ".*Frozen.*", shoes$`Sneaker Name`))
Beluga <- shoes %>%
  filter(grepl(pattern = ".*Beluga-2pt0$", shoes$`Sneaker Name`))
Zebra <- shoes %>%
  filter(grepl(pattern = ".*Zebra$", shoes$`Sneaker Name`))
Bluetint <- shoes %>%
  filter(grepl(pattern = ".*Blue-Tint$", shoes$`Sneaker Name`))
Cream <- shoes %>%
  filter(grepl(pattern = ".*Cream-White$", shoes$`Sneaker Name`))
Sesame <- shoes %>%
  filter(grepl(pattern = ".*Sesame$", shoes$`Sneaker Name`))
StaticNonRef <- shoes %>%
  filter(grepl(pattern = ".*Static$", shoes$`Sneaker Name`))
StaticRef <- shoes %>%
  filter(grepl(pattern = ".*Static-Reflective$", shoes$`Sneaker Name`))


    #now have a few sneakers in separate dataframes to test the statistical methods. Graphing template below for using ggplot to plot a regression line
            #testing zebra and butter 


ButterPlot <- ggplot(Butter, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
  geom_point() + geom_smooth(method = "lm") +
  ggtitle("Yeezy Butter Sale Price over time") +
  labs(x = "Date", y = "Sale Price") +
  theme_economist_white()

FrozenPlot <- ggplot(Frozen, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
  geom_point() + geom_smooth(method = lm) +
  ggtitle("Yeezy Frozen Sale Price over time") +
  labs(x = "Date", y = "Sale Price") +
  theme_economist_white()


    #also tested some log models. Logging works when the data is covering a large range and when we are more concerned with percentage change in price rather than the numerical change
            #notice how zebra had more variation in the price data so logging the dependent variable made the graph easier to read. However, for Butter, the log transformation would not be as needed.
ButterPlotLog <- ggplot(Butter, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
  geom_point() + geom_smooth(method = lm) +
  ggtitle("Yeezy Butter Log Sale Price over time") +
  labs(x = "Date", y = "Sale Price") +
  scale_y_log10() +
  scale_x_date(date_breaks = "2 months", date_labels = "%b-%y") +
  theme_economist_white()

FrozenPlotLog <- ggplot(Frozen, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
  geom_point() + geom_smooth(method = lm) +
  ggtitle("Yeezy Frozen Log Sale Price over time") +
  labs(x = "Date", y = "Sale Price") +
  scale_y_log10() +
  scale_x_date(date_breaks = "2 months", date_labels = "%b-%y") +
  theme_economist_white()

ggarrange(ButterPlot, FrozenPlot, ButterPlotLog, FrozenPlotLog)



    #Now to run regressions on the sale price and shoe size for various models. General format below
            # myregression <- lm(`Response Variable` ~ `Predictor Variable`, df)
            #In both of these regressions, there is an extremely low Rsquared, but the effect of shoe size on price is still highly statistically significant

summary(lm(`Sale Price` ~ `Shoe Size`, Butter))

summary(lm(`Sale Price` ~ `Shoe Size`, Frozen))


    #multivariable regression example taking order date and shoe size as the independent variables
            #Notice the significantly higher Rsquared. Make note of the importance of order date on price

summary(lm(`Sale Price` ~ `Order Date` + `Shoe Size`, Butter))


#end exploratory analysis






    #Creation of the main dataframe to analyze

shoessubset <- c("adidas-Yeezy-Boost-350-V2-Butter", "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Blue-Tint", "Adidas-Yeezy-Boost-350-V2-Cream-White", "Adidas-Yeezy-Boost-350-V2-Sesame", "adidas-Yeezy-Boost-350-V2-Static", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", "adidas-Yeezy-Boost-350-V2-Static-Reflective")

shoestotal <- shoes %>%
  filter(`Sneaker Name` %in% shoessubset)


    #now add if its a light or dark color, and stripe vs no stripe. 

DarkYeezys <- c("Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "adidas-Yeezy-Boost-350-V2-Static", "adidas-Yeezy-Boost-350-V2-Static-Reflective", "Adidas-Yeezy-Boost-350-V2-Sesame")
LightYeezys <- c("adidas-Yeezy-Boost-350-V2-Butter", "Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Blue-Tint", "Adidas-Yeezy-Boost-350-V2-Cream-White", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow")
shoestotal <- shoestotal %>%
  mutate("Light_Dark" = if_else(shoestotal$`Sneaker Name` %in% DarkYeezys, "Dark", "Light"))

StripeYeezys <- c("Adidas-Yeezy-Boost-350-V2-Zebra", "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", "Adidas-Yeezy-Boost-350-V2-Blue-Tint")
SolidYeezys <- c("adidas-Yeezy-Boost-350-V2-Butter", "adidas-Yeezy-Boost-350-V2-Static", "adidas-Yeezy-Boost-350-V2-Static-Reflective", "Adidas-Yeezy-Boost-350-V2-Sesame", "Adidas-Yeezy-Boost-350-V2-Cream-White")

shoestotal <- shoestotal %>%
  mutate("Solid_Stripe" = if_else(shoestotal$`Sneaker Name` %in% StripeYeezys, "Stripe", "Solid"))


    #only select 2019-02-06 since that was when most pairs were sold

shoestotal <- shoestotal %>%
  filter(`Order Date` == "2019-02-06")

    #datediff function to get a numeric value for days since IPO

shoestotal <- shoestotal %>%
mutate("Days_Since_IPO" = (difftime(shoestotal$`Order Date`, shoestotal$`Release Date`, units = c("days"))))





    #Making a binary column for each model of Yeezy. Beluga will be excluded in the next script since it is acting as the base case, but the script is here if we want to use another model as the base case in the future.

shoestotal <- shoestotal %>%
  select(everything()) %>%
  mutate("Beluga" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Beluga-2pt0", 1, 0)) %>%
  mutate("Blue_Tint" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Blue-Tint", 1, 0)) %>%
  mutate("Butter" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Butter", 1, 0)) %>%
  mutate("Cream_White" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Cream-White", 1, 0)) %>%
  mutate("Frozen_Yellow" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Semi-Frozen-Yellow", 1, 0)) %>%
  mutate("Sesame" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Sesame", 1, 0)) %>%
  mutate("Static" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Static", 1, 0)) %>%
  mutate("Static_Reflective" = if_else(`Sneaker Name` == "adidas-Yeezy-Boost-350-V2-Static-Reflective", 1, 0)) %>%
  mutate("Zebra" = if_else(`Sneaker Name` == "Adidas-Yeezy-Boost-350-V2-Zebra", 1, 0))


    #taking out Beluga because the Beluga model is acting as our base case. We are using Beluga as the default model for a shoe and comparing all other models to the Beluga model
shoestotal <- shoestotal %>%
  select(-Beluga)



    #regressions

           #regression with all models and their binary columns included
summary(lm(`Sale Price` ~  `Shoe Size` + `Days_Since_IPO` + `Blue_Tint` + `Butter` + `Cream_White` + `Frozen_Yellow` + `Sesame` + `Static` + `Static_Reflective` + `Zebra`, data = shoestotal))
           #results - High Rsquared at 92.1%, but there are so many independent variables here that the Rsquared is naturally going to be higher
                #hard to determine which variables are accounting for the most variation in the independent variable. Need to scale the model down

            #regression with just the shoe colors to compare to base case of Beluga 
summary(lm(`Sale Price` ~ Blue_Tint + Butter + Cream_White + Frozen_Yellow + Sesame + Static + Static_Reflective+ Zebra, data = shoestotal))
      
           #regression with the categorical columns. Stripe and Light_Dark only have two options so they are acting as binary regressors in this case
summary(lm(`Sale Price` ~ `Shoe Size` + `Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))
                #results - 29.17% Rsquared, but also using less variables. Stripe and Light_Dark having the most impact on the price here



    #Regression equations in statistical format
            #B0 + B1ShoeSize + B2DaysSinceIPO + B3Beluga + B4BlueTint + B5Butter + B6CreamWhite + B7FrozenYellow + B8Sesame + B9Static + B10StaticReflective + B11Zebra
            #B0 + B1ShoeSize + B2DaysSinceIPO + B3Stripe + B4Light_Dark



    #Converting categorical variables into quantitative variables. Using 1's and 0's to compare the regression results to the base case. 
            #The base case in the limited regression model would have a solid, light colored yeezy being the sneaker model that will be used to compare other colors and patterns to
shoestotal <- shoestotal %>%
  mutate(`Light_Dark` = if_else(`Light_Dark` == "Light", 0, 1))

shoestotal <- shoestotal %>%
  mutate(Solid_Stripe = if_else(`Solid_Stripe` == "Solid", 0, 1))


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
  mutate(`Interaction_Color_Stripe` = `Light_Dark` * `Solid_Stripe`)
            #Creating an interaction variable to account for stripe and light/dark. Use this interaction to account for the color and pattern differences in the sneakers without having separate independent variables for each color



    #AIC calculation to evaluate how well the model is fitting the data. Comparing various combinations of dependent variables to see which has the best fit
            #Trying to find the variables that explain the greatest amount of variation using the fewest independent variables as possibl
            #smaller the better

    #All variables
AIC1 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal)  

    #no shoe size
AIC2 <- lm(`Log_Sale_Price` ~ `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal)

    #no shoe squared
AIC3 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal) 

    #no log ipo
AIC4 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Interaction_Color_Stripe`, data = shoestotal)

    #no interaction
AIC5 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO`, data = shoestotal)

models <- list(AIC1, AIC2, AIC3, AIC4, AIC5)
aictab(cand.set = models, modnames = c('All Variables', 'No Shoe Size', 'No Shoe Size Squared', 'No Log Days Since IPO', 'No Color Stripe Interaction'))


    #Break out Interaction to test if these variables are a better fit
AIC6 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Log_Days_Since_IPO` + `Light_Dark` +`Solid_Stripe`, data = shoestotal)
AIC7 <- lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Light_Dark` +`Solid_Stripe`, data = shoestotal)
AIC8 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Light_Dark` +`Solid_Stripe`, data = shoestotal)
AIC9 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Log_Days_Since_IPO` + `Solid_Stripe`, data = shoestotal)
AIC10 <- lm(`Log_Sale_Price` ~ `Shoe Size` + `Log_Days_Since_IPO` + `Light_Dark`, data = shoestotal)

modelsfinal <- list(AIC6, AIC7, AIC8, AIC9, AIC10)
aictab(cand.set = modelsfinal, modnames = c('All Variables', 'No Shoe Size', 'No Log Days Since IPO', 'No Light_Dark', 'No Solid_Stripe'))

      #results - Days Since IPO and the characteristics of the sneaker (Light_Dark, Stripe) appear to be the most influential independent variables in the model, with days since IPO being the most influential
                #Taking out shoe size/shoe size squared has little impact on the AIC calculation, so in our final regression we will remove this variable.



    #Base model vs restricted model 
    #base regression
summary(lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark` + `Interaction_Color_Stripe`, data = shoestotal))
    #restricted model
summary(lm(`Log_Sale_Price` ~  `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal))



    #testing if the interaction between solid and stripe is a good fit for our model

    #no interaction
summary(lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))
    #with interaction
summary(lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal))
    
    #summary - lose out on some Rsquared when using interaction, and harder to interpret. Final model should use Stripe and Light_Dark so you can see the impact on each of these characteristics more clearly






                                                  #Final results + regression (logged and unlogged)

summary(lm(`Sale Price` ~ `Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))
summary(lm(`Log_Sale_Price` ~ `Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))
summary(lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))

    #effect of just days since IPO
    summary(lm(`Sale Price` ~ `Days_Since_IPO`, data = shoestotal))


    #Plotting bivariate regression models to see the relationships. Note that the slope line in Light_Dark and Solid_Stripe should not be interpreted. Instead, look at the start and end points
FinalPlot1 <- ggplot(shoestotal, aes(x = `Log_Days_Since_IPO`, y = `Log_Sale_Price`)) +
  geom_point() + geom_smooth(method = lm) +
  ggtitle("Prices of Yeezys from IPO date (Log Model)") +
  theme_economist_white()

FinalPlot2 <- ggplot(shoestotal, aes(x = `Days_Since_IPO`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = lm) +
  ggtitle("Prices of Yeezys from IPO date") +
  theme_economist_white()


FinalPlot3 <- ggplot(shoestotal, aes(x = `Light_Dark`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = lm) +
  ggtitle("Prices of Light vs Dark Colored Yeezys") +
  labs(subtitle = "Left = Light  |  Right = Dark") +
  theme_economist_white()

FinalPlot4 <- ggplot(shoestotal, aes(x = `Solid_Stripe`, y = `Sale Price`)) +
  geom_point() + geom_smooth(method = lm) +
  ggtitle("Prices of Solid vs Stripe Patterned Yeezys") +
  labs(subtitle = "Left = Solid  |  Right = Stripe") +
  theme_economist_white()

ggarrange(FinalPlot1, FinalPlot2, FinalPlot3, FinalPlot4)


    #Wald test to determine if the variables selected are the best fit for the model


model <- lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Shoe Size` + `Solid_Stripe` + `Light_Dark`, data = shoestotal)
wald.test(Sigma = vcov(model), b = coef(model), Terms = 1)
wald.test(Sigma = vcov(model), b = coef(model), Terms = 2)
wald.test(Sigma = vcov(model), b = coef(model), Terms = 3)
wald.test(Sigma = vcov(model), b = coef(model), Terms = 4)
wald.test(Sigma = vcov(model), b = coef(model), Terms = 5)

modelfinal <- lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal)
wald.test(Sigma = vcov(modelfinal), b = coef(modelfinal), Terms = 1)
wald.test(Sigma = vcov(modelfinal), b = coef(modelfinal), Terms = 2)
wald.test(Sigma = vcov(modelfinal), b = coef(modelfinal), Terms = 3)
wald.test(Sigma = vcov(modelfinal), b = coef(modelfinal), Terms = 4)
    #included shoe size even though it is not in the final model to show the purpose of the wald test. Shoe Size was the only independent variable that did not have a p value <0.10, so it should be removed



#results - not very high Rsquared for any of these models, but when using just a few variables, you can see the affect of these few independent variables in accounting for variability in the sneaker prices
      #Can see that shoe size, whether squared or not, is not a good predictor of resale price. This is likely because both small and large sizes sell for the most money.

