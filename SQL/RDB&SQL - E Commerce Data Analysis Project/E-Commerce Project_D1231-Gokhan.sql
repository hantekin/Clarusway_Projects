
----------------------------------E-COMMERCE PROJECT SOLUTION------------------------------------------------------------------------

--First I created a database named E_Commerce.
--Related excel ve cvs files were imported and data was reviewed at first hand.

select * from [dbo].[cust_dimen];
select * from [dbo].[market_fact$];
select * from [dbo].[orders_dimen];
select * from [dbo].[prod_dimen$];
select * from [dbo].[shipping_dimen];

--Some characters in the table names like '$' which does not look good were removed.
--Values in some columns in several tables which are convenient to be primary key were corrected and datatype was made integer.
--For example Ord_Ýd_24 was changed as 24.
-- A column name in a table was changed as Ord_id to provide coherence with other tables.


---------------------------------- CLEANING AND CORRECTING THE TABLES--------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

-------------------------------CHANGES RELATED TO THE cust_dimen TABLE-------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

--Column Yeni was added to the cust_dimen table with a datatype INT.---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE cust_dimen ADD Yeni INT;

---///////NOT: AÞAÐIDAKÝ SUBSTRING, PATINDEX LÝ KISIM ÝLE BÝR SÜTUNDAKÝ (BURDA Cust_id) VERÝLER RAKAMLARI KALACAK ÞEKÝLDE TEMÝZLENDÝ.
--VIEW OLUÞTURULARAK VIEW ÝÇÝNE HEM ORJÝNAL Cust_id HEM DE SADECE SAYILARI ÝÇEREN RESULT ÝSÝMLÝ SÜTUN OLUÞTURULDU. DAHA SONRA DA 
--ORJÝNAL TABLO OLUÞTURULMUÞ OLAN VIEW YARDIMIYLA GÜNCELLENDÝ VE ORJÝNAL TABLODA OLUÞTURULMUÞ YENÝ SÜTUNUNA RESULT ÝÇÝNDEKÝ SAYISAL
--VERÝLER AKTARILDI. SONRAKÝ ÝÞLEMLERDE TABLO DEÐÝÞMÝÞ OLDUÐU ÝÇÝN AÞAÐIDAKÝ KOD TEKRAR ÇALIÞMAYACAKTIR.////////////////////////
--
--A View was created which involves Cust_id column from the cust_dimen table and a column named RESULT which was formed from-------
--the integer part of the Cust_id column.------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Cust_Id_Int_cust_dimen] AS 
SELECT Cust_id,
SUBSTRING(Cust_id,
PATINDEX('%[0-9]%', Cust_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Cust_id, 1, (PATINDEX('%[0-9]%', Cust_id) - 1), '')) = 0
THEN LEN(Cust_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Cust_id, 1, (PATINDEX('%[0-9]%', Cust_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM cust_dimen;

SELECT * FROM Cust_Id_Int_cust_dimen;

--Yeni column from cust_dimen table was updated with the RESULT column from the above view--------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE cust_dimen
SET cust_dimen.Yeni = B.RESULT
FROM cust_dimen A 
JOIN Cust_Id_Int_cust_dimen B
ON A.Cust_id = B.Cust_id;

--Cust_id column from cust_dimen table was dropped.-----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE cust_dimen DROP COLUMN Cust_id;

-- Yeni column from cust_dimen table was renamed as Cust_id.--------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.cust_dimen.Yeni', 'Cust_id', 'COLUMN';


------------------------------CHANGES RELATED TO THE market_fact$ TABLE---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

--market_fact$ was renamed as market_facts.-------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'market_fact$', 'market_facts';

--Column Yeni was added to the market_facts table with a datatype INT.----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts ADD Yeni INT;

--A View was created which involves Ord_id column from the market_facts table and a column named RESULT which was formed from---------
--the integer part of the Ord_id column.----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Ord_id_Int_market_facts] AS 
SELECT Ord_id,
SUBSTRING(Ord_id,
PATINDEX('%[0-9]%', Ord_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Ord_id, 1, (PATINDEX('%[0-9]%', Ord_id) - 1), '')) = 0
THEN LEN(Ord_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Ord_id, 1, (PATINDEX('%[0-9]%', Ord_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM market_facts;

SELECT * FROM Ord_id_Int_market_facts;

----Yeni column from market_facts table was updated with the RESULT column from the above view.---------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE market_facts
SET market_facts.Yeni = B.RESULT
FROM market_facts A 
JOIN Ord_id_Int_market_facts B
ON A.Ord_id = B.Ord_id;

--Ord_id column from market_facts table was dropped.----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts DROP COLUMN Ord_id;

-- Yeni column from  market_facts table was renamed as Ord_id.------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.market_facts.Yeni', 'Ord_id', 'COLUMN';

-- THEN WE PRACTISED THE SAME PROCESS FOR THE Prod_id COLUMN FROM THE market_facts TABLE ---------------------------------------------
--Column Yeni was added to the market_facts table with a datatype INT.----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts ADD Yeni INT;

--A View was created which involves Prod_id column from the market_facts table and a column named RESULT which was formed from---------
--the integer part of the Prod_id column.----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Prod_id_Int_market_facts] AS 
SELECT Prod_id,
SUBSTRING(Prod_id,
PATINDEX('%[0-9]%', Prod_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Prod_id, 1, (PATINDEX('%[0-9]%', Prod_id) - 1), '')) = 0
THEN LEN(Prod_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Prod_id, 1, (PATINDEX('%[0-9]%', Prod_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM market_facts;

SELECT * FROM Prod_id_Int_market_facts;

----Yeni column from market_facts table was updated with the RESULT column from the above view.---------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE market_facts
SET market_facts.Yeni = B.RESULT
FROM market_facts A 
JOIN Prod_id_Int_market_facts B
ON A.Prod_id = B.Prod_id;

--Prod_id column from market_facts table was dropped.----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts DROP COLUMN Prod_id;

-- Yeni column from  market_facts table was renamed as Prod_id.------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.market_facts.Yeni', 'Prod_id', 'COLUMN';


-- THEN WE PRACTISED THE SAME PROCESS FOR THE Ship_id COLUMN FROM THE market_facts TABLE ---------------------------------------------
--Column Yeni was added to the market_facts table with a datatype INT.----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts ADD Yeni INT;

--A View was created which involves Ship_id column from the market_facts table and a column named RESULT which was formed from---------
--the integer part of the Ship_id column.----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Ship_id_Int_market_facts] AS 
SELECT Ship_id,
SUBSTRING(Ship_id,
PATINDEX('%[0-9]%', Ship_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Ship_id, 1, (PATINDEX('%[0-9]%', Ship_id) - 1), '')) = 0
THEN LEN(Ship_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Ship_id, 1, (PATINDEX('%[0-9]%', Ship_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM market_facts;

SELECT * FROM Ship_id_Int_market_facts;

----Yeni column from market_facts table was updated with the RESULT column from the above view.---------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE market_facts
SET market_facts.Yeni = B.RESULT
FROM market_facts A 
JOIN Ship_id_Int_market_facts B
ON A.Ship_id = B.Ship_id;

--Ship_id column from market_facts table was dropped.----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts DROP COLUMN Ship_id;

-- Yeni column from  market_facts table was renamed as Ship_id.------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.market_facts.Yeni', 'Ship_id', 'COLUMN';

-- THEN WE PRACTISED THE SAME PROCESS FOR THE Cust_id COLUMN FROM THE market_facts TABLE ---------------------------------------------
--Column Yeni was added to the market_facts table with a datatype INT.----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts ADD Yeni INT;

--A View was created which involves Ship_id column from the market_facts table and a column named RESULT which was formed from---------
--the integer part of the Ship_id column.----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Cust_id_Int_market_facts] AS 
SELECT Cust_id,
SUBSTRING(Cust_id,
PATINDEX('%[0-9]%', Cust_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Cust_id, 1, (PATINDEX('%[0-9]%', Cust_id) - 1), '')) = 0
THEN LEN(Cust_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Cust_id, 1, (PATINDEX('%[0-9]%', Cust_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM market_facts;

SELECT * FROM Cust_id_Int_market_facts;

----Yeni column from market_facts table was updated with the RESULT column from the above view.---------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE market_facts
SET market_facts.Yeni = B.RESULT
FROM market_facts A 
JOIN Cust_id_Int_market_facts B
ON A.Cust_id = B.Cust_id;

--Cust_id column from market_facts table was dropped.----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts DROP COLUMN Cust_id;

-- Yeni column from  market_facts table was renamed as Cust_id.------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.market_facts.Yeni', 'Cust_id', 'COLUMN';


------------------------------CHANGES RELATED TO THE prod_dimen$ TABLE---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

--prod_dimen$ was renamed as prod_dimen.-------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'prod_dimen$', 'prod_dimen';

--Column Yeni was added to the prod_dimen table with a datatype INT.----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE prod_dimen ADD Yeni INT;

--A View was created which involves Prod_id column from the prod_dimen table and a column named RESULT which was formed from---------
--the integer part of the Prod_id column.----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Prod_id_Int_prod_dimen] AS 
SELECT Prod_id,
SUBSTRING(Prod_id,
PATINDEX('%[0-9]%', Prod_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Prod_id, 1, (PATINDEX('%[0-9]%', Prod_id) - 1), '')) = 0
THEN LEN(Prod_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Prod_id, 1, (PATINDEX('%[0-9]%', Prod_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM prod_dimen;

SELECT * FROM Prod_id_Int_prod_dimen;

----Yeni column from prod_dimen table was updated with the RESULT column from the above view.---------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE prod_dimen
SET prod_dimen.Yeni = B.RESULT
FROM prod_dimen A 
JOIN Prod_id_Int_prod_dimen B
ON A.Prod_id = B.Prod_id;

--Prod_id column from prod_dimen table was dropped.----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE prod_dimen DROP COLUMN Prod_id;

-- Yeni column from  prod_dimen table was renamed as Prod_id.------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.prod_dimen.Yeni', 'Prod_id', 'COLUMN';

------------------------------CHANGES RELATED TO THE orders_dimen TABLE---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

--Column Yeni was added to the orders_dimen table with a datatype INT.----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE orders_dimen ADD Yeni INT;

--A View was created which involves Ord_id column from the orders_dimen table and a column named RESULT which was formed from---------
--the integer part of the Ord_id column.----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Ord_id_Int_orders_dimen] AS 
SELECT Ord_id,
SUBSTRING(Ord_id,
PATINDEX('%[0-9]%', Ord_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Ord_id, 1, (PATINDEX('%[0-9]%', Ord_id) - 1), '')) = 0
THEN LEN(Ord_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Ord_id, 1, (PATINDEX('%[0-9]%', Ord_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM orders_dimen;

SELECT * FROM Ord_id_Int_orders_dimen;

----Yeni column from orders_dimen table was updated with the RESULT column from the above view.---------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE orders_dimen
SET orders_dimen.Yeni = B.RESULT
FROM orders_dimen A 
JOIN Ord_id_Int_orders_dimen B
ON A.Ord_id = B.Ord_id;

--Ord_id column from orders_dimen table was dropped.----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE orders_dimen DROP COLUMN Ord_id;

-- Yeni column from  orders_dimen table was renamed as Ord_id.------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.orders_dimen.Yeni', 'Ord_id', 'COLUMN';

------------------------------CHANGES RELATED TO THE shipping_dimen TABLE---------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

-- Order_ID column name was renamed as Ord_id to provide coherence with other tables.
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.shipping_dimen.Order_ID', 'Ord_id', 'COLUMN';

--Column Yeni was added to the shipping_dimen table with a datatype INT.----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE shipping_dimen ADD Yeni INT;

--A View was created which involves Ship_id column from the shipping_dimen table and a column named RESULT which was formed from---------
--the integer part of the Ord_id column.----------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW [Ship_id_Int_shipping_dimen] AS 
SELECT Ship_id,
SUBSTRING(Ship_id,
PATINDEX('%[0-9]%', Ship_id),
(CASE WHEN PATINDEX('%[^0-9]%', STUFF(Ship_id, 1, (PATINDEX('%[0-9]%', Ship_id) - 1), '')) = 0
THEN LEN(Ship_id) ELSE (PATINDEX('%[^0-9]%', STUFF(Ship_id, 1, (PATINDEX('%[0-9]%', Ship_id) - 1), ''))) - 1
END ) 
) AS RESULT
FROM shipping_dimen;

SELECT * FROM Ship_id_Int_shipping_dimen;

----Yeni column from shipping_dimen table was updated with the RESULT column from the above view.---------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

UPDATE shipping_dimen
SET shipping_dimen.Yeni = B.RESULT
FROM shipping_dimen A 
JOIN Ship_id_Int_shipping_dimen B
ON A.Ship_id = B.Ship_id;

--Ship_id column from shipping_dimen table was dropped.----------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE shipping_dimen DROP COLUMN Ship_id;

-- Yeni column from  shipping_dimen table was renamed as Ship_id.------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_rename 'dbo.shipping_dimen.Yeni', 'Ship_id', 'COLUMN';

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
--Checking some columns in several tables for primary key purposes

SELECT CASE WHEN count(distinct Ship_id)= count(Ship_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM shipping_dimen;   -- unique

SELECT CASE WHEN count(distinct Ord_id)= count(Ord_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM shipping_dimen; -- not unique

SELECT CASE WHEN count(distinct Ord_id)= count(Ord_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM orders_dimen; -- unique

SELECT CASE WHEN count(distinct Prod_id)= count(Prod_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM prod_dimen; -- unique

SELECT CASE WHEN count(distinct Cust_id)= count(Cust_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM cust_dimen; -- unique

SELECT CASE WHEN count(distinct Ord_id)= count(Ord_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM market_facts; -- not unique

SELECT CASE WHEN count(distinct Prod_id)= count(Prod_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM market_facts; -- not unique

SELECT CASE WHEN count(distinct Ship_id)= count(Ship_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM market_facts; -- not unique

SELECT CASE WHEN count(distinct Cust_id)= count(Cust_id)
THEN 'column values are unique' ELSE 'column values are NOT unique' END
FROM market_facts; -- not unique


--Primary Keys were created-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE prod_dimen ALTER COLUMN Prod_id INT NOT NULL;
ALTER TABLE prod_dimen 
ADD CONSTRAINT prod_dimen_PK PRIMARY KEY (Prod_id);

ALTER TABLE shipping_dimen ALTER COLUMN ship_id INT NOT NULL;
ALTER TABLE shipping_dimen 
ADD CONSTRAINT shipping_dimen_PK PRIMARY KEY (Ship_id);

ALTER TABLE orders_dimen ALTER COLUMN ord_id INT NOT NULL;
ALTER TABLE orders_dimen 
ADD CONSTRAINT orders_dimen_PK PRIMARY KEY (Ord_id);

ALTER TABLE cust_dimen ALTER COLUMN cust_id INT NOT NULL;
ALTER TABLE cust_dimen 
ADD CONSTRAINT cust_dimen_PK PRIMARY KEY (Cust_id);

--Since there is no unique column in the market_facts column, I created a id column for primary key-----------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE market_facts ADD id INT IDENTITY(1,1) NOT NULL

ALTER TABLE market_facts
ADD CONSTRAINT market_facts_PK PRIMARY KEY CLUSTERED (id ASC);

--Foreign Keys were created-----------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE market_facts
ADD CONSTRAINT market_facts_FK1 FOREIGN KEY (Prod_id) REFERENCES prod_dimen (Prod_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE market_facts
ADD	CONSTRAINT market_facts_FK2 FOREIGN KEY (Cust_id) REFERENCES cust_dimen (Cust_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE market_facts
ADD	CONSTRAINT market_facts_FK3 FOREIGN KEY (Ship_id) REFERENCES shipping_dimen (Ship_id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE market_facts
ADD	CONSTRAINT market_facts_FK4 FOREIGN KEY (Ord_id) REFERENCES orders_dimen (Ord_id) ON UPDATE CASCADE ON DELETE CASCADE;


--/////////////////////////////////
--/////////////////////////////////
--/////////////////////////////////
--/////////////////////////////////
--/////////////////////////////////
--/////////////////////////////////
--/////////////////////////////////

--1. JOIN ALL THE TABLES AND CREATE A NEW TABLE CALLED combined_table(market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)-
--------------------------------------------------------------------------------------------------------------------------------------

WITH t1 as (
SELECT A.id, A.Sales, A.Discount, A.Order_Quantity, A.Product_Base_Margin, A.Ord_id, A.Prod_id, A.Ship_id,
       A.Cust_id,  B.Product_Category, B.Product_Sub_Category, C.Order_Date, C.Order_Priority,
	    D.Customer_Name, D.Customer_Segment, D.Province, D.Region, E.Ship_Mode, E.Ship_Date
FROM market_facts A
LEFT JOIN prod_dimen B
ON A.Prod_id = B.Prod_id
LEFT JOIN orders_dimen C
ON A.Ord_id = C.Ord_id
LEFT JOIN cust_dimen D
ON A.Cust_id = D.Cust_id
LEFT JOIN shipping_dimen E
ON A.Ship_id = E.Ship_id)
SELECT * INTO combined_table FROM t1;

ALTER TABLE combined_table
ADD CONSTRAINT combined_table_PK PRIMARY KEY CLUSTERED (id);

SELECT * FROM combined_table;


--///////////////////////


--2. Find the top 3 customers who have the maximum count of orders.

SELECT TOP 3 Customer_Name, Cust_id, COUNT(Ord_id) AS Order_Count
FROM combined_table
GROUP BY Customer_Name, Cust_id
ORDER BY Order_Count DESC;


--/////////////////////////////////



--3.Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.

ALTER TABLE combined_table
ADD DaysTakenForDelivery INT;

WITH t1 AS (
SELECT id, Order_Date, Ship_Date, DATEDIFF(day, Order_Date, Ship_Date) AS DaysTakenForDelivery
FROM combined_table)
UPDATE combined_table
SET combined_table.DaysTakenForDelivery = B.DaysTakenForDelivery
FROM combined_table A 
JOIN t1 B
ON A.id = B.id;


SELECT Order_Date, Ship_Date, DaysTakenForDelivery 
FROM combined_table


--////////////////////////////////////


--4. Find the customer whose order took the maximum time to get delivered.
--Use "MAX" or "TOP"

SELECT TOP 1 Customer_Name, Cust_id, MAX(DaysTakenForDelivery) AS Delivery_Time
FROM combined_table
GROUP BY Customer_Name, Cust_id
ORDER BY Delivery_Time DESC;


--//////////////////////////////////////////////////////////////////////
-- The codes below are tryings for the 4. question, the answer is above

SELECT Customer_Name, MAX(DaysTakenForDelivery) AS Delivery_Time
FROM combined_table
GROUP BY Customer_Name
ORDER BY Delivery_Time DESC;

SELECT Customer_Name, COUNT(DaysTakenForDelivery) AS Delivery_Time
FROM combined_table
WHERE Customer_Name = 'DEAN PERCER'
GROUP BY Customer_Name
ORDER BY Delivery_Time DESC;

SELECT Customer_Name, SUM(DaysTakenForDelivery) AS Delivery_Time
FROM combined_table
WHERE Customer_Name = 'DEAN PERCER'
GROUP BY Customer_Name
ORDER BY Delivery_Time DESC;

SELECT Customer_Name, DaysTakenForDelivery
FROM combined_table
WHERE Customer_Name = 'DEAN PERCER'
ORDER BY DaysTakenForDelivery DESC;     */


--////////////////////////////////



--5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
--You can use date functions and subqueries


SELECT DATENAME(month, Order_Date) _Month_, COUNT(DISTINCT cust_id) Monthly_Cust_Num
FROM	Combined_table A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	combined_table B
WHERE	DATENAME(year, Order_Date) = '2011'
AND		DATENAME(month, Order_Date) = 'January'
AND		A.Cust_id = B.Cust_id
)
AND	DATENAME(year, Order_Date) = '2011'
GROUP BY DATENAME(month, Order_Date)




--///////////////////////////////////////////////////////////////////////
--The codes below are tryings for the 5. question, the answer is above

SELECT DISTINCT Cust_id,  COUNT(Cust_id) customer_count
FROM combined_table
WHERE DATENAME(month, Order_Date) = 'January' AND DATENAME(year, Order_Date) = '2011'
AND Cust_id IN (
				SELECT DISTINCT Cust_id
				FROM combined_table
				WHERE DATENAME(month, Order_Date) != 'January' AND DATENAME(year, Order_Date) = '2011')
GROUP BY Cust_id

--//////////////////////

SELECT DISTINCT *
FROM (
    SELECT DISTINCT Cust_id, 
				CASE 
				WHEN DATENAME(month, Order_Date) = 'January' AND DATENAME(year, Order_Date) = '2011' THEN 'January'
				WHEN DATENAME(month, Order_Date) = 'April' AND DATENAME(year, Order_Date) = '2011' THEN 'April'
				WHEN DATENAME(month, Order_Date) = 'June' AND DATENAME(year, Order_Date) = '2011' THEN 'June'
				WHEN DATENAME(month, Order_Date) = 'April' AND DATENAME(year, Order_Date) = '2011' THEN 'April'
				WHEN DATENAME(month, Order_Date) = 'May' AND DATENAME(year, Order_Date) = '2011' THEN 'May'
				WHEN DATENAME(month, Order_Date) = 'December' AND DATENAME(year, Order_Date) = '2011' THEN 'December'
				WHEN DATENAME(month, Order_Date) = 'September' AND DATENAME(year, Order_Date) = '2011' THEN 'September'
				WHEN DATENAME(month, Order_Date) = 'October' AND DATENAME(year, Order_Date) = '2011' THEN 'October'
				WHEN DATENAME(month, Order_Date) = 'July' AND DATENAME(year, Order_Date) = '2011' THEN 'July'
				WHEN DATENAME(month, Order_Date) = 'March' AND DATENAME(year, Order_Date) = '2011' THEN 'March'
				END AS T1
				FROM combined_table
    ) as source_table 
PIVOT (
    COUNT(Cust_id)
    FOR T1 IN  (
        [January],[February],[March],[April],[May], [June],[July],[August],[September],[October],[November],[December]
    )
)as p;

--//////////////

SELECT DISTINCT Cust_id,DATENAME(month, Order_Date) months,  count(Cust_id) OVER(partition by DATENAME(month, Order_Date)) customer_count
FROM combined_table
WHERE DATENAME(month, Order_Date) = 'January' AND DATENAME(year, Order_Date) = '2011'
AND Cust_id IN (
				SELECT DISTINCT Cust_id
				FROM combined_table
				WHERE DATENAME(month, Order_Date) != 'January' AND DATENAME(year, Order_Date) = '2011')

--////////////////////////////////////////////


--6. write a query to return for each user acording to the time elapsed between the first purchasing and the third purchasing, 
--in ascending order by Customer ID
--Use "MIN" with Window Functions

SELECT DISTINCT 
		Cust_id,
		Order_Date,
		dense_ranking,
		row_num,
		ranking,
		first_purchase,
		DATEDIFF(day, first_purchase, Order_Date) day_interval
FROM	
		(
		SELECT	Cust_id, Ord_id, Order_Date,
				MIN (Order_Date) OVER (PARTITION BY Cust_id ORDER BY Order_Date ) first_purchase,
				DENSE_RANK () OVER (PARTITION BY Cust_id ORDER BY Order_Date) dense_ranking,
				ROW_NUMBER () OVER (PARTITION BY Cust_id ORDER BY Order_Date) row_num,
				RANK() OVER (PARTITION BY Cust_id ORDER BY Order_Date) ranking
		FROM	combined_table
		) A
WHERE dense_ranking = 3;
--WHERE	row_num = 3
--WHERE ranking = 3



--///////////////////////////////////////////////////////////////////////
--The codes below are tryings for the 6. question, the answer is above
WITH T1 AS 
(
SELECT id, Customer_Name, Cust_id, Order_Date, 
		FIRST_VALUE (Order_Date) OVER (PARTITION BY Cust_id ORDER BY id) As first_value,
		MIN(Order_Date) OVER (PARTITION BY Cust_id ORDER BY id) As first_purchase,
		LEAD(Order_Date, 2) OVER (PARTITION BY Cust_id ORDER BY id) next_ord_date,
		ROW_NUMBER () OVER (PARTITION BY Cust_id ORDER BY id) row_num,
		RANK() OVER (PARTITION BY Cust_id ORDER BY id) ranking,
		DENSE_RANK() OVER (PARTITION BY Cust_id ORDER BY id) dense_ranking
FROM combined_table)
SELECT Cust_id, first_purchase, next_ord_date, DATEDIFF(DAY, first_purchase, next_ord_date) DIFF_OFDATE
FROM T1
--WHERE row_num = 1
Group by Cust_id, first_purchase, next_ord_date
ORDER BY Cust_id;


--//////////////////////////////////////

--7. Write a query that returns customers who purchased both product 11 and product 14, 
--as well as the ratio of these products to the total number of products purchased by all customers.
--Use CASE Expression, CTE, CAST and/or Aggregate Functions


WITH T1 AS (
	SELECT	DISTINCT Cust_id, Prod_id, Order_Quantity,
			SUM(Order_Quantity) OVER(PARTITION BY Cust_id, Prod_id) order_quantity_sum,
			SUM(Order_Quantity) OVER(PARTITION BY Cust_id) total_quantity_sum,
			COUNT(Order_Quantity) OVER(PARTITION BY Cust_id) order_quantity_count
	FROM combined_table
	WHERE Cust_id IN (
			SELECT Cust_id
			FROM combined_table
			WHERE Prod_id in ('11', '14')
			GROUP BY Cust_id
			HAVING SUM(CASE WHEN Prod_id = '11' THEN 1 ELSE 0 END) = 1 AND
				   SUM(CASE WHEN Prod_id = '14' THEN 1 ELSE 0 END) = 1)
	)
SELECT DISTINCT Cust_id, Prod_id, Order_Quantity, order_quantity_sum, total_quantity_sum,
		(order_quantity_sum / total_quantity_sum) quantity_ratio_order,
		CAST( 100 * (order_quantity_sum / total_quantity_sum) AS INT) quantity_ratio_order_INT
FROM T1
ORDER BY Cust_id, Prod_id;

--///////////////////////////////////////////////////////////////////////
--The codes below are tryings for the 7. question, the answer is above


SELECT DISTINCT Cust_id
FROM combined_table
WHERE Prod_id IN (
	SELECT Prod_id
	FROM combined_table
	WHERE Prod_id = 11
	UNION
	SELECT Prod_id
	FROM combined_table
	WHERE Prod_id = 14)

--///////////////

SELECT DISTINCT Cust_id
FROM combined_table A
WHERE EXISTS (
	SELECT *
	FROM combined_table B
	WHERE Prod_id = 11 AND A.id = B.id
	UNION
	SELECT *
	FROM combined_table B
	WHERE Prod_id = 14 AND A.id = B.id)

--//////////////

SELECT Cust_id
FROM combined_table
WHERE Prod_id in ('11', '14')
GROUP BY Cust_id
HAVING SUM(CASE WHEN Prod_id = '11' THEN 1 ELSE 0 END) > 0 AND
       SUM(CASE WHEN Prod_id = '14' THEN 1 ELSE 0 END) > 0;

--/////////////////////

WITH T1 AS (
	SELECT	Cust_id, Prod_id, Order_Quantity,
			SUM(Order_Quantity) OVER(PARTITION BY Cust_id, Prod_id) order_quantity_sum,
			SUM(Order_Quantity) OVER(PARTITION BY Cust_id) total_quantity_sum,
			COUNT(Order_Quantity) OVER(PARTITION BY Cust_id) order_quantity_count
	FROM combined_table
)
SELECT DISTINCT Cust_id, Prod_id, Order_Quantity, order_quantity_sum, total_quantity_sum,
		(order_quantity_sum / total_quantity_sum) quantity_ratio_order,
		CAST( 100 * (order_quantity_sum / total_quantity_sum) AS INT) quantity_ratio_order_INT
FROM T1
WHERE Cust_id in(
	SELECT DISTINCT Cust_id
	FROM combined_table
	WHERE Prod_id IN (
		SELECT Prod_id
		FROM combined_table
		WHERE Prod_id = 11
		UNION
		SELECT Prod_id
		FROM combined_table
		WHERE Prod_id = 14)
	)
ORDER BY Cust_id, Prod_id;


--CUSTOMER SEGMENTATION



--1. Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
--Use such date functions. Don't forget to call up columns you might need later.

CREATE VIEW customer_logs AS
SELECT *, Year(Order_Date) Yearly, Month(Order_Date) Monthly
FROM combined_table;

SELECT * 
FROM customer_logs;

--////Trying another code below

SELECT Cust_id, DATENAME(Year, Order_Date) Yearly, DATENAME(Month, Order_Date) Monthly
FROM combined_table;


--//////////////////////////////////



  --2.Create a “view” that keeps the number of monthly visits by users. (Show separately all months from the beginning  business)
--Don't forget to call up columns you might need later.

CREATE VIEW num_of_visits AS 
SELECT	*, COUNT(Cust_id) OVER (partition by Cust_id, Yearly, Monthly) num_of_counts_log
FROM	customer_logs


SELECT * 
FROM num_of_visits



--//////////////////////////////////


--3. For each visit of customers, create the next month of the visit as a separate column.
--You can order the months using "DENSE_RANK" function.
--then create a new column for each month showing the next month using the order you have made above. (use "LEAD" function.)
--Don't forget to call up columns you might need later.


SELECT *, 
	LEAD(Monthly) OVER (partition by Cust_id ORDER BY monthly) next_month,
	DENSE_RANK() OVER(ORDER BY monthly) dense_ranking
FROM num_of_visits


CREATE VIEW next_visit AS 
SELECT *,
		LEAD(dense_ranking_current_month) OVER (PARTITION BY Cust_id ORDER BY dense_ranking_current_month) monthly_next_visit
FROM 
(
SELECT  *,
		DENSE_RANK () OVER (ORDER BY yearly , monthly) dense_ranking_current_month
		
FROM num_of_visits
) AS source_table

SELECT * FROM next_visit;


--/////////////////////////////////



--4. Calculate monthly time gap between two consecutive visits by each customer.
--Don't forget to call up columns you might need later.

CREATE VIEW timegap_monthly AS
SELECT*, 
	DATEDIFF(day, monthly, monthly_next_visit) monthly_time_gap
FROM next_visit;

SELECT * FROM timegap_monthly;



--///////////////////////////////////


--5.Categorise customers using average time gaps. Choose the most fitted labeling model for you.
--For example: 
--Labeled as “churn” if the customer hasn't made another purchase for the months since they made their first purchase.
--Labeled as “regular” if the customer has made a purchase every month.
--Etc.
	
	SELECT * FROM timegap_monthly;

	WITH T1 AS (
		SELECT *, 
		AVG(monthly_time_gap) OVER(partition by Cust_id) avg_monthly_time_gap,
		DENSE_RANK() OVER(ORDER BY Cust_id) ranking_dense
	FROM timegap_monthly
	)
	SELECT Cust_id, avg_monthly_time_gap,
		CASE WHEN avg_monthly_time_gap = 1 THEN 'retained' 
			WHEN avg_monthly_time_gap > 1 THEN 'irregular'
			WHEN avg_monthly_time_gap IS NULL THEN 'Churn'
			ELSE 'UNKNOWN DATA' END cust_labels
	FROM T1;


	

--/////////////////////////////ANSER IS ABOVE, BELOW CODINGS ARE TRYINGS
	WITH T1 AS (
		SELECT *, 
		AVG(monthly_time_gap) OVER(partition by Cust_id) avg_monthly_time_gap,
		DENSE_RANK() OVER(ORDER BY Cust_id) ranking_dense
	FROM timegap_monthly
	)
	SELECT Cust_id, Ord_id, Order_Date, Yearly, Monthly, monthly_next_visit, monthly_time_gap, avg_monthly_time_gap, row_number_,
		CASE 
			WHEN avg_monthly_time_gap IS NULL THEN 'CHURN'
			WHEN avg_monthly_time_gap IS NOT NULL THEN 'NOT CHURN'
		END AS customer_churn
	FROM T1;



--/////////////////////////////////////




--MONTH-WISE RETENTÝON RATE


--Find month-by-month customer retention rate  since the start of the business.


--1. Find the number of customers retained month-wise. (You can use time gaps)
--Use Time Gaps

SELECT DISTINCT YEAR(Order_Date) FROM timegap_monthly;


--////2009 YILINDA OCAK AYINDA OLUP DA DÝÐER AYLARDA DA OLAN MÜÞTERÝLER
CREATE VIEW retained_cus_2009 AS
SELECT DATENAME(month, Order_Date) _Month_, COUNT(DISTINCT Cust_id) Monthly_Cust_Num_Retained_2009
FROM	timegap_monthly A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	timegap_monthly B
WHERE	DATENAME(year, Order_Date) = '2009'
AND		DATENAME(month, Order_Date) = 'January'
AND		A.Cust_id = B.Cust_id
)
AND	DATENAME(year, Order_Date) = '2009'
GROUP BY DATENAME(month, Order_Date)

SELECT * FROM retained_cus_2009


--////2010 YILINDA OCAK AYINDA OLUP DA DÝÐER AYLARDA DA OLAN MÜÞTERÝLER
CREATE VIEW retained_cus_2010 AS
SELECT DATENAME(month, Order_Date) _Month_, COUNT(DISTINCT Cust_id) Monthly_Cust_Num_Retained_2010
FROM	timegap_monthly A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	timegap_monthly B
WHERE	DATENAME(year, Order_Date) = '2010'
AND		DATENAME(month, Order_Date) = 'January'
AND		A.Cust_id = B.Cust_id
)
AND	DATENAME(year, Order_Date) = '2010'
GROUP BY DATENAME(month, Order_Date)

SELECT * FROM retained_cus_2010

--////2011 YILINDA OCAK AYINDA OLUP DA DÝÐER AYLARDA DA OLAN MÜÞTERÝLER
CREATE VIEW retained_cus_2011 AS
SELECT DATENAME(month, Order_Date) _Month_, COUNT(DISTINCT Cust_id) Monthly_Cust_Num_Retained_2011
FROM	timegap_monthly A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	timegap_monthly B
WHERE	DATENAME(year, Order_Date) = '2011'
AND		DATENAME(month, Order_Date) = 'January'
AND		A.Cust_id = B.Cust_id
)
AND	DATENAME(year, Order_Date) = '2011'
GROUP BY DATENAME(month, Order_Date)

SELECT * FROM retained_cus_2011


--////2012 YILINDA OCAK AYINDA OLUP DA DÝÐER AYLARDA DA OLAN MÜÞTERÝLER
CREATE VIEW retained_cus_2012 AS
SELECT DATENAME(month, Order_Date) _Month_, COUNT(DISTINCT Cust_id) Monthly_Cust_Num_Retained_2012
FROM	timegap_monthly A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	timegap_monthly B
WHERE	DATENAME(year, Order_Date) = '2012'
AND		DATENAME(month, Order_Date) = 'January'
AND		A.Cust_id = B.Cust_id
)
AND	DATENAME(year, Order_Date) = '2012'
GROUP BY DATENAME(month, Order_Date)

SELECT * FROM retained_cus_2012

--//////////////////////
SELECT * FROM retained_cus_2009;
SELECT * FROM retained_cus_2010;
SELECT * FROM retained_cus_2011;
SELECT * FROM retained_cus_2012;
--//////////////////////


--2. Calculate the month-wise retention rate.

--Basic formula: o	Month-Wise Retention Rate = 1.0 * Number of Customers Retained in The Current Month / Total Number of Customers in the Current Month

--It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
--You can also use CTE or Subquery if you want.

--You should pay attention to the join type and join columns between your views or tables.


--////2009 Yýlý Ýçerindeki Aylýk Müþteri Sayýsý

SELECT  DATENAME(month, Order_Date) mounths_, COUNT (DISTINCT Cust_id) count_num_in_month
FROM	timegap_monthly
WHERE	DATENAME(year, Order_Date) = '2009'
GROUP BY DATENAME(month, Order_Date)

--///2009 Yýlý Aylýk Retained Müþteriler
SELECT * FROM retained_cus_2009;


--///Month-Wise Retention Rate in 2009
WITH T1 AS (
	SELECT  DATENAME(month, Order_Date) month_, COUNT (DISTINCT Cust_id) total_monthly_count_num_in_2009
	FROM	timegap_monthly
	WHERE	DATENAME(year, Order_Date) = '2009'
	GROUP BY DATENAME(month, Order_Date)
	)
SELECT A.month_, 1.0 * (Monthly_Cust_Num_Retained_2009 / total_monthly_count_num_in_2009)
FROM T1 A, retained_cus_2009 B
WHERE A.month_ = B._Month_

