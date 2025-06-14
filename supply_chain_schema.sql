
CREATE DATABASE Supply_Chain_System;
USE Supply_Chain_System;

CREATE TABLE Carriers (
    carrier_id INT PRIMARY KEY,
    name VARCHAR(200),
    type VARCHAR(50), -- air, land, sea
    contact_info VARCHAR(200)
);

CREATE TABLE Warehouses (
    warehouse_id INT PRIMARY KEY,
    location VARCHAR(200),
    capacity FLOAT
);

CREATE TABLE Clients (
    client_id INT PRIMARY KEY,
    name VARCHAR(200),
    address VARCHAR(300)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(200),
    role VARCHAR(100),
    assigned_warehouse_id INT,
    assigned_carrier_id INT,
    CHECK (
        (assigned_warehouse_id IS NULL AND assigned_carrier_id IS NOT NULL) OR
        (assigned_warehouse_id IS NOT NULL AND assigned_carrier_id IS NULL)
    ),
    FOREIGN KEY (assigned_warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (assigned_carrier_id) REFERENCES Carriers(carrier_id)
);

CREATE TABLE Shipments (
    shipment_id INT PRIMARY KEY,
    origin VARCHAR(200),
    destination VARCHAR(200),
    weight FLOAT,
    content_description TEXT,
    shipment_date DATE,
    sender_id INT,
    receiver_id INT,
    FOREIGN KEY (sender_id) REFERENCES Clients(client_id),
    FOREIGN KEY (receiver_id) REFERENCES Clients(client_id)
);

CREATE TABLE ShipmentRoutes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT,
    carrier_id INT,
    leg_order INT,
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id),
    FOREIGN KEY (carrier_id) REFERENCES Carriers(carrier_id)
);

CREATE TABLE ShipmentWarehouseHistory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    shipment_id INT,
    warehouse_id INT,
    timestamp DATETIME,
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id)
);

-- Carriers
INSERT INTO Carriers VALUES 
(1, 'DHL Express', 'air', 'dhl@example.com'),
(2, 'BlueDart Logistics', 'land', 'bluedart@example.com'),
(3, 'Maersk Line', 'sea', 'maersk@example.com');

-- Warehouses
INSERT INTO Warehouses VALUES 
(1, 'New York', 1000),
(2, 'Los Angeles', 1500),
(3, 'Mumbai', 2000);

-- Clients
INSERT INTO Clients VALUES 
(1, 'Alice Corp', 'New York'),
(2, 'Bob Ltd', 'London'),
(3, 'Charlie Inc', 'Tokyo');

-- Employees
INSERT INTO Employees VALUES 
(1, 'John Smith', 'Warehouse Staff', 1, NULL),
(2, 'Emily Jones', 'Carrier Crew', NULL, 1);

-- Shipments
INSERT INTO Shipments VALUES 
(101, 'New York', 'London', 500, 'Electronics', '2025-06-14', 1, 2),
(102, 'Mumbai', 'Tokyo', 700, 'Pharmaceuticals', '2025-06-13', 3, 1);

-- Shipment Routes
INSERT INTO ShipmentRoutes (shipment_id, carrier_id, leg_order) VALUES 
(101, 1, 1),
(101, 2, 2),
(102, 3, 1);

-- Shipment Warehouse History
INSERT INTO ShipmentWarehouseHistory (shipment_id, warehouse_id, timestamp) VALUES 
(101, 1, '2025-06-14 09:00:00'),
(101, 2, '2025-06-14 13:00:00'),
(102, 3, '2025-06-13 10:00:00');
