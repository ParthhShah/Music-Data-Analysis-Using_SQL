SELECT 
    billing_city,
    SUM(total) AS total_sales
FROM
    invoice
GROUP BY
    billing_city
ORDER BY
    total_sales DESC;


	-- Que 2:
	SELECT
    billing_country,
    COUNT(*) AS total_invoices
FROM
    invoice
GROUP BY
    billing_country
ORDER BY
    total_invoices DESC;

	--Que 3
	SELECT TOP 3
    *
FROM
    invoice
ORDER BY
    total DESC;

	--Que 4
	SELECT TOP 1
    title,
    employee_id,
    first_name,
    last_name,
    hire_date
FROM 
    employee
ORDER BY 
    title,
    hire_date ASC;

	-- Que 5
	SELECT Top 1 c.customer_id, c.first_name, c.last_name, SUM(i.total) Total
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY
    Total DESC;
