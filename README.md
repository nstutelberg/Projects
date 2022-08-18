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
   Analysis resulted in the linear regression model found below. I limited the independent variables used in the final model to 3. With more variables, the less impact each independent variable has, and the more likely it is that I would run into a multicollinearity problem. 
  
**Variable definitions:**
  
  
  
   Sale Price - Price that a sneaker sold for on StockX (after-market resell website).
  
   Days Since IPO - Amount of days that have passed since the initial release of the sneaker.
  
   Solid Stripe - Binary regressor with 0 being a solid colored Yeezy (no stripes / one solid color) and 1 being a striped Yeezy (stripes wrapping around entire sneaker).
  
   Light Dark - Binary regressor with 0 being a light colored Yeezy (white, yellow, light blue) and 1 being a dark colored yeezy (gray, black, dark brown).
  
   
     summary(lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark`, data = shoestotal))
     
     Call:
    lm(formula = Log_Sale_Price ~ Log_Days_Since_IPO + Solid_Stripe + 
    Light_Dark, data = shoestotal)

    Residuals:
     Min       1Q   Median       3Q      Max 
    -0.47714 -0.21684  0.02909  0.19323  0.42467 

    Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
    (Intercept)         5.89969    0.15777  37.395  < 2e-16 ***
    Log_Days_Since_IPO -0.06099    0.02696  -2.262   0.0241 *  
    Solid_Stripe        0.24002    0.03804   6.310 5.84e-10 ***
    Light_Dark          0.30882    0.06023   5.127 4.12e-07 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

    Residual standard error: 0.2146 on 536 degrees of freedom
    Multiple R-squared:  0.3245,	Adjusted R-squared:  0.3207 
    F-statistic: 85.82 on 3 and 536 DF,  p-value: < 2.2e-16

     
   **Interaction of Variables** -
    Interaction did not work well in the model. I wanted to test whether the relationship between price and days since the sneaker IPO'd was different depending on the color of the sneaker or the pattern of the sneaker. The hypothesis was that the color/pattern would either lead to less price depreciation over time or cause the price to fall faster. 

   **AIC** -
   Looking into the AIC confirmed which variables are the best for model fit. AIC calculation to evaluate how well the model is fitting the data. Comparing various combinations of dependent variables to see which has the best fit. Trying to find the variables that explain the greatest amount of variation using the fewest independent variables as possible. smaller the better
   
        Initial Model: lm(`Log_Sale_Price` ~ `Shoe Size` + `Shoe_Size_Squared` + `Log_Days_Since_IPO` + `Interaction_Color_Stripe`, data = shoestotal)  
   
                                    K   AICc Delta_AICc AICcWt Cum.Wt     LL
        No Shoe Size                5 -75.93       0.00   0.37   0.37  43.02
        All Variables               6 -75.76       0.17   0.34   0.70  43.96
        No Shoe Size Squared        5 -75.52       0.41   0.30   1.00  42.82
        No Color Stripe Interaction 5 -50.83      25.10   0.00   1.00  30.47
        No Log Days Since IPO       5  71.44     147.36   0.00   1.00 -30.66
   
        Final Model: lm(`Log_Sale_Price` ~ `Shoe Size` + `Log_Days_Since_IPO` + `Light_Dark` +`Solid_Stripe`, data = shoestotal)
   
                              K    AICc Delta_AICc AICcWt Cum.Wt    LL
        No Shoe Size          5 -123.30       0.00   0.60   0.60 66.71
        All Variables         6 -121.99       1.30   0.31   0.92 67.08
        No Log Days Since IPO 5 -119.30       3.99   0.08   1.00 64.71
        No Light_Dark         5  -97.79      25.51   0.00   1.00 53.95
        No Solid_Stripe       5  -85.29      38.01   0.00   1.00 47.70


   **Wald test**  -
   Wald test revealed that the variables chosen for the final regression model are good fits for the model, and confirmed that Shoe Size is a poor predictor of the price of the sneaker. Through running the wald test for each of the variables in the final regression, I found that the p-value was less than 0.05 in all cases excluding the Shoe Size test case. Including statistically significant predictors should lead to better prediction and better model fit, so this test led me to believe that the variables in my model are the best considering the data.
   
    Chi-squared test for Log_Days_Since_IPO:
    X2 = 5.1, df = 1, P(> X2) = 0.024
    
    Chi-squared test for Solid_Stripe:
    X2 = 39.8, df = 1, P(> X2) = 2.8e-10
    
    Chi-squared test for Light_Dark:
    X2 = 26.3, df = 1, P(> X2) = 2.9e-07
   

   **Log Transformation** -
   Took the natural log of both Sale Price and Days Since IPO. For Sale Price, there are sneakers that resold for $1,000+ before their mass release, and then went down to $250 months later, so the log is used here to more easily view the distribution when there is this much variability in the price. Took the natural log of Days Since IPO since the difference in the first 10-20 days since IPO are significant for the change in price, but once the days are in the hundreds, each additional day is less impactful. Use log to capture this assumption on diminishing returns. In order to interpret the coefficients, I used exponentiated regression coefficients since exponentiation is the inverse of the log function.
   
   
 
# Regression Model
  -Residuals are the differences between observed response values (price) and the response values that the model predicted (shoe size)
       Looking for symmetrical distribution, and since our data is not symmetrical, the model is predicting points that land far away from the actual observed points.
       Can see in the large disparity between the quartile ranges and the min/max that the datset is not very symmetric.
       
  -Intercept coefficient of 361.21 is the expected value when considering average shoe size of all shoes in dataset. (avg price is 361.21) (statistically significant    to 99%+ level)
       
  -Standard error of 0.36 is showing average amount that coefficient estimates vary from the avg price (regression line) 
       My standard error is smaller than the coefficient. Say that if we ran the model again, the price should vary by $0.36 in relation to the avg price
            
  -P value of <2e-16 is the probability of observing a value larger than t (25.28).This value is small enough where the relationship between price and shoe size is unlikely due to chance. 
   
  -Log_Days_Since_IPO coefficient of -0.06 shows the inverse relationship between price and the amount of days since the IPO of the sneaker. If the ratio of two values of this variable stays the same, the expected ratio of Sale Price stays the same. For example, for a 10% increase in SalePrice, the expected ratio of the Sale Price will be 1.10^(0.06099) which is 1.005830. In this case, we expect a 0.58% decrease in Sale Price when Days Since IPO increases by 10%. This value is more difficult to interpret when compared to a model where the log is taken off from Days Since IPO, but I believe the log is important here, since the relative importance of the days leans heavily toward those first days after a shoe releases. If a log were not included, the interpretation would simply be: For every one day increase in days since the IPO of the sneaker, Sale Price decreases by x. And in running a bivariate regression with just Sale Price and Days Since IPO, I got x = -$0.16

       
  -Solid_Stripe coefficient of 0.24 is the ratio of the geometric mean for the solid group to the geometric mean for the stripe group. In this case, exponentiated coefficient is the ratio of the geometric mean for the solid group to the geometric mean for the stripe group. The expected percent increase in geometric mean from the solid group to stripe group is 27.13% holding other variables constant, since e^(0.24002) = 1.27127458.
  
  -Light_Dark coefficient of 0.31 is the ratio of the geometric mean for the light group to the geometric mean for the dark group. The exponentiated coefficient is also the ratio of the geometric means. The expected percent increase in geometric mean from the light group to dark group is 36.18% holding other variables constant, since e^(0.0.30882) = 1.36181722.

  -Residual standard error of 254.5 is measuring the quality of the regression fit. It's the avg amount that the price will deviate from regression line (97,866 df)
       Given the mean price is $361.21 and the residual standard error is 254.5, the percentage error (the % any prediction would still be off by) is 70.46%

  -R Squared of 0.0065 shows that our predictor variable (shoe size) isn't accounting for much of the total variance (Only .65%)

  -F statistic of 638.9 is indicating whether there is a relationship between price and shoe size. F statistic is significantly larger than 1 so we can infer a relationship
 
# Summary
  The model used includes only statistically significant independent variables, with p-values for the binary regressors easily meeting a 99% confidence level, and Days Since IPO meeting a 95% confidence level. 
  
  Hypothesis #1 - Reject Null
  
   There is a positive relationship between Solid_Stripe and Sale Price, meaning that solid color Yeezys are garnering higher resale prices than striped Yeezys.   Reject Null in favor of Alternative.
  
  Hypothesis #2 - Reject Null
  
   There is a positive relationship between Light_Dark and Sale Price, meaing that dark color Yeezys are garnering higher resale prices than light colored Yeezys. Reject Null in favor of Alternative.
      
  Hypothesis #3 - Fail to Reject Null
  
   There is no statistically significant relationship between Shoe Size and Sale Price. Larger shoe sizes do not correlate with higher resale prices. Fail to reject Null.
  
  Hypothesis #4 - Fail to Reject Null
  
   There is a negative relationship between Days Since IPO and Sale Price, meaning over time, as the shoe moves away from it's IPO date, the resell price of the sneaker in the after-market decreases. Fail to reject Null.
  
  



# Future Analysis
   Due to the model Rsquared being 0.32, there is still a significant amount of variation in the dependent variable that is not accounted for. 
   
   In future research, these are a few ideas I would pursue:
   
   -Through my experience in the market, I would argue that the number of similar Yeezys compared to the initial model would have an inverse relationship with price. The more similar colorways are released, the less demand there is for the original since some customers see the new model as being comparable to the original and buy the new model instead. This would act as an increase in supply, lowering the price of the original. I w
          -To get this data, I would take a few Yeezy models and create a dummy variable for either 'Similar' or 'Dissimilar'. There would be some subjective calls on whether a new model is similar to the orginal, but I would mostly use characteristics such as color and pattern as I did in my first analysis.
          
   -I would also try to quantify the "hype" around the brand, since the sneaker reselling community often takes heightened interest in certain models for a time, and moves on when the model is either overdone or a new model comes in that attracts the attention of the community. I could use Google Trends as a proxy for interest in the brand, and I would search for the terms "Yeezy" and "Adidas" to see if there is an upward or downward trend in the number of searches related to these keywords. I could use the Google Trends data and tie it in with the shoe price to see if the more these words are searched, the more the sale price on a after-market site increases. 
          -I could also look at the r/Sneakers subreddit where there are 3.1M followers, and record the amount of posts related to Yeezys show up in the feed and the number of upvotes for each post. The subreddit is a place for enthusiasts to show off their sneakers, and sneakers with the most "hype" and excitement around them garner more upvotes. Granted this is a subset of the sneaker community where the opinions may not represent the entire community, so the results would have to be taken with a grain of salt. 
   
   **Proposed Future Model**
   
      summary(lm(`Log_Sale_Price` ~ `Log_Days_Since_IPO` + `Solid_Stripe` + `Light_Dark` + `Hype_Level` + `Post_Engagement`, data = shoestotal))



# Dummy Variable Notes  
   In the R code, I ran a few analyses using dummy variables in order to see which models appreciated faster than others. These analyses are not tied to the final product, but the method is there if I wanted to compare sneaker models. To set up the dummy variables, I made a column for each sneaker model, and filled the columns with alternating 1s and 0s so I can toggle on and off certain models for a regression analysis. 
   
   For this method, I treated the Beluga-2pt0 as the base case model, and compared all other sneaker models to the Beluga. This analysis was mostly exploratory, but I found that the only sneaker that had a positive coefficient was the Yeezy 350 v2 Static Reflective. It is the only sneaker to appreciate in value over time, and this is further shown through a bivariate regression with sale price. Results shown below
   
    summary(lm(`Sale Price` ~ Blue_Tint + Butter + Cream_White + Frozen_Yellow + Sesame + Static + Static_Reflective+ Zebra, data = shoestotal))
    
    Residuals:
         Min       1Q   Median       3Q      Max 
    -102.315  -13.486   -2.482   13.518  132.000 

    Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
    (Intercept)        429.250      8.526  50.345  < 2e-16 ***
    Blue_Tint          -73.500     11.279  -6.516 1.67e-10 ***
    Butter            -193.250     11.439 -16.894  < 2e-16 ***
    Cream_White       -171.038      9.957 -17.179  < 2e-16 ***
    Frozen_Yellow     -162.750      9.998 -16.278  < 2e-16 ***
    Sesame            -160.250     10.785 -14.859  < 2e-16 ***
    Static            -121.768      8.892 -13.694  < 2e-16 ***
    Static_Reflective   53.065      8.760   6.058 2.62e-09 ***
    Zebra              -91.250      9.353  -9.756  < 2e-16 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

    Residual standard error: 29.54 on 531 degrees of freedom
    Multiple R-squared:  0.9081,	Adjusted R-squared:  0.9067 
    F-statistic: 655.5 on 8 and 531 DF,  p-value: < 2.2e-16

Compare the above model to the final model above[(Link)](#Findings). The Rsquared of 0.90 is much higher than the Rsquared of 0.32 in the final model. However, there are too many variables to draw conclusive results from, and also the independent variables are only related to some select sneaker models, where I am trying find predictors that can be generalized to all pairs of Yeezy sneakers and to an extent, other brands of sneakers. 

     
# Visualizations

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
        

## Installation
   To run code, an updated version of R and RStudio is needed. Link is here: https://cran.r-project.org/

## Links
Statista study: https://www.statista.com/statistics/1202148/sneaker-resale-market-value-us-and-global/
Cowen Research Equity study: https://www.cowen.com/insights/sneakers-as-an-alternative-asset-class-part-ii/
