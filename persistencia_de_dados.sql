-- =====================================================
-- DATA INSERTION FOR TESTING
-- =====================================================

use mechanic_workshop;

-- Inserting Customers
INSERT INTO customer (firstName, lastName, address, phone, email, cpf) VALUES
('Joao', 'Silva', 'Rua A, 123 - Sao Paulo/SP', '11987654321', 'joao@email.com', '12345678901'),
('Maria', 'Santos', 'Av B, 456 - Rio de Janeiro/RJ', '21987654321', 'maria@email.com', '23456789012'),
('Carlos', 'Oliveira', 'Rua C, 789 - Belo Horizonte/MG', '31987654321', 'carlos@email.com', '34567890123'),
('Ana', 'Pereira', 'Praca D, 101 - Curitiba/PR', '41987654321', 'ana@email.com', '45678901234');
 
 select * from customer;
 
-- Inserting Vehicles
INSERT INTO vehicle (idCustomer, licensePlate, model, brand, year, color, mileage) VALUES
(5, 'ABC1D23', 'Civic', 'Honda', 2020, 'Silver', 45000),
(5, 'XYZ9E87', 'Fit', 'Honda', 2018, 'White', 78000),
(6, 'MNO4F56', 'Corolla', 'Toyota', 2021, 'Black', 23000),
(7, 'JKL7G89', 'Gol', 'Volkswagen', 2019, 'Red', 52000),
(8, 'QWE2H34', 'Onix', 'Chevrolet', 2022, 'Blue', 12000);

-- Inserting Mechanics
INSERT INTO mechanic (firstName, lastName, address, phone, salary, hireDate) VALUES
('Roberto', 'Alves', 'Rua dos Mecanicos, 100', '11912345678', 3500.00, '2020-01-15'),
('Fernando', 'Lima', 'Av das Oficinas, 200', '11923456789', 4200.00, '2019-03-10'),
('Ricardo', 'Souza', 'Praca do Automovel, 300', '11934567890', 3800.00, '2021-06-20');

-- Inserting Specialties
INSERT INTO specialty (specialtyName, description) VALUES
('Engine', 'Engine repairs and maintenance'),
('Suspension', 'Suspension and steering system'),
('Electrical', 'Electrical and electronic system'),
('Brakes', 'Brake system'),
('Air conditioning', 'Automotive air conditioning maintenance');

-- Associating Mechanics to Specialties
INSERT INTO mechanic_specialty (idMechanic, idSpecialty, level) VALUES
(1, 1, 'Senior'),
(1, 2, 'Pleno'),
(2, 3, 'Senior'),
(2, 4, 'Pleno'),
(3, 1, 'Junior'),
(3, 5, 'Pleno');

-- Inserting Services
INSERT INTO service (serviceName, description, standardValue, estimatedTime) VALUES
('Oil change', 'Engine oil and filter change', 150.00, '01:00'),
('Full review', 'Complete system review', 500.00, '04:00'),
('Alignment and balancing', 'Steering alignment and wheel balancing', 120.00, '01:30'),
('Brake pads replacement', 'Front brake pads replacement', 250.00, '02:00'),
('Engine repair', 'Engine problem diagnosis and repair', 800.00, '06:00');

-- Inserting Parts
INSERT INTO part (partName, description, unitValue, stock, minStock) VALUES
('Oil 5W30', 'Synthetic oil 5W30 (1 liter)', 45.00, 50, 10),
('Oil filter', 'Engine oil filter', 25.00, 30, 8),
('Brake pad', 'Set of front brake pads', 120.00, 20, 5),
('Timing belt', 'Engine timing belt', 180.00, 15, 3),
('Battery 60Ah', 'Automotive battery 60Ah', 350.00, 10, 2);

-- Inserting Service Orders
INSERT INTO service_order (idVehicle, emissionDate, status, observations) VALUES
(1, '2024-01-10 09:00:00', 'Completed', 'Customer complained about engine noise'),
(2, '2024-01-15 14:30:00', 'In progress', '80,000km review'),
(3, '2024-01-20 11:00:00', 'Waiting parts', 'Timing belt replacement'),
(4, '2024-02-01 08:15:00', 'Completed', 'Worn brakes'),
(5, '2024-02-05 16:45:00', 'Open', 'Oil change and review');

-- Inserting Services performed in Service Orders
INSERT INTO service_order_service (idServiceOrder, idService, idMechanic, quantity, unitValue, subtotal) VALUES
(1, 5, 1, 1, 800.00, 800.00),
(2, 2, 2, 1, 500.00, 500.00),
(3, 5, 3, 1, 800.00, 800.00),
(4, 4, 2, 1, 250.00, 250.00),
(5, 1, 1, 1, 150.00, 150.00);

-- Inserting Parts used in Service Orders
INSERT INTO service_order_part (idServiceOrder, idPart, quantity, unitValue, subtotal) VALUES
(1, 4, 1, 180.00, 180.00),
(2, 1, 4, 45.00, 180.00),
(2, 2, 1, 25.00, 25.00),
(3, 4, 1, 180.00, 180.00),
(4, 3, 2, 120.00, 240.00),
(5, 1, 4, 45.00, 180.00),
(5, 2, 1, 25.00, 25.00);

-- Updating total value of Service Orders
UPDATE service_order SET totalValue = (
    SELECT COALESCE(SUM(subtotal), 0) FROM service_order_service WHERE service_order_service.idServiceOrder = service_order.idServiceOrder
) + (
    SELECT COALESCE(SUM(subtotal), 0) FROM service_order_part WHERE service_order_part.idServiceOrder = service_order.idServiceOrder
);