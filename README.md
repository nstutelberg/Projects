# Project Introduction

This project explores the determinants of the price of luxury sneakers. The sneaker resale market was valued at $2 billion in 2019 according to studies done by Statista and Cowen [(Link)](#Links). The most popular sneakers to resell are Adidas and Nikes, with Jordans and Yeezys being some of the most popular sneaker models on the market. 

With me being involved in the sneaker reselling market, I wanted to determine what the key factors were for whether a shoe would appreciate or depreciate over time.
My analysis only focuses on Yeezy 350 v2's so I can control for brand preference and personal taste when it came to a sneakers' silhouette. This project is a cross-sectional analysis of 9 different models of Yeezys, and I sought out the most influential factors behind an increase or decrease in the price of a sneaker in the after-market. The data is pulled directly from https://www.stockx.com, one of the primary sneaker reselling websites for after-market sneakers.

**In my cross-sectional analysis, the statistical analysis methods I used were:**
  
  -Linear Regression
    
  -Multivariate Regression
    
  -AIC (Akaike Information Criterion)
    
  -Binary Regressors / Dummy Variables
    
  -Interaction Effects
    
  -Wald Test
    
# Hypotheses
   1) Solid color Yeezys appreciate faster than striped Yeezys
   
         H₀: A solid colored Yeezy will not have a higher sale price over time in relation to a patterned Yeezy
      
         H₁: A solid colored Yeezy will have a higher sale price over time in relation to a patterned Yeezy
         
         
    
   2) Dark color yeezys appreciate faster than light color yeezys
   
         H₀: A dark colored Yeezy will not have a higher sale price over time in relation to a light colored Yeezy
      
        H₁: A dark colored Yeezy will have a higher sale price over time in relation to a light colored Yeezy
        
        
      
   3) Larger shoe size correlates to higher resale price
   
        H₀: There is no relationship or a negative relationship between the size of a Yeezy and its sale price
      
        H₁: There is a positive relationship between the size of a Yeezy and its sale price
        
        
      
   4) A later order date (more recent date) correlates to higher resale price
   
        H₀: There is no relationship or a negative relationship between the order date of a Yeezy and its sale price
      
        H₁: There is a positive relationship between the order date of a Yeezy and its sale price
        

# Notes 
   To prepare the data, I fixed a day and found the day that has the greatest variation in the cross section. This would be a day where there is the most models being sold. 
   
# Dummy Variable Notes  
   In the R code, I ran a few analyses using dummy variables in order to see which models appreciated faster than others. These analyses are not tied to the final product, but the method is there if I wanted to compare models. To set up the dummy variables, I made a column for each sneaker model, and filled the columns with alternating 1s and 0s so I can toggle on and off certain models for a regression analysis. 
   
   For this method, I treated the Beluga-2pt0 as the base case model, and compared all other sneaker models to the Beluga. This analysis was mostly exploratory, but I found that the only sneaker that had a positive coefficient was the Yeezy 350 v2 Static Reflective. It is the only sneaker to appreciate in value over time, and this is further shown through a bivariate regression with sale price. Results shown below
   
    summary(lm(`Sale Price` ~ Blue_Tint + Butter + Cream_White + Frozen_Yellow + Sesame + Static + Static_Reflective+ Zebra, data = shoestotal))
    summary(lm(`Sale Price` ~ Static_Reflective, data = shoestotal))
   


# Proposed Plan
   Find greatest number of observations on a given day, fix time, find sale date that gives largest # of observations of each make
    Find a day with greatest number of observations for each specific shoe, regress price on shoe size and quantity of shoes that was released (probably not available)

# Findings
   Analysis resulted in the linear regression model found below. I limited the independent variables used in the final model to 3, since with more variables, the less impact each independent variable has, and the more likely it is that I would run into a multicollinearity problem, with two independent variables being highly correlated to each other
   
    summary(lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))


# Regression Model Analysis
  -Residuals are the differences between observed response values (price) and the response values that the model predicted (shoe size)
       Looking for symmetrical distribution, and since our data is not symmetrical, the model is predicting points that land far away from the actual observed points.
       Can see in the large disparity between the quartile ranges and the min/max that the datset is not very symmetric.
       
  -Intercept coefficient of 361.21 is the expected value when considering average shoe size of all shoes in dataset. (avg price is 361.21) (statistically significant    to 99%+ level)
       
  -Standard error of 0.36 is showing average amount that coefficient estimates vary from the avg price (regression line) 
       My standard error is smaller than the coefficient. Say that if we ran the model again, the price should vary by $0.36 in relation to the avg price
            
  -P value of <2e-16 is the probability of observing a value larger than t (25.28).This value is small enough where the relationship between price and shoe size is unlikely due to chance. 
   
  -Shoe Size coefficient of 9.17 shows inverse relationship between price and shoe size. (99% confidence level).
       For every 1 unit increase in shoe size -> 9.17 unit increase in price

  -Residual standard error of 254.5 is measuring the quality of the regression fit. It's the avg amount that the price will deviate from regression line (97,866 df)
       Given the mean price is $361.21 and the residual standard error is 254.5, the percentage error (the % any prediction would still be off by) is 70.46%

  -R Squared of 0.0065 shows that our predictor variable (shoe size) isn't accounting for much of the total variance (Only .65%)

  -F statistic of 638.9 is indicating whether there is a relationship between price and shoe size. F statistic is significantly larger than 1 so we can infer a relationship
        

   **Interaction of Variables**
    Interaction did not work well in the model. I wanted to test whether the relationship between price and days since the sneaker IPO'd was different depending on the color of the sneaker or the pattern of the sneaker. The hypothesis was that the color/pattern would either lead to less price depreciation over time or cause the price to fall faster. 

   **Wald test** - Used as a way to find out if explanatory variables in the model were significant.
    
   Wald test revealed that the variables chosen for the final regression model are good fits for the model, and confirmed that Shoe Size is a poor predictor of the price of the sneaker. Through running the wald test for each of the variables in the final regression, I found that the p-value was less than 0.05 in all cases excluding the Shoe Size test case. Including statistically significant predictors should lead to better prediction and better model fit, so this test led me to believe that the variables in my model are the best considering the data.
    
[![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/feross/standard)

# Interpretation
     Residuals - Possible that since the median is deeply negative that the data is skewed left,
# Screenshots
Include logo/demo screenshot etc.

   For the ggplots for the binary regressors, the regression line will not be meaningful because these variables contain discrete values rather than continuous. However, the graphs are still beneficial in order to see the difference in the mean price of the two cases (1vs0).
   
   
# Continued Analysis
   ### Benefits and drawbacks of log transformations
        As shown in this plot below
        
        
        

## Features
What makes your project stand out?

## Code Example
Show what the library does as concisely as possible, developers should be able to figure out **how** your project solves their problem by looking at the code example. Make sure the API you are showing off is obvious, and that your code is short and concise.

## Installation
   To run code, an updated version of R and RStudio is needed. Link is here: https://cran.r-project.org/

#### Anything else that seems useful

## Links
Statista study: https://www.statista.com/statistics/1202148/sneaker-resale-market-value-us-and-global/
Cowen Research Equity study: https://www.cowen.com/insights/sneakers-as-an-alternative-asset-class-part-ii/
