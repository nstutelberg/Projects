# Project Introduction

This project explores that determinants of the price of luxury sneakers. The sneaker resale market was valued at $2 billion in 2019 according to studies done by Statista and Cowen. The most popular sneakers to resell are Adidas and Nikes, with Jordans and Yeezys being some of the most popular sneaker models on the market. My analysis only focuses on Yeezy 350 v2's so I can control for differences in the sneakers and focus on my chosen independent variables. This project is a cross-sectional analysis of 9 different models of Yeezys, and I sought out the most influential factors behind an increase or decrease in the price of a sneaker in the after-market.

In my cross-sectional analysis, the statistical analysis methods I use are:
  
  -Linear Regression
    
  -Multivariate Regression
    
  -AIC (Akaike information criterion)
    
  -Binary Regressors
    
  -Interaction effects
    
  -Wald Test
    
# Hypotheses
   1) Average disposable income per capita is positively related to the average selling price of yeezys. (TABLEAU MEAN OF SELL PRICE AND INCOME)
   
   2) Solid color yeezys appreciate faster than multicolored yeezys or striped yeezys (TABLEAU GROUP COLORS AND TAKE AVERAGE OR PLOT TWO LINES IN R)
    
   3) Higher shoe size correlates to higher resale price (REGRESSION IN R)
    
   4) Later order date (more recent) correlates to higher resale price. (REGRESSION IN R)

# Notes 
   Fix a day and find the day that has the greatest variation in the cross section, a day where you have the most models being sold
    Looking for greatest degree of variation fixing the time period, CROSS SECTIONAL ANALYSIS. fix time period of sale
    An option would be to only include common sizes so you have more observations that are more consistent
    With plotting the regression lines, In order to see the relationship for each variable, there is a separate ggplot graph for each variable. Note that the binary             dependent 
    Variables won't have a meaningful regression line because they are discrete values rather than continuous. However, we can still see the difference in the mean
          of each category by using a plot

# Proposed Plan
   Find greatest number of observations on a given day, fix time, find sale date that gives largest # of observations of each make
    Find a day with greatest number of observations for each specific shoe, regress price on shoe size and quantity of shoes that was released (probably not available)

# Findings
   Analysis resulted in the linear regression model found below. I limited the independent variables used in the final model to 3, since with more variables, the less impact each independent variable has, and the more likely it is that I would run into a multicollinearity problem, with two independent variables being highly correlated to each other

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

# Continued Analysis
   ### Benefits and drawbacks of log transformations
        As shown in this plot below
        
        
        
        
        
        
## Tech/framework used
Ex. -

<b>Built with</b>
- [Electron](https://electron.atom.io)

## Features
What makes your project stand out?

## Code Example
Show what the library does as concisely as possible, developers should be able to figure out **how** your project solves their problem by looking at the code example. Make sure the API you are showing off is obvious, and that your code is short and concise.

## Installation
Provide step by step series of examples and explanations about how to get a development env running.

## API Reference

Depending on the size of the project, if it is small and simple enough the reference docs can be added to the README. For medium size to larger projects it is important to at least provide a link to where the API reference docs live.

## Tests
Describe and show how to run the tests with code examples.

## How to use?
If people like your project they’ll want to learn how they can use it. To do so include step by step guide to use your project.

## Contribute

Let people know how they can contribute into your project. A [contributing guideline](https://github.com/zulip/zulip-electron/blob/master/CONTRIBUTING.md) will be a big plus.

## Credits
Give proper credits. This could be a link to any repo which inspired you to build this project, any blogposts or links to people who contrbuted in this project. 

#### Anything else that seems useful

## Links
Statista study: https://www.statista.com/statistics/1202148/sneaker-resale-market-value-us-and-global/
Cowen Research Equity study: https://www.cowen.com/insights/sneakers-as-an-alternative-asset-class-part-ii/

MIT © [Yourname]()