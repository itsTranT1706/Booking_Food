Create Database FoodOrder
go
Use FoodOrder
go

ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE  =  OFF;


Create Table [dbo].[Food](
	[FoodID] [int] IDENTITY(1,1) NOT NULL,
	[FoodName] [nvarchar](255) NOT NULL ,
	[Price] decimal (18,2) , 
	[Image] [varchar](255),
	[MenuCategoryID] [int] NOT NULL ,
	CONSTRAINT [FK_Food_MenuCategory] FOREIGN KEY (MenuCategoryID) REFERENCES MenuCategory(MenuCategoryID),
	 

	CONSTRAINT [PK_Food] PRIMARY KEY CLUSTERED (
	[FoodID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]



Create Table [dbo].[Restaurant](
	[RestaurantID] [int] IDENTITY(1,1) NOT NULL , 
	[RestaurantName] [nvarchar](255)  NOT NULL , 
	[Address] [nvarchar](255) NOT NULL , 
	[Image] [varchar](255),
	[Contact] [varchar](255),
	[Description] [nvarchar](255)  , 
	[Status] [int] ,

	CONSTRAINT [PK_Restaurant] PRIMARY KEY CLUSTERED (
	[RestaurantID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]


Create Table [dbo].[Menu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL , 
	[MenuName] [nvarchar] (255) ,
	[RestaurantID] [int],

	CONSTRAINT [FK_Menu] FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),

	CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED (
	[MenuID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]

Create Table [dbo].[CommonCategory](
	[CommonCategoryID] [int] IDENTITY(1,1) NOT NULL ,
	[CommonCategoryName] [nvarchar](255) NOT NULL ,
	[Image] [varchar](255) ,
	
	CONSTRAINT [PK_CommonCategory] PRIMARY KEY CLUSTERED (
	[CommonCategoryID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]


Create Table [dbo].[MenuCategory](
	[MenuCategoryID] [int] IDENTITY(1,1) NOT NULL , 
	[MenuCategoryName] [nvarchar](255)  NOT NULL ,
	[MenuID] [int],
	[Image] [varchar] (255),
	[CommonCategoryID] [int] ,

	CONSTRAINT [FK_MenuCategory_CommonCategory] FOREIGN KEY (CommonCategoryID) REFERENCES CommonCategory(CommonCategoryID),
	CONSTRAINT [FK_MenuCategory_Menu] FOREIGN KEY (MenuID) REFERENCES Menu(MenuID),


	CONSTRAINT [PK_MenuCategory] PRIMARY KEY CLUSTERED (
	[MenuCategoryID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]



Create Table [dbo].[Account] (
	[AccountID] [int] IDENTITY(1,1) NOT NULL , 
	[Name] [nvarchar](255) NOT NULL , 
	[Email] [nvarchar](255) NOT NULL UNIQUE ,
	[Phone] [nvarchar](255) ,
	[RoleID] [int] , 
	[Password] [nvarchar] (255) , 

	CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED (
	[AccountID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]


Create Table [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL , 
    [TotalCost] decimal(18,2),
	[Timestamp] Time,
	[RestaurantID] [int] ,
	[CouponID] [int],
	[OrderStatus] [int], 
	CONSTRAINT [FK_Order_Restaurant] FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),
	CONSTRAINT [FK_Order_Coupon] FOREIGN KEY (CouponID) REFERENCES Coupon(CouponID),
	CONSTRAINT [FK_Order_Account] FOREIGN KEY (AccountID) REFERENCES Account(AccountID),


	CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED (
	[OrderID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]



Create Table [dbo].[OrderDetail](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,	
	[OrderID] [int],
	[Quantity] [int] ,
	[FoodID] [int],
	[Subtotal] decimal(18,2),
	CONSTRAINT [FK_OrderDetail] FOREIGN KEY (OrderID) REFERENCES [dbo].[Order](OrderID),

	CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED (
	[OrderDetailID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]
		


Create Table [dbo].[Coupon](
	[CouponID] [int] IDENTITY(1,1) NOT NULL,
	[CouponName] [nvarchar](255)  NOT NULL , 
	[RestaurantID] [int],
	[Discount] Decimal (18,2) ,
	[Status] [int] ,

	CONSTRAINT [FK_Coupon] FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),


	CONSTRAINT [PK_Coupon] PRIMARY KEY CLUSTERED (
	[CouponID] ASC 
	) WITH (PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]
 
Go 

Create Table [dbo].[Review](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL , 
	[Rating] [int] ,
	[Comment] [nvarchar](255) , 
	[Date] DATETIME ,
	[RestaurantID] [int],
	[AccountID] [int],

	CONSTRAINT [FK_Review_Restaurant] FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID),
	CONSTRAINT [FK_Review_Account] FOREIGN KEY (AccountID) REFERENCES Account(AccountID),


	CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED (
	[ReviewID] ASC
	) WITH (PAD_INDEX = OFF ,STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]


Create Table [dbo].[ExtraFood](
	[ExtraFoodID] [int] IDENTITY(1,1)  NOT NULL , 
	[ExtraFoodName] [nvarchar](255),
	[FoodID] [int] , 
	[Price] decimal(18,2),
	[Image] [varchar](255), 
	CONSTRAINT [FK_ExtraFood_Food] FOREIGN KEY (FoodID) REFERENCES Food(FoodID),
	CONSTRAINT [PK_ExtraFood] PRIMARY KEY CLUSTERED (
	[ExtraFoodID] ASC
	) WITH (PAD_INDEX = OFF ,STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]



Create Table [dbo].[ExtraFoodOrderDetail](
	[ExtraFoodOrderDetailID] [int] IDENTITY(1,1) NOT NULL , 
	[ExtraFoodID] [int] NOT NULL ,
	[OrderDetailID] [int] , 
	[Quantity] [int],
	[TotalPrice] decimal(18,2),
    CONSTRAINT [FK_ExtraFoodOrderDetail_ExtraFood] FOREIGN KEY (ExtraFoodID) REFERENCES ExtraFood(ExtraFoodID),
	CONSTRAINT [FK_ExtraFoodOrderDetail_OrderDetail] FOREIGN KEY (OrderDetailID) REFERENCES OrderDetail(OrderDetailID),



	CONSTRAINT [PK_ExtraFoodOrderDetail] PRIMARY KEY CLUSTERED (
	[ExtraFoodOrderDetailID] ASC
	) WITH (PAD_INDEX = OFF ,STATISTICS_NORECOMPUTE = OFF , IGNORE_DUP_KEY = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON) 
	ON [PRIMARY]
)   ON [PRIMARY]



------ Insert Restaurant ------ 

SET IDENTITY_INSERT [dbo].[Restaurant] ON

INSERT INTO [dbo].[Restaurant] (RestaurantID , RestaurantName, Address, Image , Contact, Description, Status)
VALUES
(1,N'Bánh Mì Hội An - BamiBread', N'Nguyễn Khuyến , Hội An', 'https://i.ex-cdn.com/vntravellive.com/files/news/2023/05/15/luu-ngay-5-quan-banh-mi-ngon-nen-thu-tai-sai-gon-151953.jpg', '123-456-7890', N'Bánh Mì , xôi cơm , thức ăn nhanh', 1),
(2,N'Matcha Vibe', N'15 Quốc Tự Giám', 'https://mms.img.susercontent.com/vn-11134513-7ras8-m4fmlizrv7yfa7@resize_ss1242x600!@crop_w1242_h600_cT', '987-654-3210', N'Trà Sữa', 1),
(3,N'Sushi World', N'368 Trần Hưng Đạo', 'https://sushiworld.com.vn/wp-content/uploads/2023/11/c.jpg', '456-789-1234', N'Fresh sushi and sashimi', 1),
(4,N'CocaHouse-Cơm Tấm Sườn Nướng', N'321 Thượng Lưu', 'https://bizweb.dktcdn.net/100/442/328/products/com-tam-suon-bi-cha-com-nieu-sai-gon.jpg?v=1721795428257', '654-321-9876', N'Cơm Tấm', 1),
(5,N'Vegan Bites', N'378 An Lưu', 'https://qul.imgix.net/3da4e05b-93c4-4d38-bd5c-3bb850cded81/665020_sld.jpg', '321-654-0987', N'Buffet chay - vegan food', 1),
(6,N'Roma Pizza', N'654 Trần Hưng Đạo', 'https://img.dominos.vn/phan-biet-pizza-kieu-my-va-kieu-y-2.jpg', '789-012-3456', N'Pizza - Thức ăn nhanh', 1);

SET IDENTITY_INSERT [dbo].[Restaurant] OFF

SET IDENTITY_INSERT [dbo].[Restaurant] ON
INSERT INTO [dbo].[Restaurant] (RestaurantID , RestaurantName, Address, Image, Contact, Description, Status)
VALUES
(6,N'Roma Pizza', N'654 Trần Hưng Đạo', 'https://img.dominos.vn/phan-biet-pizza-kieu-my-va-kieu-y-2.jpg', '789-012-3456', N'Pizza - Thức ăn nhanh', 1);
SET IDENTITY_INSERT [dbo].[Restaurant] OFF


SET IDENTITY_INSERT [dbo].[Restaurant] ON
INSERT INTO [dbo].[Restaurant] (RestaurantID , RestaurantName, Address, Image, Contact, Description, Status)
VALUES
(3,N'Sushi World', N'368 Trần Hưng Đạo', 'https://sushiworld.com.vn/wp-content/uploads/2023/11/c.jpg', '456-789-1234', N'Fresh sushi and sashimi', 1);
SET IDENTITY_INSERT [dbo].[Restaurant] OFF

------ Insert Account ------ 
SET IDENTITY_INSERT [dbo].[Account] ON
  INSERT INTO [dbo].[Account] ([AccountID],[Name] , [Email] , [Password] , [Phone], [RoleID]) Values (1,N'Admin', N'admin@gmail.com', N'123456', 0822082395 , 1)
  INSERT INTO [dbo].[Account] ([AccountID],[Name] , [Email] , [Password] , [Phone], [RoleID]) Values (2,N'Customer', N'customer@gmail.com', N'123456', 0999521452, 2)
  
SET IDENTITY_INSERT [dbo].[Account] OFF

------ Insert Menu ---------
SET IDENTITY_INSERT [dbo].[Menu] ON
INSERT INTO [dbo].[Menu] (MenuID , MenuName, RestaurantID)
VALUES
(1,N'BamiBread Menu', 1);
INSERT INTO [dbo].[Menu] (MenuID , MenuName, RestaurantID)
VALUES
(2,N'MatchaVibe Menu', 2);
INSERT INTO [dbo].[Menu] (MenuID , MenuName, RestaurantID)
VALUES
(3,N'SushiWorld Menu', 3);
INSERT INTO [dbo].[Menu] (MenuID , MenuName, RestaurantID )
VALUES
(4,N'CocaHouse Menu', 4);
INSERT INTO [dbo].[Menu] (MenuID , MenuName, RestaurantID)
VALUES
(5,N'Vegan Bites Menu', 5);
INSERT INTO [dbo].[Menu] (MenuID , MenuName, RestaurantID)
VALUES
(6,N'Roman Pizza Menu', 6);
SET IDENTITY_INSERT [dbo].[Menu] OFF

---------- Insert CommonCategory ------------
SET IDENTITY_INSERT [dbo].[CommonCategory] ON
INSERT INTO [dbo].[CommonCategory] (CommonCategoryID , CommonCategoryName, Image)
VALUES
(1,N'Bánh Mì', 'https://i.ex-cdn.com/vntravellive.com/files/news/2023/05/15/luu-ngay-5-quan-banh-mi-ngon-nen-thu-tai-sai-gon-151953.jpg');
INSERT INTO [dbo].[CommonCategory] (CommonCategoryID , CommonCategoryName, Image)
VALUES
(2,N'Trà, Trà Sữa & Coffe', 'https://abcsport.com.vn/image/catalog/2023/T01/mot-ly-tra-sua-bao-nhieu-calo-2.jpg');
INSERT INTO [dbo].[CommonCategory] (CommonCategoryID , CommonCategoryName, Image)
VALUES
(3,N'Nước Ép & Sinh tố', 'https://file.hstatic.net/200000261315/file/nuoc-ep-cam-va-thom_ee2bfb1c54e34cd08adf5ab498c3a3ec_grande.jpg');
INSERT INTO [dbo].[CommonCategory] (CommonCategoryID , CommonCategoryName, Image)
VALUES
(4,N'Thức ăn nhanh', 'https://vcdn1-suckhoe.vnecdn.net/2023/12/29/frontviewyummymeatcheeseburger-8242-1738-1703868855.jpg?w=500&h=300&q=100&dpr=2&fit=crop&s=5QgHBZmutfaZPWXjt0ZmMw');
INSERT INTO [dbo].[CommonCategory] (CommonCategoryID , CommonCategoryName, Image)
VALUES
(5,N'Cơm', 'https://www.order.capichiapp.com/_next/image?url=https%3A%2F%2Fcdn.capichiapp.com%2Frestaurants%2Fapp_images%2F000%2F001%2F932%2Flarge%2F23H05598-min.jpg%3F1690788395&w=3840&q=75');
INSERT INTO [dbo].[CommonCategory] (CommonCategoryID , CommonCategoryName, Image)
VALUES
(6,N'Sushi', 'https://file.hstatic.net/200000391061/article/sushi-mon-an-quoc-dan-cua-nguoi-nhat-2_c940b210a8094194b29216c31a3620d0_1024x1024.jpg');
SET IDENTITY_INSERT [dbo].[CommonCategory] OFF

---------- Insert Menu Category -------------
SET IDENTITY_INSERT [dbo].[MenuCategory] ON
INSERT INTO [dbo].[MenuCategory] (MenuCategoryID , MenuCategoryName, MenuID, Image,CommonCategoryID)
VALUES
(1,N'Bánh Mặn', 1, 'https://i.ex-cdn.com/vntravellive.com/files/news/2023/05/15/luu-ngay-5-quan-banh-mi-ngon-nen-thu-tai-sai-gon-151953.jpg', 1);
INSERT INTO [dbo].[MenuCategory] (MenuCategoryID , MenuCategoryName, MenuID ,Image,CommonCategoryID)
VALUES
(2,N'Bánh Mì Chay' ,1,'https://images2.thanhnien.vn/528068263637045248/2023/10/16/anh-man-hinh-2023-10-16-luc-114742-1697431732764984292212.png', 1);
INSERT INTO [dbo].[MenuCategory] (MenuCategoryID , MenuCategoryName, MenuID, Image,CommonCategoryID)
VALUES
(3,N'Trà', 1 ,'https://icdn.dantri.com.vn/zoom/1200_630/dansinh/2024/11/17/tra-thao-moc-1731844147767.jpg', 2 );
INSERT INTO [dbo].[MenuCategory] (MenuCategoryID , MenuCategoryName, MenuID, Image,CommonCategoryID)
VALUES
(4,N'Nước Ép', 1 , 'https://cdnphoto.dantri.com.vn/J9iymj1m6m9Z91MRFZUHgGzfVYk=/zoom/1200_630/2022/08/19/nuocep-crop-1660864747363.jpeg', 3);
INSERT INTO [dbo].[MenuCategory] (MenuCategoryID , MenuCategoryName, MenuID, Image,CommonCategoryID)
VALUES
(5,N'Cà Phê', 1,'https://nld.mediacdn.vn/291774122806476800/2024/2/29/untitleda-17091767983801914776073.jpg', 2);

SET IDENTITY_INSERT [dbo].[MenuCategory] OFF

---------------- Insert Food -----------------------
SET IDENTITY_INSERT [dbo].[Food] ON

INSERT INTO Food (FoodID, FoodName, Price, Image, MenuCategoryID) VALUES (1,N'Bánh mì thịt chả', 21000, 'https://i.ex-cdn.com/vntravellive.com/files/news/2023/05/15/luu-ngay-5-quan-banh-mi-ngon-nen-thu-tai-sai-gon-151953.jpg', 1);
INSERT INTO Food (FoodID, FoodName, Price, Image, MenuCategoryID) VALUES (2,N'Bánh mì xúc xích', 20000, 'https://nhulan.vn/thumbs_size/product/2021_07/banh-mi-xuc-xich_jpg/1000x800_zmax_banh-mi-xuc-xich.jpg', 1);
INSERT INTO Food (FoodID, FoodName, Price, Image, MenuCategoryID) VALUES (3,N'Bánh mì ốp la 2 trứng', 20000, 'https://img-global.cpcdn.com/recipes/01914f4be6cc4786/1200x630cq70/photo.jpg', 1);
INSERT INTO Food (FoodID, FoodName, Price, Image, MenuCategoryID) VALUES (4,N'Bánh mì thịt nướng', 20000, 'https://yummyday.vn/uploads/images/banh-mi-thit-nuong-6.jpg', 1);
INSERT INTO Food (FoodID, FoodName, Price, Image, MenuCategoryID) VALUES (5,N'Bánh mì không', 4000, 'https://giadinh.mediacdn.vn/296230595582509056/2022/11/15/an-banh-mi-1668497694495535125657.jpg', 2);
INSERT INTO Food (FoodID, FoodName, Price, Image, MenuCategoryID) VALUES (6,N'Bánh mì chả chay', 18000, 'https://thanhnien.mediacdn.vn/uploaded/minhnguyet/2016_11_02/banhmichay3_STOS.jpg?width=500', 2);


SET IDENTITY_INSERT [dbo].[Food] OFF


----------------- Insert Order ---------------------
SET IDENTITY_INSERT [dbo].[Order] ON
INSERT INTO [Order] (OrderID, AccountID, OrderStatus, TotalCost, Timestamp , RestaurantID )
VALUES 
(1, 1, 2, 200000, '2024-03-04'),
(2, 1, 1, 150000, '2024-03-03'),
(3, 2, 2, 180000, '2024-03-02');

SET IDENTITY_INSERT [dbo].[Order] OFF








----------------------- PROCEDURE -----------------------

-------------- uspGetRestaurantList ---------------
GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetRestaurantList]
AS
BEGIN
    SET NOCOUNT ON;
	
    
    SELECT	
        RestaurantID, 
        RestaurantName, 
        Address, 
        Image, 
        Contact, 
        Description, 
        Status
    FROM [dbo].[Restaurant]
    ORDER BY RestaurantID;
END

EXEC [dbo].[uspgetRestaurantList]


---------------- uspGetCommonCategory---------------

GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetCommonCategory]
AS
BEGIN
	SELECT
	CommonCategoryID,
	CommonCategoryName,
	Image
	FROM [dbo].[CommonCategory]
	Order By CommonCategoryID;
END

EXEC [dbo].[uspGetCommonCategory]

------------- uspGetFoodListByRestaurantID ------------
GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetFoodListByRestaurantID]
   @RestaurantID INT
AS
BEGIN
  Select 
  f.FoodID,
  f.FoodName,
  f.Image,
  f.MenuCategoryID,
  f.Price

  From [dbo].[Food] f 
  Inner join [dbo].[MenuCategory] mc ON f.MenuCategoryID = mc.MenuCategoryID
  Inner join [dbo].[Menu] m ON mc.MenuID = m.MenuID
  Inner join [dbo].[Restaurant] r ON m.RestaurantID = r.RestaurantID

  WHERE r.RestaurantID = @RestaurantID

END

EXEC uspGetFoodListByRestaurantID @RestaurantID = 1;

--------------- uspGetRestaurantListByCommonCategoryID ------------------
GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetRestaurantListByCommonCategoryID]
	@CommonCategoryID INT
AS
BEGIN
	Select Distinct
	r.RestaurantID,
	r.RestaurantName,
	r.Description,
	r.Image,
	r.Address,
	r.Contact,
	r.Status
	from [dbo].[Restaurant] r
Inner join [dbo].[Menu] m ON m.RestaurantID = r.RestaurantID
Inner join [dbo].[MenuCategory] mc ON mc.MenuID = m.MenuID
Inner join [dbo].[CommonCategory] cc ON cc.CommonCategoryID = mc.CommonCategoryID

WHERE cc.CommonCategoryID = @CommonCategoryID;

END
EXEC [dbo].[uspGetRestaurantListByCommonCategoryID] @CommonCategoryID=1;

--------------------- uspGetRestaurantListByRestaurantNameOrFoodName -----------------

GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetRestaurantListByRestaurantNameOrFoodName]
		@searchTerm [nvarchar](255)
As
BEGIN
	Select Distinct
	r.RestaurantID,
	r.RestaurantName,
	r.Image,
	r.Description,
	r.Contact,
	r.Status,
	r.Address
	FROM [dbo].[Restaurant] r
Left join [dbo].[Menu] m ON m.RestaurantID = r.RestaurantID
Left join [dbo].[MenuCategory] mc ON mc.MenuID = m.MenuID
Left join [dbo].[Food] f ON f.MenuCategoryID = mc.MenuCategoryID
WHERE r.RestaurantName LIKE '%'  + @searchTerm + '%'
OR f.FoodName LIKE '%' + @searchTerm + '%';

END
EXEC uspGetRestaurantListByRestaurantNameOrFoodName @SearchTerm = N'Bánh';



------------------- uspAddMenuCategory -------------------
GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAddMenuCategory]
    @MenuCategoryName NVARCHAR(255),
	@MenuID INT,
	@Image VARCHAR(255),
	@CommonCategoryID INT
AS 
BEGIN 
	INSERT INTO [dbo].[MenuCategory] (MenuCategoryName, MenuID , Image  , CommonCategoryID)
	Values (@MenuCategoryName , @MenuID, @Image, @CommonCategoryID)
END

-- Test the stored procedure
EXEC [dbo].[uspAddMenuCategory] @MenuCategoryName = N'Sashimi', @MenuID = 3, @Image = 'https://media.loveitopcdn.com/20960/sashimi-ca-ngu.jpg', @CommonCategoryID = 6;

DBCC CHECKIDENT ('MenuCategory', RESEED, 5); -- Đặt lại identity về 5 

Select * from [dbo].[MenuCategory]

------------------- uspAddExtraFood------------------
GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspAddExtraFood]
	@ExtraFoodName nvarchar(255),
	@FoodID INT,
	@Image varchar(255),
	@Price decimal(18,2)
AS
Begin
	Insert into [dbo].[ExtraFood] (ExtraFoodName , FoodID , Image , Price)
	Values (@ExtraFoodName, @FoodID , @Image , @Price)
END

EXEC [dbo].[uspAddExtraFood] @ExtraFoodName =N'Chả', @FoodID = 1 , @Image='https://patecotden.net/wp-content/uploads/2023/10/cha-mo-tam-3-2.png', @Price = 10000;


---------------- uspGetOrderDetailsByAccountIDAndStatus ----------------------------
GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetOrderByAccountIDAndOrderStatus]
    @AccountID INT,
	@OrderStatus INT
AS
BEGIN
    SET NOCOUNT ON;

	SELECT o.*   
	FROM [Order] o
    WHERE o.AccountID = @AccountID AND o.OrderStatus = @OrderStatus;
END

-- Test the stored procedure
EXEC uspGetOrderByAccountIDAndOrderStatus @AccountID = 2, @OrderStatus = 1;

---------------- uspGetOrderDetailByOrderID -------------

GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetOrderDetailByOrderID]
	@OrderID INT
AS
BEGIN
    SET NOCOUNT ON;

	SELECT od.*  , f.FoodName
	FROM [OrderDetail] od
	INNER JOIN [Order] o ON o.OrderID = od.OrderID
	INNER JOIN [Food] f ON f.FoodID = od.FoodID
    WHERE od.OrderID = @OrderID;
END 

EXEC [uspGetOrderDetailByOrderID] @OrderID = 2;
---------------- uspUpdateFood  ------------
GO
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateFood]
	@JInput Nvarchar(255) = NULL
AS
BEGIN 
	DECLARE @FoodID INT
	, @FoodName Nvarchar(255) 
	, @Price decimal(18,2)
	, @Image varchar(255)
	, @MenuCategoryID INT

	SELECT @FoodID = OJ.FOODID,
		   @FoodName = OJ.FOODNAME,
		   @Price = OJ.PRICE,
		   @Image = OJ.IMAGE,
		   @MenuCategoryID = OJ.MENUCATEGORYID

	FROM OPENJSON(@JInput)
	WITH(
		FOODID INT
		,FOODNAME nvarchar(255)
		,PRICE decimal(18,2)
		,IMAGE varchar(255)
		,MENUCATEGORYID INT
	) OJ

	DROP Table If EXISTS #FoodUpdate
	CREATE Table #FoodUpdate
	( FoodID INT,
	  FoodName nvarchar(255),
	  Price decimal(18,2),
	  Image varchar(255),
	  MenuCategoryID INT
	)

	SELECT @FoodID As FoodID,
		   @FoodName As FoodName,
		   @Price As Price,
		   @Image As Image , 
		   @MenuCategoryID As MenuCategoryID

	
	Insert into #FoodUpdate(
		FoodID,
		FoodName,
		Price,
		Image,
		MenuCategoryID
	)

	Select @FoodID As FoodID,
		   @FoodName As FoodName,
		   @Price As Price,
		   @Image As Image,
		   @MenuCategoryID As MenuCategoryID

	MERGE [dbo].[Food] AS TARGET
	USING #FoodUpdate AS SOURCE
	ON TARGET.FoodID = SOURCE.FoodID
	WHEN MATCHED THEN 
	Update SET TARGET.FoodName = SOURCE.FoodName,
				TARGET.Price = SOURCE.Price,
				TARGET.Image = SOURCE.Image,
				TARGET.MenuCategoryID = SOURCE.MenuCategoryID
	WHEN NOT MATCHED THEN
		Insert (
		FoodName , 
		Price , 
		Image,
		MenuCategoryID
		) values(
		SOURCE.FoodName,
		SOURCE.Price,
		SOURCE.Image,
		SOURCE.MenuCategoryID);

END

SELECT * FROM Food WHERE FoodID = 8;

----- Test Update ----------
DECLARE @JInput NVARCHAR(255) = 
N'{
    "FOODID": 8,
    "FOODNAME": "Bánh Mì Thịt Bò",
    "PRICE": 26000,
    "IMAGE": "https://banhmihanoi.net/wp-content/uploads/2020/05/banh-mi-bo-nuong-2.jpg",
    "MENUCATEGORYID": 1
}';


EXEC uspUpdateFood @JInput;

		PRINT 'Rows affected: ' + CAST(@@ROWCOUNT AS NVARCHAR(10));





------ Test Add ------------
DECLARE @JInput NVARCHAR(255) = 
N'{
    "FOODID": 8,
    "FOODNAME": "Bánh Mì Thịt Bò",
    "PRICE": 25000,
    "IMAGE": "https://banhmihanoi.net/wp-content/uploads/2020/05/banh-mi-bo-nuong-2.jpg",
    "MENUCATEGORYID": 1
}';

EXEC uspUpdateFood @JInput;
Select * from [dbo].[Food]



-------------- Insert for testing -------------------

SET IDENTITY_INSERT [dbo].[Order] ON

INSERT INTO [dbo].[Order] (OrderID, AccountID, TotalCost, Timestamp, RestaurantID, CouponID, OrderStatus)
VALUES 
(1, 2, 150000, '12:30:00', 1, NULL, 1),
(2, 2, 220000, '13:45:00', 3, NULL, 1),
(3, 1, 98000, '18:15:00', 5, NULL, 2);

SET IDENTITY_INSERT [dbo].[Order] OFF

-- Insert OrderDetail
SET IDENTITY_INSERT [dbo].[OrderDetail] ON

INSERT INTO [dbo].[OrderDetail] (OrderDetailID, OrderID, Quantity, FoodID, Subtotal)
VALUES 
(1, 1, 2, 3, 50000),
(2, 1, 1, 5, 50000),
(3, 2, 3, 7, 66000),
(4, 2, 2, 4, 88000),
(5, 3, 1, 2, 98000);

SET IDENTITY_INSERT [dbo].[OrderDetail] OFF

--- Chỉnh sửa bảng Order --------
-- Thêm cột mới với kiểu dữ liệu DATETIME
ALTER TABLE [dbo].[Order]
ADD Timestamp_New DATETIME;

-- Sao chép dữ liệu từ cột cũ sang cột mới
UPDATE [dbo].[Order] 
SET Timestamp_New = CAST(Timestamp AS DATETIME);

-- Xóa cột cũ
ALTER TABLE [dbo].[Order]
DROP COLUMN Timestamp;

-- Đổi tên cột mới thành Timestamp
EXEC sp_rename 'dbo.Order.Timestamp_New', 'Timestamp', 'COLUMN';






