# AtliQ Sales Insights using PowerBi Dashboard
This is a project I replicated from Codebasics PowerBi Youtube playlist and edited the final dashboard. You can find the link of the playlist below. 
[Youtube link](https://www.youtube.com/watch?v=hhZ62IlTxYs&list=PLeo1K3hjS3utcb9nKtanhcn8jd2E0Hp9b&ab_channel=codebasics)

## Problem statement
AtliQ Hardware is a business with several offices across India that provides computer hardware & peripheral Manufacturers to its customers. The company's sales director is having a lot of trouble understanding how the firm is doing and what challenges it is now experiencing because sales are below expectations and steadily falling. Additionally, as a result of human nature, whenever the sales director calls the regional managers to inquire about the state of the market and sales, they tend to sugarcoat the information and send a ton of Excel files rather than providing the straight story, which only served to aggravate the sales director. The obvious cause of the annoyance is that people find it uncomfortable to read numbers from Excel files.

## Solution
Sales director of the AltiQ hardware, decided to build a PowerBI Dashboard for converting the data into visual representation to make data driven decisions. 

## Steps Followed in this project
1. Performed a High level analysis of data in SQL to get better understanding over the data.
2. Connected the SQL data set to PowerBI.
3. Performed ETL and data cleaning on the imported data.
4. In the currency there were two types of currencies in transactions, performed currency conversion to make all the currency type same
5. Created measures according to our needs and used them for creating visuals in PowerBi.
6. After the initial report reviewed by the stakeholders, made changes to the report based on the review comments.

## Final Result
### Initial Dashboard
<img width="626" alt="image" src="https://user-images.githubusercontent.com/103009509/178751474-5b98559c-2124-47bd-9fa2-ac86b2e39771.png">

### Updated Dashboard
<img width="611" alt="image" src="https://user-images.githubusercontent.com/103009509/178751679-db59ad9d-a175-4f18-886c-6f2cbd428394.png">

### Insights
We can get below insights from uploaded file "Updated_insights":

1. Delhi is giving us the highest revenue but not the highest profit margin. Bhubaneshwar is giving you the highest profit margin so we should focus in Bhubaneswar market more.
2. In terms of profit mumbai is our top market.
3. More than 50% of our profit is coming from delhi but it is not providing the highest profit.
4. We can see that Nagpur is contributing to 10% of profit but revenue wise it is 5.8%. So That means we can improve our market there.
5. Excel stores, surge stores, electricalsara - these are the companies which give me the most profits.
6. We sell item to electricalsara  with very less profit margin. But still they have given us a profit contribution of 11.9 that means they give us lots of orders.
7. We should see the lowest profit margin percentage. To electricalsquipo stores we are giving products in a loss but they do not provide us any positive profit too so we should look into that.
8. We should see lucknow which has given us least profit percentage by market. If we see the customer name - we only have one customer there which is insight and that also is not giving us any profit. So we should consider removing our supply to lucknow.
