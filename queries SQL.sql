-- =====================================================
-- SQL QUERIES
-- =====================================================

use mechanic_workshop;

-- 1. SIMPLE SELECT STATEMENT
-- Question: List all registered customers in the workshop
SELECT idCustomer, firstName, lastName, phone, email FROM customer;

-- Question: Show all open service orders
SELECT idServiceOrder, emissionDate, status FROM service_order WHERE status = 'Open';

-- 2. FILTERS WITH WHERE STATEMENT
-- Question: Which vehicles have mileage above 50,000 km?
SELECT model, brand, year, mileage 
FROM vehicle 
WHERE mileage > 50000;

-- Question: Which parts are below minimum stock level?
SELECT partName, stock, minStock 
FROM part 
WHERE stock < minStock;

-- 3. DERIVED ATTRIBUTES
-- Question: What is the average value of services provided?
SELECT 
    AVG(standardValue) AS AverageServiceValue,
    MIN(standardValue) AS LowestValue,
    MAX(standardValue) AS HighestValue
FROM service;

-- Question: Calculate the potential profit from parts in stock
SELECT 
    partName,
    stock,
    unitValue,
    (stock * unitValue) AS TotalStockValue
FROM part
ORDER BY TotalStockValue DESC;

-- 4. ORDERING WITH ORDER BY
-- Question: List the most expensive services first
SELECT serviceName, standardValue, estimatedTime 
FROM service 
ORDER BY standardValue DESC;

-- Question: Customers ordered by registration date (most recent first)
SELECT firstName, lastName, registrationDate, phone 
FROM customer 
ORDER BY registrationDate DESC;

-- 5. FILTERING WITH HAVING STATEMENT
-- Question: Which customers have more than 2 registered vehicles?
SELECT 
    c.idCustomer,
    c.firstName,
    c.lastName,
    COUNT(v.idVehicle) AS VehicleQuantity
FROM customer c
INNER JOIN vehicle v ON c.idCustomer = v.idCustomer
GROUP BY c.idCustomer, c.firstName, c.lastName
HAVING COUNT(v.idVehicle) > 1;

-- Question: Mechanics who performed more than 2 services
SELECT 
    m.idMechanic,
    m.firstName,
    m.lastName,
    COUNT(sos.idService) AS TotalServices
FROM mechanic m
INNER JOIN service_order_service sos ON m.idMechanic = sos.idMechanic
GROUP BY m.idMechanic, m.firstName, m.lastName
HAVING COUNT(sos.idService) > 2;

-- 6. COMPLEX JOINS
-- Question: Complete service order details (vehicle + customer + services + parts)
SELECT 
    so.idServiceOrder,
    c.firstName AS CustomerFirstName,
    c.lastName AS CustomerLastName,
    v.model,
    v.licensePlate,
    so.emissionDate,
    so.status,
    s.serviceName,
    sos.quantity AS ServiceQuantity,
    sos.unitValue AS ServiceUnitValue,
    p.partName,
    sop.quantity AS PartQuantity,
    sop.unitValue AS PartUnitValue,
    so.totalValue
FROM service_order so
INNER JOIN vehicle v ON so.idVehicle = v.idVehicle
INNER JOIN customer c ON v.idCustomer = c.idCustomer
LEFT JOIN service_order_service sos ON so.idServiceOrder = sos.idServiceOrder
LEFT JOIN service s ON sos.idService = s.idService
LEFT JOIN service_order_part sop ON so.idServiceOrder = sop.idServiceOrder
LEFT JOIN part p ON sop.idPart = p.idPart
ORDER BY so.idServiceOrder, so.emissionDate DESC;

-- Question: How much has each customer spent at the workshop?
SELECT 
    c.idCustomer,
    c.firstName,
    c.lastName,
    COUNT(DISTINCT so.idServiceOrder) AS TotalOrders,
    COALESCE(SUM(so.totalValue), 0) AS TotalSpent
FROM customer c
LEFT JOIN vehicle v ON c.idCustomer = v.idCustomer
LEFT JOIN service_order so ON v.idVehicle = so.idVehicle
GROUP BY c.idCustomer, c.firstName, c.lastName
ORDER BY TotalSpent DESC;

-- Question: Mechanics and their specialties (3-table join)
SELECT 
    m.firstName AS MechanicFirstName,
    m.lastName AS MechanicLastName,
    s.specialtyName AS Specialty,
    ms.level AS Level
FROM mechanic m
INNER JOIN mechanic_specialty ms ON m.idMechanic = ms.idMechanic
INNER JOIN specialty s ON ms.idSpecialty = s.idSpecialty
ORDER BY m.firstName, ms.level DESC;

-- Question: Most frequently performed services (with quantity)
SELECT 
    s.serviceName,
    COUNT(sos.idService) TimesExecuted,
    SUM(sos.subtotal) AS TotalRevenue
FROM service s
LEFT JOIN service_order_service sos ON s.idService = sos.idService
GROUP BY s.idService, s.serviceName
ORDER BY TimesExecuted DESC;

-- Question: Most used parts in service orders
SELECT 
    p.partName,
    SUM(sop.quantity) AS TotalUsed,
    SUM(sop.subtotal) AS TotalSoldValue,
    p.stock AS CurrentStock
FROM part p
INNER JOIN service_order_part sop ON p.idPart = sop.idPart
GROUP BY p.idPart, p.partName, p.stock
ORDER BY TotalUsed DESC;