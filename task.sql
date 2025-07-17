-- Database Normalization Task
-- ShopDB - Online Shop Database (3NF Normalized)

-- Drop the database if it exists
DROP DATABASE IF EXISTS ShopDB;

-- Create the database
CREATE DATABASE ShopDB;
USE ShopDB;

-- Create Countries table (already in 3NF)
CREATE TABLE Countries (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL UNIQUE
);

-- Create Products table (2NF: separate product information)
CREATE TABLE Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL UNIQUE
);

-- Create Warehouses table (2NF: separate warehouse information)
CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    WarehouseName VARCHAR(255) NOT NULL,
    WarehouseAddress VARCHAR(255) NOT NULL,
    CountryID INT NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID),
    UNIQUE KEY unique_warehouse (WarehouseName, WarehouseAddress)
);

-- Create ProductInventory table (3NF: only inventory-specific data)
CREATE TABLE ProductInventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    WarehouseID INT NOT NULL,
    Amount INT NOT NULL DEFAULT 0,
    FOREIGN KEY (ProductID) REFERENCES Products(ID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID),
    UNIQUE KEY unique_product_warehouse (ProductID, WarehouseID)
);

-- Insert test data into Countries
INSERT INTO Countries (Name) VALUES
('Ukraine'),
('Poland'),
('Germany'),
('USA'),
('France');

-- Insert test data into Products
INSERT INTO Products (ProductName) VALUES
('Laptop Dell XPS 13'),
('iPhone 14 Pro'),
('Samsung Galaxy S23'),
('MacBook Pro 16'),
('iPad Air'),
('Surface Pro 9'),
('Sony WH-1000XM4'),
('Nintendo Switch'),
('AirPods Pro'),
('Gaming Mouse Logitech');

-- Insert test data into Warehouses
INSERT INTO Warehouses (WarehouseName, WarehouseAddress, CountryID) VALUES
('Main Warehouse Kyiv', '123 Khreshchatyk St, Kyiv', 1),
('Warehouse Lviv', '456 Svobody Ave, Lviv', 1),
('Warehouse Odesa', '789 Deribasivska St, Odesa', 1),
('Warsaw Central', '321 Marszałkowska St, Warsaw', 2),
('Krakow Storage', '654 Floriańska St, Krakow', 2),
('Berlin Storage', '987 Unter den Linden, Berlin', 3),
('Munich Depot', '147 Marienplatz, Munich', 3),
('New York Depot', '258 Broadway, New York', 4),
('Chicago Hub', '369 Michigan Ave, Chicago', 4),
('Paris Central', '741 Champs-Élysées, Paris', 5);

-- Insert test data into ProductInventory
INSERT INTO ProductInventory (ProductID, WarehouseID, Amount) VALUES
-- Kyiv warehouse (ID: 1)
(1, 1, 50),  -- Laptop Dell XPS 13
(2, 1, 30),  -- iPhone 14 Pro
(3, 1, 25),  -- Samsung Galaxy S23
(4, 1, 15),  -- MacBook Pro 16
(5, 1, 40),  -- iPad Air
(7, 1, 20),  -- Sony WH-1000XM4

-- Lviv warehouse (ID: 2)
(1, 2, 20),  -- Laptop Dell XPS 13
(2, 2, 40),  -- iPhone 14 Pro
(5, 2, 35),  -- iPad Air
(8, 2, 25),  -- Nintendo Switch
(9, 2, 30),  -- AirPods Pro

-- Odesa warehouse (ID: 3)
(3, 3, 45),  -- Samsung Galaxy S23
(6, 3, 18),  -- Surface Pro 9
(7, 3, 22),  -- Sony WH-1000XM4
(10, 3, 35), -- Gaming Mouse Logitech

-- Warsaw warehouse (ID: 4)
(3, 4, 60),  -- Samsung Galaxy S23
(4, 4, 20),  -- MacBook Pro 16
(6, 4, 45),  -- Surface Pro 9
(8, 4, 30),  -- Nintendo Switch

-- Krakow warehouse (ID: 5)
(1, 5, 25),  -- Laptop Dell XPS 13
(2, 5, 35),  -- iPhone 14 Pro
(9, 5, 40),  -- AirPods Pro
(10, 5, 50), -- Gaming Mouse Logitech

-- Berlin warehouse (ID: 6)
(1, 6, 80),  -- Laptop Dell XPS 13
(4, 6, 30),  -- MacBook Pro 16
(5, 6, 25),  -- iPad Air
(7, 6, 35),  -- Sony WH-1000XM4

-- Munich warehouse (ID: 7)
(2, 7, 45),  -- iPhone 14 Pro
(3, 7, 40),  -- Samsung Galaxy S23
(6, 7, 28),  -- Surface Pro 9
(8, 7, 22),  -- Nintendo Switch

-- New York warehouse (ID: 8)
(2, 8, 100), -- iPhone 14 Pro
(4, 8, 50),  -- MacBook Pro 16
(6, 8, 75),  -- Surface Pro 9
(9, 8, 60),  -- AirPods Pro

-- Chicago warehouse (ID: 9)
(1, 9, 40),  -- Laptop Dell XPS 13
(3, 9, 55),  -- Samsung Galaxy S23
(5, 9, 30),  -- iPad Air
(10, 9, 45), -- Gaming Mouse Logitech

-- Paris warehouse (ID: 10)
(4, 10, 35), -- MacBook Pro 16
(5, 10, 28), -- iPad Air
(7, 10, 40), -- Sony WH-1000XM4
(8, 10, 20), -- Nintendo Switch
(9, 10, 33); -- AirPods Pro