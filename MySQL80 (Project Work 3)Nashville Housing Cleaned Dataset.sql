CREATE TABLE Nashville_Housing
LIKE `nashville housing data for data cleaning`;

INSERT INTO nashville_housing
SELECT*
FROM `nashville housing data for data cleaning`;

SELECT*
FROM nashville_housing;

SELECT*,
ROW_NUMBER () OVER (PARTITION BY UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, 
LegalReference, SoldAsVacant, OwnerName, OwnerAddress, 
Average, TaxDistrict, LandValue, BuildingValue, TotalValue,
YearBuilt, Bedrooms, FullBath, HalfBath) AS Row_Num
FROM nashville_housing;

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

ALTER TABLE nashville_housing
ADD COLUMN SaleDate_Converted DATE;

UPDATE nashville_housing
SET SaleDate_Converted = STR_TO_DATE(SaleDate, '%d-%b-%y');

SELECT SaleDate, SaleDate_Converted 
FROM nashville_housing
LIMIT 10;

ALTER TABLE nashville_housing
DROP COLUMN SaleDate;

ALTER TABLE nashville_housing
CHANGE COLUMN SaleDate_Converted SaleDate DATE;

ALTER TABLE nashville_housing
MODIFY COLUMN SaleDate DATE
AFTER SalePrice;

SELECT PropertyAddress
FROM nashville_housing
WHERE PropertyAddress = '';

SELECT UniqueID, ParcelID, LandUse, PropertyAddress
FROM nashville_housing
WHERE PropertyAddress = '';

UPDATE nashville_housing
SET PropertyAddress = NULL
WHERE PropertyAddress = '';

SELECT UniqueID, ParcelID, LandUse, PropertyAddress
FROM nashville_housing
WHERE PropertyAddress IS NULL;

SELECT A.UniqueID, A.ParcelID, A.PropertyAddress,
B.UniqueID, B.ParcelID, B.PropertyAddress, COALESCE(A.PropertyAddress, B.PropertyAddress)
FROM nashville_housing_data.nashville_housing AS A
JOIN nashville_housing_data.nashville_housing AS B
	ON A.ParcelID = B.ParcelID
    AND A.UniqueID <> B.UniqueID
WHERE A.PropertyAddress IS NULL;

UPDATE nashville_housing AS A
JOIN nashville_housing AS B
ON A.ParcelID = B.ParcelID
AND A.UniqueID <> B.UniqueID
SET A.PropertyAddress = COALESCE(A.PropertyAddress, B.PropertyAddress)
WHERE A.PropertyAddress IS NULL;

SELECT A.UniqueID, A.ParcelID, A.PropertyAddress,
B.UniqueID, B.ParcelID, B.PropertyAddress
FROM nashville_housing_data.nashville_housing AS A
JOIN nashville_housing_data.nashville_housing AS B
	ON A.ParcelID = B.ParcelID
    AND A.UniqueID <> B.UniqueID;

SELECT PropertyAddress, OwnerAddress
FROM nashville_housing;

ALTER TABLE nashville_housing
ADD COLUMN Property_Street VARCHAR(255),
ADD COLUMN Property_City VARCHAR(255),
ADD COLUMN Property_State VARCHAR(255);

UPDATE nashville_housing
SET Property_Street = SUBSTRING_INDEX(PropertyAddress, ',', 1),
Property_City = SUBSTRING_INDEX(PropertyAddress, ',', -1);

ALTER TABLE nashville_housing
DROP COLUMN Property_State;

ALTER TABLE nashville_housing
MODIFY COLUMN Property_Street VARCHAR(255)
AFTER LandUse;

ALTER TABLE nashville_housing
MODIFY COLUMN Property_City VARCHAR(255)
AFTER Property_Street;

ALTER TABLE nashville_housing
DROP COLUMN PropertyAddress;

ALTER TABLE nashville_housing
ADD COLUMN Owner_Street VARCHAR(255),
ADD COLUMN Owner_City VARCHAR(255),
ADD COLUMN Owner_State VARCHAR(255);

UPDATE nashville_housing
SET Owner_Street = SUBSTRING_INDEX(OwnerAddress, ',', 1),
Owner_City = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1),
Owner_State = SUBSTRING_INDEX(OwnerAddress, ',', -1);

ALTER TABLE nashville_housing
MODIFY COLUMN Owner_Street VARCHAR(255)
AFTER OwnerName;

ALTER TABLE nashville_housing
MODIFY COLUMN Owner_City VARCHAR(255)
AFTER Owner_Street;

ALTER TABLE nashville_housing
MODIFY COLUMN Owner_State VARCHAR(255)
AFTER Owner_City;

ALTER TABLE nashville_housing
DROP COLUMN OwnerAddress;

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM nashville_housing
GROUP BY SoldAsVacant;

SELECT SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END 
FROM nashville_housing;
UPDATE nashville_housing
SET SoldAsVacant =
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END ;
