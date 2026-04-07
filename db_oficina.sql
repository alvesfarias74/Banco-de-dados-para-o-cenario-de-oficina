-- =====================================================
-- SCHEMA FOR CAR MECHANIC WORKSHOP (CORRIGIDO)
-- =====================================================
CREATE DATABASE mechanic_workshop;
USE mechanic_workshop;

-- Table Customer (CORRIGIDA)
CREATE TABLE customer (
    idCustomer INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    phone CHAR(15) NOT NULL,
    email VARCHAR(100),
    cpf CHAR(11) UNIQUE,
    registrationDate DATE DEFAULT (CURRENT_DATE)
);

-- Table Vehicle
CREATE TABLE vehicle (
    idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    idCustomer INT NOT NULL,
    licensePlate CHAR(8) UNIQUE NOT NULL,
    model VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    year INT,
    color VARCHAR(20),
    mileage INT DEFAULT 0,
    FOREIGN KEY (idCustomer) REFERENCES customer(idCustomer)
);

-- Table Mechanic
CREATE TABLE mechanic (
    idMechanic INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    address VARCHAR(255),
    phone CHAR(15) NOT NULL,
    salary DECIMAL(10,2),
    hireDate DATE
);

-- Table Specialty
CREATE TABLE specialty (
    idSpecialty INT AUTO_INCREMENT PRIMARY KEY,
    specialtyName VARCHAR(50) NOT NULL,
    description TEXT
);

-- Table Mechanic_Specialty
CREATE TABLE mechanic_specialty (
    idMechanic INT,
    idSpecialty INT,
    level ENUM('Junior', 'Pleno', 'Senior') DEFAULT 'Junior',
    PRIMARY KEY (idMechanic, idSpecialty),
    FOREIGN KEY (idMechanic) REFERENCES mechanic(idMechanic),
    FOREIGN KEY (idSpecialty) REFERENCES specialty(idSpecialty)
);

-- Table Service
CREATE TABLE service (
    idService INT AUTO_INCREMENT PRIMARY KEY,
    serviceName VARCHAR(100) NOT NULL,
    description TEXT,
    standardValue DECIMAL(10,2) NOT NULL,
    estimatedTime TIME
);

-- Table Part
CREATE TABLE part (
    idPart INT AUTO_INCREMENT PRIMARY KEY,
    partName VARCHAR(100) NOT NULL,
    description TEXT,
    unitValue DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    minStock INT DEFAULT 5
);

-- Table Service Order
CREATE TABLE service_order (
    idServiceOrder INT AUTO_INCREMENT PRIMARY KEY,
    idVehicle INT NOT NULL,
    emissionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    completionDate DATE,
    status ENUM('Open', 'In progress', 'Waiting parts', 'Completed', 'Cancelled') DEFAULT 'Open',
    totalValue DECIMAL(10,2) DEFAULT 0,
    observations TEXT,
    FOREIGN KEY (idVehicle) REFERENCES vehicle(idVehicle)
);

-- Table Service_Order_Service
CREATE TABLE service_order_service (
    idServiceOrder INT,
    idService INT,
    idMechanic INT,
    quantity INT DEFAULT 1,
    unitValue DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idServiceOrder, idService),
    FOREIGN KEY (idServiceOrder) REFERENCES service_order(idServiceOrder),
    FOREIGN KEY (idService) REFERENCES service(idService),
    FOREIGN KEY (idMechanic) REFERENCES mechanic(idMechanic)
);

-- Table Service_Order_Part
CREATE TABLE service_order_part (
    idServiceOrder INT,
    idPart INT,
    quantity INT DEFAULT 1,
    unitValue DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idServiceOrder, idPart),
    FOREIGN KEY (idServiceOrder) REFERENCES service_order(idServiceOrder),
    FOREIGN KEY (idPart) REFERENCES part(idPart)
);
show tables;