use dannys_diner;
#1.What is the total amount each customer spent at the restaurant?

SELECT 
    s.customer_id, SUM(m.price) AS total_amount_spent
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;

#2.How many days has each customer visited the restaurant?

SELECT 
    customer_id, COUNT(DISTINCT order_date)
FROM
    sales
GROUP BY customer_id;

#3.What was the first item from the menu purchased by each customer?


WITH cte AS(
SELECT 
    s.customer_id, m.product_name, s.product_id, s.order_date,
    row_number() over(partition by s.customer_id order by s.order_date) as rk
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id)
 
 select customer_id,product_name from cte where rk=1 ;



#4.What is the most purchased item on the menu and how many times was it purchased by all customers?


SELECT 
    m.product_name,
    COUNT(m.product_name) AS no_of_times_items_ordererd
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY COUNT(m.product_name) DESC
LIMIT 1
;


#5.Which item was the most popular for each customer?
 with cte as (
 SELECT 
    m.product_name,s.customer_id,
    COUNT(m.product_name) AS no_of_times_items_ordererd,
    rank() over(partition by s.customer_id order by count(s.order_date) desc) as rnk
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY m.product_name,s.customer_id)

select product_name,customer_id from cte where rnk=1


;
 
 
 

#6.Which item was purchased first by the customer after they became a member?

WITH cte AS(
SELECT 
    s.customer_id,
    s.order_date,
    s.product_id,
    m.product_name,
    m.price,
    me.join_date,
    rank() over(partition by customer_id order by order_date) as rnk
FROM
    menu m
        JOIN
    sales s ON m.product_id = s.product_id
        JOIN
    members me ON s.customer_id = me.customer_id
WHERE
    me.join_date <= s.order_date)

SELECT 
	customer_id,
    product_name 
    FROM
  cte  WHERE rnk=1
;



#7.Which item was purchased just before the customer became a member?

WITH cte as(
SELECT 
    s.customer_id,
    s.order_date,
    s.product_id,
    m.product_name,
    m.price,
    me.join_date,
    rank() over(partition by customer_id order by order_date desc) as rnk
FROM
    menu m
        JOIN
    sales s ON m.product_id = s.product_id
        JOIN
    members me ON s.customer_id = me.customer_id
WHERE
    me.join_date > s.order_date)

SELECT 
    customer_id, product_name
FROM
    cte
WHERE
    rnk = 1
;


#8.What is the total items and amount spent for each member before they became a member?
SELECT 
    s.customer_id,
    m.price,
    me.join_date,
    SUM(price) AS amount_spent,
    COUNT(*) AS total_items
FROM
    menu m
        JOIN
    sales s ON m.product_id = s.product_id
        JOIN
    members me ON s.customer_id = me.customer_id
WHERE
    me.join_date > s.order_date
GROUP BY s.customer_id
;

#9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?


SELECT 
    s.customer_id,
    sum(CASE WHEN m.product_name="sushi" THEN 2*10*m.price 
		ELSE m.price*10 END) AS points
FROM
    sales s
        JOIN
    menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
;


#10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi -
# how many points do customer A and B have at the end of January?


SELECT 
  s.customer_id, 
  SUM(
    CASE 
      WHEN s.order_date BETWEEN me.join_date AND DATE_ADD(me.join_date, INTERVAL 6 DAY) THEN price * 10 * 2 
      WHEN m.product_name = 'sushi' THEN m.price * 10 * 2 
      ELSE m.price * 10 
    END
  ) as points 
FROM 
  menu as m 
  INNER JOIN sales as s ON s.product_id = m.product_id
  INNER JOIN members AS me ON me.customer_id = s.customer_id 
WHERE 
  DATE_FORMAT(s.order_date, '%Y-%m-01') = '2021-01-01' 
GROUP BY 
  s.customer_id;




