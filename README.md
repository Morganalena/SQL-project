# SQL-project
 
## Assignment
Comparison of food prices and average income over time in the Czech Republic.

The output consists of two database tables containing the necessary data to address these questions:

	1. Over the years, are wages rising in all industries, or falling in some?

	2. How many liters of milk and kilograms of bread can be bought in the first and last comparable periods in the available price 	and wage data?

	3. Which food category is increasing in price the slowest (it has the lowest percentage year-on-year increase)?

	4. Has there been a year in which the year-on-year increase in food prices was significantly higher than wage growth (greater than 	10%)?

	5. Does the level of GDP affect changes in wages and food prices? In other words, if the GDP increases significantly in one year, 	it will be reflected in food prices or wages in the same or the following year by more significant growth? 

### Procedure
The first step involved creating tables with relevant data, which will be used to answer questions. The data was organized into two database tables: the primary table containing information on wages and food prices in the Czech Republic from 2006 until 2018, and the secondary table containing data on GDP, GINI coefficient, and population of other European countries from 2006 until 2018.

The second step consisted of querying to retrieve relevant data on food prices and average income in the Czech Republic over time.

#### Results
1. In summary, all sectors experienced an overall increasing trend over the years. While the majority of sectors saw a rise in wages over time, there were occasional decreases noted in particular industries during certain years. 
   There are two sectors, Manufacturing (C) and Human Health and Social Work Activities (Q), which both experienced consistent wage increases from 2006 to 2018. However, sectors like Mining and Quarrying (B), as well as Electricity, Gas, Steam, and Air Conditioning Supply (D), displayed more fluctuation than other sectors, with periods of both growth and decline in wages probably due to factors like market demand or resource availability.    
	
2. The prices of both bread and milk increased from 2006 to 2018. The price of bread increased from 16.12 CZK to 24.24 CZK, while the price of milk rose from 14.44 CZK to 19.82 CZK. In one month, with an average monthly wage of 33,091 CZK in 2018, people could afford to purchase 1,365 kilograms of bread and 1,670 liters of milk. Conversely, in 2006, with an average monthly wage of 21,165 CZK, people could buy 1,313 kilograms of bread and 1,466 liters of milk. It's evident that both bread and milk became more affordable between 2006 and 2018.   

3. The food category that is increasing in price the slowest, with the lowest percentage year-on-year increase, is "Banány žluté" (Yellow Bananas). Crystal Sugar (Cukr krystalový) experienced the highest decrease in price among all the listed categories, whereas the food category with the highest percentage year-on-year increase is "Papriky" (Peppers). 

4. Although there wasn't a year where the food price increase was more than 10% higher than salary growth, years 2009 and 2013 were particularly notable for their impact on the affordability of food relative to wage increases.

5. The data suggests that the level of GDP may impact changes in both wages and food prices, but there is no consistent pattern from year to year. There are years where GDP increases significantly (e.g., 2007, 2015, 2017, 2018). In 2007, GDP showed growth, and both wages and food prices experienced notable increases. This trend continued into the following year, 2008, with further increases observed in wages and food prices. In 2017, a similar trend was observed where GDP showed growth, and both wages and food prices experienced notable increases. However, unlike in 2007 and 2008, in 2017, food prices experienced a much higher increase compared to wages. Similarly, in 2018, GDP showed significant growth, and both wages and food prices experienced increases. However, the growth in wages significantly outpaced food prices. In contrast, in 2015, GDP experienced significant growth, but both wages and food prices did not follow this growth. 