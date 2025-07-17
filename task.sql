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
('USA');

-- Insert test data into Products
INSERT INTO Products (ProductName) VALUES
('Laptop Dell XPS 13'),
('iPhone 14 Pro'),
('Samsung Galaxy S23'),
('MacBook Pro 16'),
('iPad Air'),
('Surface Pro 9');

-- Insert test data into Warehouses
INSERT INTO Warehouses (WarehouseName, WarehouseAddress, CountryID) VALUES
('Main Warehouse Kyiv', '123 Khreshchatyk St, Kyiv', 1),
('Warehouse Lviv', '456 Svobody Ave, Lviv', 1),
('Warsaw Central', '321 Marszałkowska St, Warsaw', 2),
('Berlin Storage', '987 Unter den Linden, Berlin', 3),
('New York Depot', '258 Broadway, New York', 4);

-- Insert test data into ProductInventory
INSERT INTO ProductInventory (ProductID, WarehouseID, Amount) VALUES
-- Minimal test data - exactly 5 records
(1, 1, 50),  -- Laptop Dell XPS 13 in Kyiv
(2, 2, 30),  -- iPhone 14 Pro in Lviv
(3, 3, 25),  -- Samsung Galaxy S23 in Warsaw
(4, 4, 15),  -- MacBook Pro 16 in Berlin
(5, 5, 40);  -- iPad Air in New York