--Create a New Table for Housing Data
CREATE TABLE Nashville_Housing
LIKE `nashville housing data for data cleaning`;

--Insert Data into the New Table
INSERT INTO nashville_housing
SELECT*
FROM `nashville housing data for data cleaning`;

--View the Data in the Table
SELECT*
FROM nashville_housing;

--Add Row Numbers for Identifying Duplicates
SELECT*,
ROW_NUMBER () OVER (PARTITION BY UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, 
LegalReference, SoldAsVacant, OwnerName, OwnerAddress, 
Average, TaxDistrict, LandValue, BuildingValue, TotalValue,
YearBuilt, Bedrooms, FullBath, HalfBath) AS Row_Num
FROM nashville_housing;

--Identify Duplicate Rows Using CTE
WITH Nashville_CTE AS
(SELECT*,
ROW_NUMBER () OVER (PARTITION BY UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, 
LegalReference, SoldAsVacant, OwnerName, OwnerAddress, 
Average, TaxDistrict, LandValue, BuildingValue, TotalValue,
YearBuilt, Bedrooms, FullBath, HalfBath) AS Row_Num
FROM nashville_housing)
SELECT*
FROM Nashville_CTE
WHERE Row_Num > 1;

--Add a New Column for Converted Sale Date
ALTER TABLE nashville_housing
ADD COLUMN SaleDate_Converted DATE;

--Convert Sale Date to the Correct Format
UPDATE nashville_housing
SET SaleDate_Converted = STR_TO_DATE(SaleDate, '%d-%b-%y');

--Verify the Converted Sale Date
SELECT SaleDate, SaleDate_Converted 
FROM nashville_housing
LIMIT 10;

--Remove the Old Sale Date Column
ALTER TABLE nashville_housing
DROP COLUMN SaleDate;

--Rename and Reorder the Sale Date Column
ALTER TABLE nashville_housing
CHANGE COLUMN SaleDate_Converted SaleDate DATE;

--Check for Empty Property Addresses
ALTER TABLE nashville_housing
MODIFY COLUMN SaleDate DATE
AFTER SalePrice;

--Replace Empty Property Addresses with NULL
SELECT PropertyAddress
FROM nashville_housing
WHERE PropertyAddress = '';

--Identify Missing Property Addresses Using Parcel ID
SELECT UniqueID, ParcelID, LandUse, PropertyAddress
FROM nashville_housing
WHERE PropertyAddress = '';

--Update Missing Property Addresses from Duplicate Records
UPDATE nashville_housing
SET PropertyAddress = NULL
WHERE PropertyAddress = '';

--Verify Property Address Updates
SELECT UniqueID, ParcelID, LandUse, PropertyAddress
FROM nashville_housing
WHERE PropertyAddress IS NULL;

--Split Property Address into Separate Columns
SELECT A.UniqueID, A.ParcelID, A.PropertyAddress,
B.UniqueID, B.ParcelID, B.PropertyAddress, COALESCE(A.PropertyAddress, B.PropertyAddress)
FROM nashville_housing_data.nashville_housing AS A
JOIN nashville_housing_data.nashville_housing AS B
	ON A.ParcelID = B.ParcelID
    AND A.UniqueID <> B.UniqueID
WHERE A.PropertyAddress IS NULL;

--Updating the Substitute Process
UPDATE nashville_housing AS A
JOIN nashville_housing AS B
ON A.ParcelID = B.ParcelID
AND A.UniqueID <> B.UniqueID
SET A.PropertyAddress = COALESCE(A.PropertyAddress, B.PropertyAddress)
WHERE A.PropertyAddress IS NULL;

--Verifying the Substitute Process
SELECT A.UniqueID, A.ParcelID, A.PropertyAddress,
B.UniqueID, B.ParcelID, B.PropertyAddress
FROM nashville_housing_data.nashville_housing AS A
JOIN nashville_housing_data.nashville_housing AS B
	ON A.ParcelID = B.ParcelID
    AND A.UniqueID <> B.UniqueID;

--Verify Property Address Updates
SELECT PropertyAddress, OwnerAddress
FROM nashville_housing;

--Reorder Property Address Columns
ALTER TABLE nashville_housing
ADD COLUMN Property_Street VARCHAR(255),
ADD COLUMN Property_City VARCHAR(255),
ADD COLUMN Property_State VARCHAR(255);

--Split Property Address into Separate Columns
UPDATE nashville_housing
SET Property_Street = SUBSTRING_INDEX(PropertyAddress, ',', 1),
Property_City = SUBSTRING_INDEX(PropertyAddress, ',', -1);

--Remove Unnecessary Property State Column
ALTER TABLE nashville_housing
DROP COLUMN Property_State;

--Reorder Property Address Columns
ALTER TABLE nashville_housing
MODIFY COLUMN Property_Street VARCHAR(255)
AFTER LandUse;

--Reorder Property Address Columns
ALTER TABLE nashville_housing
MODIFY COLUMN Property_City VARCHAR(255)
AFTER Property_Street;

--Drop the Original Property Address Column
ALTER TABLE nashville_housing
DROP COLUMN PropertyAddress;

--Split Owner Address into Separate Columns
ALTER TABLE nashville_housing
ADD COLUMN Owner_Street VARCHAR(255),
ADD COLUMN Owner_City VARCHAR(255),
ADD COLUMN Owner_State VARCHAR(255);

--Update data into the Split Owner Address into Separate Columns
UPDATE nashville_housing
SET Owner_Street = SUBSTRING_INDEX(OwnerAddress, ',', 1),
Owner_City = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1),
Owner_State = SUBSTRING_INDEX(OwnerAddress, ',', -1);

--Reorder Owner Address Columns
ALTER TABLE nashville_housing
MODIFY COLUMN Owner_Street VARCHAR(255)
AFTER OwnerName;

--Reorder Owner Address Columns
ALTER TABLE nashville_housing
MODIFY COLUMN Owner_City VARCHAR(255)
AFTER Owner_Street;

--Reorder Owner Address Columns
ALTER TABLE nashville_housing
MODIFY COLUMN Owner_State VARCHAR(255)
AFTER Owner_City;

--Drop the Original Owner Address Column
ALTER TABLE nashville_housing
DROP COLUMN OwnerAddress;

--Count Unique Values of 'Sold As Vacant'
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM nashville_housing
GROUP BY SoldAsVacant;

--Standardize 'Sold As Vacant' Values
SELECT SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END 
FROM nashville_housing;

--Update the Table with Standardized 'Sold As Vacant' Values
UPDATE nashville_housing
SET SoldAsVacant =
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END ;
