# Data cleaning of Nashville Housing data
This project has been recreated with the help of the following [Youtube Link](https://www.youtube.com/watch?v=8rO7ztF4NtU&list=PLUaB-1hjhk8H48Pj32z4GZgGWyylqv85f&index=3&ab_channel=AlexTheAnalyst)

## Data Cleaning steps:
1. Standerdized the SaleDate column which has the dates of the property sold.
2. Populating the Property address null values by analyzing the parcel id. We can see same parcel id has the same property address so if any property address has null value then we can refer to the address having the same parcel id. 
3. Breaking out Property Address into Individual Columns (Address, City, State).
4. Breaking out Owner Address into Individual Columns (Address, City, State).
5. Change Y and N to Yes and No in "Sold as vacant" Field. Because previously we had 4 values in this column - Y, N, Yes, No.
6. We have removed Duplicates. If two rows has same Parcel ID, PropertyAddress, SaleDate, LegalReference then we considered it as the same data and removed one from them.
