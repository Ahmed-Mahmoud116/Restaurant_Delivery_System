create table Customers(
CustomerID int primary key identity(1,1),
CustomerName nvarchar(40) not null check (len(trim(CustomerName)) <> ''),
CustomerEmail varchar(100) not null  check (len(trim(CustomerEmail)) <> ''),
CustomerAddress nvarchar(255) not null  check (len(trim(CustomerAddress)) <> ''),
CustomerPhone varchar(50) not null  check (len(trim(CustomerPhone)) <> '')
);
create table Restaurants(
RestaurantID int primary key identity(1,1),
RestaurantName nvarchar(100) not null  check (len(trim(RestaurantName)) <> ''),
RestaurantCity nvarchar(100) not null  check (len(trim(RestaurantCity)) <> ''),
RestaurantHotline varchar(50) not null  check (len(trim(RestaurantHotline)) <> '')
);
create table Meals(
MealID int primary key identity(1,1),
MealName nvarchar(100) not null  check (len(trim(MealName)) <> ''),
MealPrice decimal(10,2) not null check(MealPrice > 0),
FK_RestaurantID int not null,
foreign key(FK_RestaurantID) references Restaurants(RestaurantID)
);
create table Orders(
OrderID int primary key identity(1,1),
OrderDate datetime not null default getdate(),
OrderState varchar(30) not null check(OrderState in ('Pending','Delivered','Cancelled')),
FK_CustomerID int not null,
foreign key(FK_CustomerID) references Customers(CustomerID)
);
create table OrderedMeals(
OrderedMealID int primary key identity(1,1),
FK_OrderID int not null,
FK_MealID int not null,
foreign key(FK_OrderID) references Orders(OrderID),
foreign key(FK_MealID) references Meals(MealID)
);
create table Drivers(
DriverID int primary key identity(1,1),
DriverName nvarchar(100) not null  check (len(trim(DriverName)) <> ''),
DriverPhone varchar(50) not null  check (len(trim(DriverPhone)) <> ''),
ManagerID int null,
FOREIGN KEY (ManagerID) REFERENCES Drivers(DriverID)
);
INSERT INTO Customers
    (CustomerName, CustomerEmail, CustomerAddress, CustomerPhone)
VALUES
    ('Ahmed Ali', 'ahmed@gmail.com', 'Minya, Egypt', '01011111111'),
    ('Omar Hassan', 'omar@gmail.com', 'Cairo, Egypt', '01022222222'),
    ('Mohamed Adel', 'mohamed@gmail.com', 'Giza, Egypt', '01033333333'),
    ('Youssef Samir', 'youssef@gmail.com', 'Alexandria, Egypt', '01044444444'),
    ('Karim Tarek', 'karim@gmail.com', 'Mansoura, Egypt', '01055555555');
INSERT INTO Restaurants
    (RestaurantName, RestaurantCity, RestaurantHotline)
VALUES
    ('Pizza House', 'Cairo', '19001'),
    ('Burger Station', 'Giza', '19002'),
    ('Pasta Corner', 'Alexandria', '19003'),
    ('Chicken Express', 'Minya', '19004');
INSERT INTO Meals
    (MealName, MealPrice, FK_RestaurantID)
VALUES
    ('Margherita Pizza', 150.00, 1),
    ('Chicken Pizza', 180.00, 1),
    ('Classic Burger', 120.00, 2),
    ('Cheese Burger', 140.00, 2),
    ('Alfredo Pasta', 160.00, 3),
    ('Chicken Pasta', 175.00, 3),
    ('Fried Chicken', 130.00, 4),
    ('Chicken Sandwich', 100.00, 4);
INSERT INTO Drivers
    (DriverName, DriverPhone, ManagerID)
VALUES
    ('Ahmed Driver', '01060000001', NULL),
    ('Omar Driver', '01060000002', NULL);
INSERT INTO Drivers
    (DriverName, DriverPhone, ManagerID)
VALUES
    ('Ali Driver', '01060000003', 1),
    ('Hassan Driver', '01060000004', 1),
    ('Mahmoud Driver', '01060000005', 2),
    ('Youssef Driver', '01060000006', 2);
INSERT INTO Orders
    (OrderDate, OrderState, FK_CustomerID)
VALUES
    ('2026-09-28 10:30:00', 'Pending', 1),
    ('2026-09-28 12:45:00', 'Delivered', 2),
    ('2026-09-29 14:20:00', 'Delivered', 3),
    ('2026-09-29 18:10:00', 'Cancelled', 4),
    ('2026-09-30 20:00:00', 'Pending', 5);
INSERT INTO OrderedMeals
    (FK_OrderID, FK_MealID)
VALUES
    (1, 1),
    (1, 3),
    (2, 2),
    (2, 4),
    (3, 5),
    (3, 7),
    (4, 6),
    (5, 1),
    (5, 8);