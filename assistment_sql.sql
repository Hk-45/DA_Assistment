create table SalesMain(
	OrderID varchar(50),
	OrderDate Date,
	CustomerID varchar(50),
	CustomerName varchar(150),
	Region varchar(50),
	Country varchar(50),
	ProductID varchar (50),
	ProductName varchar(50),
	Category varchar(100),
	Quantity int,
	UnitPrice double precision,
	TotalPrice double precision,
	Discount double precision,
	Profit double precision
)

copy SalesMain from 'D:\Data-Analyst9\assistment\Assistment_today\Data\Sales_main.csv' DELIMITER ',' csv header

select * from SalesMain
	
Create table Customers (
    CustomerID VARCHAR(10),
    CustomerName VARCHAR(50),
    Region VARCHAR(50),
    Country VARCHAR(50)
);

copy Customers from 'D:\Data-Analyst9\assistment\Assistment_today\Data\customer.csv' DELIMITER ',' csv header

select * from customers

create table Orders (
    OrderID VARCHAR(50),
    OrderDate DATE,
    CustomerID VARCHAR(50),
	ProductID varchar(50)
)

copy Orders from 'D:\Data-Analyst9\assistment\Assistment_today\Data\order.csv' DELIMITER ',' csv header

select * from Orders

create table Sales (
    SaleID SERIAL PRIMARY KEY,
    OrderID varchar(50),
	CustomerID varchar(50),
	ProductID varchar(50),
	quantity int,
	unitPrice double precision,
    TotalPrice double precision ,
    Discount double precision,
    Profit double precision
)

copy Sales from 'D:\Data-Analyst9\assistment\Assistment_today\Data\sales.csv' DELIMITER ',' csv header


select * from Sales

create table Region (
	RegionID serial Primary key,
	Region varchar(50),
	Country varchar(50)
)

copy Region from 'D:\Data-Analyst9\assistment\Assistment_today\Data\region.csv' DELIMITER ',' csv header

select * from Region

create table Products(
	ProductID varchar(50),
	ProductName varchar(50),
	Category varchar(50),
	Quantity int,
	UnitPrice double precision,
	Profit double precision
)

copy Products from 'D:\Data-Analyst9\assistment\Assistment_today\Data\Products.csv' DELIMITER ',' csv header

select * from Products


--▪ CALCULATE MONTHLY AND QUARTERLY SALES GROWTH PERCENTAGE.

select OrderDate, to_char(OrderDate, 'Mon') as Month, 
sum(totalPrice) as total_Sales from SalesMain
group by 1,2

--RANK CUSTOMERS BASED ON REVENUE CONTRIBUTION USING RANK()AND NTILE()

select CustomerID, sum(TotalPrice) as totalRevenue,
Rank() over(order by sum(TotalPrice) DESC) as RankRenvenue,
Ntile(4) OVER (order by sum(TotalPrice)  DESC) AS RevenueQuartile from Sales
group by CustomerID

--FIND PRODUCTS WITH THE HIGHEST RETURNS AND LOWEST PROFIT MARGINS.

select ProductID, sum(quantity) as totalReturns, sum(Profit) as totalProfit,
sum(TotalPrice) as totalRevenue,
CASE 
    when sum(TotalPrice) > 0 then sum(Profit)/ sum(TotalPrice)
    else 0
End as ProfitMargin  from Sales
group by ProductID

--FIND PRODUCTS WITH THE HIGHEST RETURNS AND LOWEST PROFIT MARGINS.
--Product with Highest return
Select ProductName, sum(Quantity) AS TotalQuantity
from Products
Group by ProductName
Order by TotalQuantity DESC
Limit 1;

--Product with lowest profit 
Select ProductName, 
       avg(Profit / UnitPrice) AS AvgProfitMargin
from Products
Group by ProductName
Order by AvgProfitMargin ASC
Limit 1




