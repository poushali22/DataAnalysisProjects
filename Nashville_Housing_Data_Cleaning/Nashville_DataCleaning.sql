-- Cleaning data in SQL queries
Use [Portfolio Project]
Select * from NashvilleHousing
-- Standardize Date Format
Select Saledate, Convert(date,SaleDate)
From NashvilleHousing

--Update NashvilleHousing
--Set SaleDate = CONVERT(date,SaleDate) - this step is not working so we are altering the table

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
Set SaleDateConverted = CONVERT(date,SaleDate);

Select SaleDateConverted
From NashvilleHousing;

-- Populate Property Address data
Select *
From NashvilleHousing
Where PropertyAddress is null

Select *
From NashvilleHousing
order by ParcelID 
-- we can see same parcel id has the same property address so if any property address has null value then we can refer to the address having the same panelid

Select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
	On a.ParcelID=b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

Update a
Set PropertyAddress=ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
Join NashvilleHousing b
	On a.ParcelID=b.ParcelID
	And a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

-- Breaking out Property Address into Individual Columns (Address, City, State)
Select PropertyAddress
From NashvilleHousing
order by ParcelID

Select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, Len(PropertyAddress)) as Address
From NashvilleHousing

Alter Table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1);

Alter Table NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, Len(PropertyAddress));

Select PropertyAddress,PropertySplitAddress,PropertySplitCity
From NashvilleHousing
Order by ParcelID


-- Breaking out Owner Address into Individual Columns (Address, City, State)
Select OwnerAddress
From NashvilleHousing

Select OwnerAddress,
PARSENAME(Replace(OwnerAddress,',','.'),3),
PARSENAME(Replace(OwnerAddress,',','.'),2),
PARSENAME(Replace(OwnerAddress,',','.'),1)
From NashvilleHousing
order by ParcelID

Alter Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3);

Alter Table NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'),2);

Alter Table NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1);

Select *
From NashvilleHousing

--Change Y and N to Yes and No in "Sold as vacant" Field
Select Distinct(SoldAsVacant),Count(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant
Order by 2

Select SoldAsVacant,
Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End
From NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End

Select Distinct(SoldAsVacant),Count(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant


-- Remove Duplicates
With RowNumCTE As(
Select *,
	ROW_NUMBER() Over(
	Partition BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 LegalReference
				 Order by UniqueID
				) row_num			 
From NashvilleHousing
--Order by ParcelID
)
Select *
From RowNumCTE
where row_num <> 1
Order By PropertyAddress

With RowNumCTE As(
Select *,
	ROW_NUMBER() Over(
	Partition BY ParcelID,
				 PropertyAddress,
				 SaleDate,
				 LegalReference
				 Order by UniqueID
				) row_num			 
From NashvilleHousing
--Order by ParcelID
)
Delete
From RowNumCTE
where row_num <> 1
--Order By PropertyAddress

-- Delete Unused Columns


Select *
From NashvilleHousing

Alter Table NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table NashvilleHousing
Drop Column SaleDate




