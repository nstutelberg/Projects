 Projects

hypotheses


notes


proposed plan
    #find greatest number of observations on a given day, fix time, find sale date that gives largest # of observations of each make
    #find a day with greatest number of observations for each specific shoe, regress price on shoe size and quantity of shoes that was released (probably not available)


With plotting the regression lines, In order to see the relationship for each variable, there is a separate ggplot graph for each variable. Note that the binary dependent 
      variables won't have a meaningful regression line because they are discrete values rather than continuous. However, we can still see the difference in the mean
      of each category by using a plot
      
## Project Introduction

This project explores that determinants of the price of luxury sneakers. The sneaker resale market was valued at $2 billion in 2019 according to studies done by Statista and Cowen. The most popular sneakers to resell are Adidas and Nikes, with Jordans and Yeezys being some of the most popular sneaker models on the market.

In my analysis, the statistical analysis methods I use are:
    Linear Regression
    Multivariate Regression
    AIC (Akaike information criterion)
    Binary Regressors
    Interaction effects
    
## Hypotheses
    1) Average disposable income per capita is positively related to the average selling price of yeezys. (TABLEAU MEAN OF SELL PRICE AND INCOME)
    2) Solid color yeezys appreciate faster than multicolored yeezys or striped yeezys (TABLEAU GROUP COLORS AND TAKE AVERAGE OR PLOT TWO LINES IN R)
    3) Higher shoe size correlates to higher resale price (REGRESSION IN R)
    4) Later order date (more recent) correlates to higher resale price. (REGRESSION IN R)

## Notes 
    Fix a day and find the day that has the greatest variation in the cross section, a day where you have the most models being sold
    Looking for greatest degree of variation fixing the time period, CROSS SECTIONAL ANALYSIS. fix time period of sale
    An option would be to only include common sizes so you have more observations that are more consistent

## Proposed Plan
    Find greatest number of observations on a given day, fix time, find sale date that gives largest # of observations of each make
    Find a day with greatest number of observations for each specific shoe, regress price on shoe size and quantity of shoes that was released (probably not available)

## Code style
If you're using any code style like xo, standard etc. That will help others while contributing to your project. Ex. -

[![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/feross/standard)
 
## Screenshots
Include logo/demo screenshot etc.

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
