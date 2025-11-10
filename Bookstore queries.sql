Create table Books(
Book_ID	Serial	primary key,
Title	Varchar(60),	
Author	Varchar(60),	
Genre	Varchar(60),	
Published_Year	Int,	
Price	Numeric(10,2),	
Stock	int	
); 
select * from Books

Create table customers(
Customer_ID	Serial	primary key,
Name	Varchar(100),	
Email	Varchar(100),	
Phone	Varchar(15),	
City	Varchar(100),	
Country	Varchar(100)	
);

Select *from Customers

 Create table orders(
 Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
 );

 Select * from orders

-- 1) Retrieve all books in the "Fiction" genre:

Select * from books
Where genre='Fiction' 



-- 2) Find books published after the year 1950:
Select * from books
Where published_year>1950;


-- 3) List all customers from the Canada:
Select * from customers
where country='canada'


-- 4) Show orders placed in November 2023:

Select *from orders 
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
 Select sum(stock) as total_stock
 from books;


-- 6) Find the details of the most expensive book:
Select *from books
order by price desc
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
Select * from orders
where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
Select * from orders
where total_amount>20;


-- 9) List all genres available in the Books table:
Select distinct genre from books;


-- 10) Find the book with the lowest stock:
Select * from books
order by stock asc
limit 1;



-- 11) Calculate the total revenue generated from all orders:
Select sum(total_amount) as total_revenue from orders;


-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
Select b.genre, sum(o.quantity) as total_books_sold
From orders o
Join books b on o.book_id=b.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
Select avg(price) as average_price
From books
where genre='Fantasy';

-- 3) List customers who have placed at least 2 orders:
Select o.customer_id ,c.name, count(o.order_id) as order_count
From orders o
join customers c on o.customer_id=c.customer_id
Group by o.customer_id, c.name
having count(order_id)>=2;



-- 4) Find the most frequently ordered book:
Select o.book_id, b.title, count(o.order_id) as order_count
from orders o
join books b on o.book_id=b.book_id
group by o.book_id, b.title
order by order_count desc
limit 1;

 

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

Select * from books
where genre='Fantasy'
order by price desc 
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:

Select b.author, Sum(o.quantity) as total_book_sold
from orders o
join books b on b.book_id=o.book_id
group by b.author;

-- 7) List the cities where customers who spent over $30 are located:

Select distinct c.city, total_amount
from orders o
Join customers c on o.customer_id=c.customer_id
where o.total_amount>30

-- 8) Find the customer who spent the most on orders:
Select c.customer_id, c.name, sum(total_amount) as total_spent
From orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_id, c.name
order by total_spent desc
limit 1;



--9) Top 3 authors whose books sold the most copies
Select author ,sum(o.quantity) as total_books_sold
from books b
Join orders o on b.book_id=o.book_id
Group by author
Order by total_books_sold desc 
limit 3;

--10) Customers who haven’t placed any orders
SELECT c.customer_id, c.name
FROM customers c
Left JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--11) Total sales for each month
Select to_char(order_date,'yyyy-mm') as month, sum(total_amount) as total_sale
from orders
Group by to_char(order_date,'yyyy-mm')
Order by month;

--12)Best selling book in each genre
Select  b.genre ,b.title , sum(o.quantity) as total_sold
from books b
Join orders o ON b.book_id=o.book_id
Group by b.genre ,b.title
Order by b.genre, total_sold desc;

--13)Books that are out of stock
Select *from books
Where stock='0'
