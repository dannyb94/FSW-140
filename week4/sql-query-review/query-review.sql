USE SalesOrders;
-- 1. Show all the information on our customers.
SELECT * FROM Customers;

-- 2. Show a list of states, in reverse alphabetical order, where our vendors are located, and include the names of the vendor.
SELECT * FROM Vendors ORDER BY VendState DESC;

-- 3. What if we adjusted the retail price of each product by increasing it 7 percent?
UPDATE Products SET RetailPrice = RetailPrice + (RetailPrice * 1.7);
SELECT * FROM Products;

-- 4. Show a list of orders made by each customer in ascending date order.
SELECT Customers.CustomerID, Customers.CustFirstName, Orders.OrderNumber, Orders.OrderDate FROM Customers, Orders
ORDER BY OrderDate ASC;

-- 5. Give the names of all vendors based in Albany, Anchorage, and Dallas.
SELECT * FROM Vendors WHERE VendCity = 'Albany' OR VendCity = 'Anchorage' OR  VendCity ='Dallas';

-- 6. Show an alphabetized list of products with a quantity on hand greater than or equal to 30.
SELECT * FROM Products WHERE QuantityOnHand >= 30 ORDER BY Productname ASC;

-- 7. What vendors do we work with that don’t have an email address?
SELECT VendName, VendEMailAddress FROM Vendors WHERE VendEMailAddress IS NULL;

-- 8. List employees and the dates their orders shipped sorted by order date.
SELECT Employees.EmployeeID, Employees.EmpFirstName, Employees.EmpLastName, Orders.OrderNumber, Orders.OrderDate FROM Employees, Orders ORDER BY OrderDate ASC ;

-- 9. Show the vendors and products they supply to us for products over $75 for vendors in Texas.
SELECT * FROM Vendors;
SELECT * FROM Product_Vendors;
SELECT Vendors.VendorID, Vendors.VendName, Vendors.VendState, Product_Vendors.WholesalePrice FROM Vendors, Product_Vendors
WHERE VendState = 'TX' AND WholesalePrice >= 75;

-- 10. Show employees who live in the same city and state as our vendors.
SELECT * FROM Employees;
SELECT * FROM Vendors;
SELECT VendName, VendCity, EmpFirstName, EmpCity FROM Vendors, Employees

-- 11. Display customers who have no sales rep (employees) in the same state.
SELECT * FROM Customers
SELECT * FROM Employees
SELECT CustomerID, CustFirstName

-- 12. What is the average quoted price of a helmet?
SELECT AVG(RetailPrice) FROM Products WHERE ProductName LIKE '%Helmet%';

-- 13. What was the date of the earliest ship date?
SELECT * FROM Orders ORDER BY ShipDate ASC LIMIT 1;

-- 14. What is the total amount (in dollars) of orders from the state of Oregon?
SELECT SUM(QuotedPrice) FROM Order_Details WHERE OrderNumber = ANY
(SELECT OrderNumber FROM Orders 
WHERE CustomerID =
ANY (SELECT CustomerID FROM Customers WHERE CustState = 'OR'
));

-- 15. Show each employee, the employee’s total sales (in dollars), the employee’s total sales item quantity,
-- and the average item sales price ordered by the employee’s average item sales price highest to lowest.

SELECT Employees.EmployeeID, Employees.EmpFirstName, Orders.OrderTotal FROM Employees, Orders;
SELECT * FROM Order_Details;
SELECT * FROM Employees;
SELECT * FROM Orders;

-- SELECT DISTINCT EmployeeID, EmpFirstName, average FROM  (
SELECT
     DISTINCT Employees.EmployeeID, Employees.EmpFirstName, t.orderNumber, t.sales, t.average, t.summedQuantity  FROM (
            SELECT  
				SUM(QuantityOrdered) AS summedQuantity,
				SUM(QuotedPrice) AS sales, 
                ROUND(AVG(ProductNumber)) as average , 
                orderNumber FROM order_details GROUP BY OrderNumber
                 ) t 
                 INNER JOIN Employees ON
                 (SELECT EmployeeID FROM Orders WHERE OrderNumber = t.OrderNumber) = Employees.EmployeeID
                 ORDER BY t.sales DESC;


#SELECT  
#	SUM(QuantityOrdered) AS summedQuantity,
#	SUM(QuotedPrice) AS sales, 
#    ROUND(AVG(ProductNumber)) as average , 
#    orderNumber FROM order_details GROUP BY OrderNumber 

#SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
#FROM Orders
#INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;