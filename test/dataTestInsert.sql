CREATE DATABASE booking_food;

use booking_food;

CREATE TABLE Account(
	AccountID BIGINT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	Phone VARCHAR(15),
	RoleId BIGINT,
	Password VARCHAR(255)
	
);

CREATE TABLE Restaurant (
	RestaurantID BIGINT PRIMARY KEY AUTO_INCREMENT,
	RestaurantName VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	Image VARCHAR(255),
	Description VARCHAR (500),
	Status BOOLEAN DEFAULT 0
)

CREATE TABLE Review (
    ReviewID BIGINT PRIMARY KEY AUTO_INCREMENT,
    Rating INTEGER,
    Comment VARCHAR(500),
    Data DATE,
    RestaurantID BIGINT,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE Menu (
    MenuID INTEGER PRIMARY KEY AUTO_INCREMENT,
    RestaurantID INTEGER,
    Description VARCHAR(500),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE CommonCategory (
    CommonCategoryID INTEGER PRIMARY KEY AUTO_INCREMENT,
    CommonCategoryName VARCHAR(100),
    Image VARCHAR(255)
);

CREATE TABLE MenuCategory (
    MenuCategoryID INTEGER PRIMARY KEY AUTO_INCREMENT,
    MenuCategoryName VARCHAR(100),
    MenuID INTEGER,
    Image VARCHAR(255),
    CommonCategoryID INTEGER,
    FOREIGN KEY (MenuID) REFERENCES Menu(MenuID),
    FOREIGN KEY (CommonCategoryID) REFERENCES CommonCategory(CommonCategoryID)
);

CREATE TABLE Food (
    FoodID INTEGER PRIMARY KEY AUTO_INCREMENT,
    MenuCategoryID INTEGER,
    FoodName VARCHAR(100),
    Price INTEGER,
    Image VARCHAR(255),
    MenuExtraFoodID INTEGER,
    FOREIGN KEY (MenuCategoryID) REFERENCES MenuCategory(MenuCategoryID),
    FOREIGN KEY (MenuExtraFoodID) REFERENCES MenuExtraFood(MenuExtraFoodID)
);

CREATE TABLE MenuExtraFood (
    MenuExtraFoodID INTEGER PRIMARY KEY AUTO_INCREMENT,
    MenuExtraFoodName VARCHAR(100),
    Price INTEGER,
    Image VARCHAR(255)
);

CREATE TABLE `Order` (
    OrderID INTEGER PRIMARY KEY AUTO_INCREMENT,
    AccountID INTEGER,
    RestaurantID INTEGER,
    TotalCost INTEGER,
    Time DATE,
    OrderStatus BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

CREATE TABLE OrderDetail (
    OrderDetailID INTEGER PRIMARY KEY AUTO_INCREMENT,
    OrderID INTEGER,
    FoodID INTEGER,
    Quantity INTEGER,
    TotalPrice INTEGER,
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (FoodID) REFERENCES Food(FoodID)
);

CREATE TABLE ExtraOrderDetail (
    ExtraOrderDetailID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Quantity INTEGER,
    TotalPrice INTEGER,
    MenuExtraFoodID INTEGER,
    OrderDetailID INTEGER,
    FOREIGN KEY (MenuExtraFoodID) REFERENCES MenuExtraFood(MenuExtraFoodID),
    FOREIGN KEY (OrderDetailID) REFERENCES OrderDetail(OrderDetailID)
);

CREATE TABLE Coupon (
    CouponID INTEGER PRIMARY KEY AUTO_INCREMENT,
    CouponName VARCHAR(100),
    RestaurantID INTEGER,
    Discount INTEGER,
    Status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);


INSERT INTO Account (Name, Email, Phone, RoleID, Password) VALUES
('Nguyen Van A', 'a.nguyen@example.com', '0912345678', 1, 'pass123'),
('Tran Thi B', 'b.tran@example.com', '0912345679', 2, 'pass124'),
('Le Van C', 'c.le@example.com', '0912345680', 3, 'pass125'),
('Pham Thi D', 'd.pham@example.com', '0912345681', 4, 'pass126'),
('Hoang Van E', 'e.hoang@example.com', '0912345682', 5, 'pass127');

INSERT INTO Restaurant (RestaurantName, Address, Image, Description, Status) VALUES
('Nhà hàng A', '123 Đường A, TP.HCM', 'image1.jpg', 'Nhà hàng chuyên món Việt', TRUE),
('Nhà hàng B', '456 Đường B, Hà Nội', 'image2.jpg', 'Nhà hàng châu Âu', TRUE),
('Nhà hàng C', '789 Đường C, Đà Nẵng', 'image3.jpg', 'Nhà hàng hải sản', TRUE),
('Nhà hàng D', '321 Đường D, Nha Trang', 'image4.jpg', 'Nhà hàng Nhật Bản', TRUE),
('Nhà hàng E', '654 Đường E, Huế', 'image5.jpg', 'Nhà hàng Trung Hoa', TRUE);

INSERT INTO Review (Rating, Comment, Date, RestaurantID) VALUES
(4, 'Rất ngon, phục vụ tốt!', '2024-12-01', 1),
(5, 'Tuyệt vời, sẽ quay lại!', '2024-12-02', 2),
(3, 'Bình thường, cần cải thiện', '2024-12-03', 3),
(4, 'Thức ăn ngon, không gian đẹp', '2024-12-04', 4),
(5, 'Dịch vụ xuất sắc!', '2024-12-05', 5);

INSERT INTO Menu (RestaurantID, Description) VALUES
(1, 'Menu món Việt'),
(2, 'Menu châu Âu'),
(3, 'Menu hải sản'),
(4, 'Menu Nhật Bản'),
(5, 'Menu Trung Hoa');

INSERT INTO CommonCategory (CommonCategoryName, Image) VALUES
('Món chính', 'main_dish.jpg'),
('Món phụ', 'side_dish.jpg'),
('Đồ uống', 'drinks.jpg'),
('Tráng miệng', 'dessert.jpg'),
('Salad', 'salad.jpg');

INSERT INTO MenuCategory (MenuCategoryName, MenuID, Image, CommonCategoryID) VALUES
('Món chính Việt', 1, 'viet_main.jpg', 1),
('Món phụ Âu', 2, 'eu_side.jpg', 2),
('Hải sản', 3, 'seafood.jpg', 1),
('Món Nhật', 4, 'japan_dish.jpg', 1),
('Tráng miệng Trung', 5, 'china_dessert.jpg', 4);

INSERT INTO Food (MenuCategoryID, FoodName, Price, Image, MenuExtraFoodID) VALUES
(1, 'Phở bò', 50000, 'pho.jpg', 1),
(2, 'Salad rau', 30000, 'salad.jpg', 2),
(3, 'Cua biển', 150000, 'crab.jpg', 3),
(4, 'Sushi', 80000, 'sushi.jpg', 4),
(5, 'Chè Trung Hoa', 40000, 'che.jpg', 5);

INSERT INTO MenuExtraFood (MenuExtraFoodName, Price, Image) VALUES
('Nước mắm', 5000, 'nuocmam.jpg'),
('Dầu olive', 10000, 'olive.jpg'),
('Sốt tỏi', 7000, 'sottoi.jpg'),
('Wasabi', 6000, 'wasabi.jpg'),
('Trà xanh', 8000, 'tea.jpg');

INSERT INTO `Order` (AccountID, RestaurantID, TotalCost, Time, OrderStatus) VALUES
(1, 1, 150000, '2025-03-01', TRUE),
(2, 2, 120000, '2025-03-02', FALSE),
(3, 3, 200000, '2025-03-03', TRUE),
(4, 4, 180000, '2025-03-04', FALSE),
(5, 5, 140000, '2025-03-05', TRUE);

INSERT INTO OrderDetail (OrderID, FoodID, Quantity, TotalPrice) VALUES
(1, 1, 2, 100000),
(2, 2, 3, 90000),
(3, 3, 1, 150000),
(4, 4, 2, 160000),
(5, 5, 3, 120000);

INSERT INTO ExtraOrderDetail (Quantity, TotalPrice, MenuExtraFoodID, OrderDetailID) VALUES
(1, 5000, 1, 1),
(2, 20000, 2, 2),
(1, 7000, 3, 3),
(1, 6000, 4, 4),
(2, 16000, 5, 5);

INSERT INTO Coupon (CouponName, RestaurantID, Discount, Status) VALUES
('Giảm 10%', 1, 10, TRUE),
('Giảm 15%', 2, 15, TRUE),
('Giảm 20%', 3, 20, TRUE),
('Giảm 5%', 4, 5, TRUE),
('Giảm 12%', 5, 12, TRUE);
