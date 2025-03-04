CREATE DATABASE BookingFood;
GO
USE BookingFood;
GO



-- Thêm dữ liệu vào bảng Account
INSERT INTO Account VALUES 
('A001', 'John Doe', 'john@example.com', '0987654321', 1, 'pass123'),
('A002', 'Alice Tran', 'alice@example.com', '0912345678', 2, 'alice@123'),
('A003', 'Bob Smith', 'bob@example.com', '0933456789', 1, 'bobpass'),
('A004', 'Charlie P', 'charlie@example.com', '0976543210', 3, 'charlie@'),
('A005', 'David Kim', 'david@example.com', '0956789123', 2, 'david@321');

-- Thêm dữ liệu vào bảng Restaurant
INSERT INTO Restaurant VALUES 
('R001', 'Pizza Hut', '123 Main St', 'img1.jpg', '0123456789', 'Famous for Italian Pizza', 1),
('R002', 'KFC', '45 Street Ave', 'img2.jpg', '0234567891', 'Best Fried Chicken', 1),
('R003', 'Sushi Bar', '78 Ocean Rd', 'img3.jpg', '0345678912', 'Fresh Sushi & Sashimi', 1),
('R004', 'BBQ House', '99 BBQ Lane', 'img4.jpg', '0456789123', 'American-style BBQ', 1),
('R005', 'Vegan Delight', '11 Green St', 'img5.jpg', '0567891234', '100% Plant-based meals', 1);

-- Thêm dữ liệu vào bảng Menu
INSERT INTO Menu VALUES 
('M001', 'R001'), ('M002', 'R002'), ('M003', 'R003'), ('M004', 'R004'), ('M005', 'R005');

-- Thêm dữ liệu vào bảng CommonCategory
INSERT INTO CommonCategory VALUES 
('CC001', 'Fast Food', 'cc1.jpg'),
('CC002', 'Asian Cuisine', 'cc2.jpg'),
('CC003', 'Vegan', 'cc3.jpg'),
('CC004', 'BBQ', 'cc4.jpg'),
('CC005', 'Desserts', 'cc5.jpg');

-- Thêm dữ liệu vào bảng Coupon
INSERT INTO Coupon VALUES 
('C001', 'DISCOUNT10', 'R001', 10, 1),
('C002', 'SAVE20', 'R002', 20, 1),
('C003', 'LUNCHDEAL', 'R003', 15, 1),
('C004', 'BBQFEAST', 'R004', 25, 1),
('C005', 'VEGANLOVE', 'R005', 10, 1);

-- Thêm dữ liệu vào bảng Order
INSERT INTO [Order] VALUES 
('O001', 'A001', 'R001', 'C001', 150, '2024-03-01', 1),
('O002', 'A002', 'R002', 'C002', 180, '2024-03-02', 1),
('O003', 'A003', 'R003', 'C003', 120, '2024-03-03', 0),
('O004', 'A004', 'R004', 'C004', 250, '2024-03-04', 1),
('O005', 'A005', 'R005', 'C005', 100, '2024-03-05', 1);

-- Thêm dữ liệu vào bảng Review
INSERT INTO Review VALUES 
('R001', 5, 'Excellent pizza!', '2024-03-01', 'A001', 'R001'),
('R002', 4, 'Great chicken, crispy!', '2024-03-02', 'A002', 'R002'),
('R003', 3, 'Sushi was okay.', '2024-03-03', 'A003', 'R003'),
('R004', 5, 'Best BBQ in town!', '2024-03-04', 'A004', 'R004'),
('R005', 4, 'Good vegan options.', '2024-03-05', 'A005', 'R005');
