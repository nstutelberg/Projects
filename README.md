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
  
  -Log Transformation
    
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
        

# Proposed Plan
   To prepare the data, fix the day and get the day that has the greatest variation in the cross section. This would be a day where there is the most models being sold. Add a column for each sneaker to act as a dummy variable. Run both bivariate and multivariate regressions and perform tests on the model fit. Plot results to vizualise the regression line and look for heteroscedasticity and the amount of variance in the prices over time. This influences whether log transformations are needed to normalize the data. 
   
   
# Findings
   Analysis resulted in the linear regression model found below. I limited the independent variables used in the final model to 3. With more variables, the less impact each independent variable has, and the more likely it is that I would run into a multicollinearity problem, with two independent variables being highly correlated to each other
   
     summary(lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))
     
   **Interaction of Variables** -
    Interaction did not work well in the model. I wanted to test whether the relationship between price and days since the sneaker IPO'd was different depending on the color of the sneaker or the pattern of the sneaker. The hypothesis was that the color/pattern would either lead to less price depreciation over time or cause the price to fall faster. 

   **Wald test**  -
   Wald test revealed that the variables chosen for the final regression model are good fits for the model, and confirmed that Shoe Size is a poor predictor of the price of the sneaker. Through running the wald test for each of the variables in the final regression, I found that the p-value was less than 0.05 in all cases excluding the Shoe Size test case. Including statistically significant predictors should lead to better prediction and better model fit, so this test led me to believe that the variables in my model are the best considering the data.
   
   **AIC** -
   Looking into the AIC confirmed that the variables 
   
   **Log Transformation** -
   Took the natural log of both Sale Price and Days Since IPO. For Sale Price, there are sneakers that resold for $1,000+ before their mass release, and then went down to $250 months later, so the log is used here to more easily view the distribution when there is this much variability in the price. Took the natural log of Days Since IPO since the difference in the first 10-20 days since IPO are significant for the change in price, but once the days are in the hundreds, each additional day is less impactful. Use log to capture this assumption on diminishing returns.
   
   
 
# Regression Model
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
 
# Summary
  The model used includes only statistically significant independent variables, with p-values for the binary regressors easily meeting a 99% confidence level, and Days Since IPO meeting a 95% confidence level. 
  
  
  There is a positive relationship between Solid_Stripe and Sale Price, meaning that solid color Yeezys are garnering higher resale prices than striped Yeezys. Reject Null in favor of Alternative for Hypothesis #1.
  
  There is a positive relationship between Light_Dark and Sale Price, meaing that dark color Yeezys are garnering higher resale prices than light colored Yeezys.
  
  There is a negative relationship between Days Since IPO and Sale Price, meaning over time, as the shoe moves away from it's IPO date, the resell price of the sneaker in the after-market decreases. Fail to reject Null for Hypothesis #4. 
  
  



# Future Analysis
   Due to the model Rsquared being ~ 0.30 depending on if we use log transformation or not, there is still a significant amount of variation in the dependent variable that is not accounted for. 
   
   In future research, these are a few ideas I would pursue:
   
   -Through my experience in the market, I would argue that the number of similar Yeezys compared to the initial model would have an inverse relationship with price. The more similar colorways are released, the less demand there is for the original since some customers see the new model as being comparable to the original and buy the new model instead. This would act as an increase in supply, lowering the price of the original. I w
          -To get this data, I would take a few Yeezy models and create a dummy variable for either 'Similar' or 'Dissimilar'. There would be some subjective calls on whether a new model is similar to the orginal, but I would mostly use characteristics such as color and pattern as I did in my first analysis.
          
   -I would also try to quantify the "hype" around the brand, since the sneaker reselling community often takes heightened interest in certain models for a time, and moves on when the model is either overdone or a new model comes in that attracts the attention of the community. I could use Google Trends as a proxy for interest in the brand, and I would search for the terms "Yeezy" and "Adidas" to see if there is an upward or downward trend in the number of searches related to these keywords. I could use the Google Trends data and tie it in with the shoe price to see if the more these words are searched, the more the sale price on a after-market site increases. 
          -I could also look at the r/Sneakers subreddit where there are 3.1M followers, and record the amount of posts related to Yeezys show up in the feed and the number of upvotes for each post. The subreddit is a place for enthusiasts to show off their sneakers, and sneakers with the most "hype" and excitement around them garner more upvotes. Granted this is a subset of the sneaker community where the opinions may not represent the entire community, so the results would have to be taken with a grain of salt. 
   
      summary(lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark` + `Hype_Level` + `Post_Engagement`, data = shoestotal))



# Dummy Variable Notes  
   In the R code, I ran a few analyses using dummy variables in order to see which models appreciated faster than others. These analyses are not tied to the final product, but the method is there if I wanted to compare sneaker models. To set up the dummy variables, I made a column for each sneaker model, and filled the columns with alternating 1s and 0s so I can toggle on and off certain models for a regression analysis. 
   
   For this method, I treated the Beluga-2pt0 as the base case model, and compared all other sneaker models to the Beluga. This analysis was mostly exploratory, but I found that the only sneaker that had a positive coefficient was the Yeezy 350 v2 Static Reflective. It is the only sneaker to appreciate in value over time, and this is further shown through a bivariate regression with sale price. Results shown below
   
    summary(lm(`Sale Price` ~ Blue_Tint + Butter + Cream_White + Frozen_Yellow + Sesame + Static + Static_Reflective+ Zebra, data = shoestotal))
    summary(lm(`Sale Price` ~ Static_Reflective, data = shoestotal))
    
    summary(lm(`Sale Price` ~ `Shoe Size` + `Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))
  
     
# Screenshots

    ButterPlot <- ggplot(Butter, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
        geom_point() + geom_smooth(method = "lm") +
        ggtitle("Sale Prices for Yeezy 350 v2 Butter") +
        labs(x = "Date", y = "Sale Price") +
        theme_economist_white()

    FrozenPlot <- ggplot(Frozen, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
        geom_point() + geom_smooth(method = lm) +
        ggtitle("Sale Prices for Yeezy 350 v2 Frozen") +
        labs(x = "Date", y = "Sale Price") +
        theme_economist_white()
      
      
    ButterPlotLog <- ggplot(Butter, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
        geom_point() + geom_smooth(method = lm) +
        ggtitle("Sale Prices for Yeezy 350 v2 Butter") +
        labs(x = "Date", y = "Sale Price") +
        scale_y_log10() +
        scale_x_date(date_breaks = "2 months", date_labels = "%b-%y") +
        theme_economist_white()

    FrozenPlotLog <- ggplot(Frozen, aes(x = `Order Date`, y = `Sale Price`, color = `Shoe Size`)) +
         geom_point() + geom_smooth(method = lm) +
         ggtitle("Sale Prices for Yeezy 350 v2 Frozen") +
         labs(x = "Date", y = "Sale Price") +
         scale_y_log10() +
         scale_x_date(date_breaks = "2 months", date_labels = "%b-%y") +
         theme_economist_white()

      ggarrange(ButterPlot, ButterPlotLog, FrozenPlot, FrozenPlotLog)

   For the ggplots for the binary regressors, the regression line will not be meaningful because these variables contain discrete values rather than continuous. However, the graphs are still beneficial in order to see the difference in the mean price of the two cases (1vs0).
   
   
# Continued Analysis
   ### Benefits and drawbacks of log transformations
        As shown in this plot below
        

## Installation
   To run code, an updated version of R and RStudio is needed. Link is here: https://cran.r-project.org/

#### Anything else that seems useful

## Links
Statista study: https://www.statista.com/statistics/1202148/sneaker-resale-market-value-us-and-global/
Cowen Research Equity study: https://www.cowen.com/insights/sneakers-as-an-alternative-asset-class-part-ii/
