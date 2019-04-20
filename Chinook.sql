



-- 1. `non_usa_customers.sql`: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT TOP (1000) [CustomerId]
      ,[FirstName]
      ,[LastName]
      ,[Country]
  FROM [Chinook].[dbo].[Customer]
  where [Country] != 'USA'
  

-- 2. `brazil_customers.sql`: Provide a query only showing the Customers from Brazil.

SELECT TOP (1000) [CustomerId]
      ,[FirstName]
      ,[LastName]
      ,[Country]
  FROM [Chinook].[dbo].[Customer]
  where [Country] = 'Brazil'
  
-- 3. `brazil_customers_invoices.sql`: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT [FirstName]
      ,[LastName]
	  ,[Country]
	  ,[InvoiceId]
	  ,[InvoiceDate]
	  ,[BillingCountry]
  FROM [Chinook].[dbo].[Customer], Invoice
  where [Country] = 'Brazil'

-- 4. `sales_agents.sql`: Provide a query showing only the Employees who are Sales Agents.

SELECT *
  FROM [Chinook].[dbo].[Employee]
  where [Title] = 'Sales Support Agent'
 
-- 5. `unique_invoice_countries.sql`: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT Distinct [BillingCountry]
  FROM [Chinook].[dbo].[Invoice]

-- 6. `sales_agent_invoices.sql`: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT [LastName]
      ,[FirstName]
      ,[Title]
	  ,[InvoiceId]
  FROM [Chinook].[dbo].[Employee], Invoice
  where Title = 'Sales Support Agent'
  
-- 7. `invoice_totals.sql`: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT e.LastName as Employee
      ,e.FirstName as Employee
	  ,c.Country
      ,[Title]
	  ,[InvoiceId]
	  ,c.LastName as Customer
	  ,c.FirstName as Customer
  FROM Employee as e, Invoice as i, Customer as c
  where Title = 'Sales Support Agent'
  
-- 8. `total_invoices_year.sql`: How many Invoices were there in 2009 and 2011?

SELECT COUNT(*)
FROM Invoice as i
WHERE i.InvoiceDate between '2009-01-01' and '2009-12-31'
    or i.InvoiceDate between '2011-01-01' and '2011-12-31'
 
-- 9. `total_sales_year.sql`: What are the respective total sales for each of those years?

SELECT COUNT(*)
	,sum(Total) as Total
FROM Invoice as i
WHERE i.InvoiceDate between '2009-01-01' and '2009-12-31'
    or i.InvoiceDate between '2011-01-01' and '2011-12-31'

-- 10. `invoice_37_line_item_count.sql`: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT count(*) as InvoiceLineItems
  FROM InvoiceLine
  where InvoiceId = '37'

-- 11. `line_items_per_invoice.sql`: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql)

SELECT count(*) as InvoiceLineItems
  FROM InvoiceLine
  GROUP BY InvoiceId
 
-- 12. `line_item_track.sql`: Provide a query that includes the purchased track name with each invoice line item.

SELECT count(*) as InvoiceLineItems
	,TrackId
  FROM InvoiceLine
  GROUP BY InvoiceId, TrackId
  
-- 13. `line_item_track_artist.sql`: Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT count(*) as InvoiceLineItem
	,t.Name
	,a.Name
  FROM Track as t, Artist as a
  GROUP BY t.Name, a.Name
  
-- 14. `country_invoices.sql`: Provide a query that shows the # of invoices per country. HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql)

SELECT TOP (1000) 
	  count(InvoiceId) as Invoices
      ,BillingCountry
  FROM Invoice
  GROUP BY BillingCountry
  
-- 15. `playlists_track_count.sql`: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.

SELECT p.[Name] as PlaylistName, count(pt.TrackId) as NumberOfTracks
  from Playlist p, PlaylistTrack pt
  where p.PlaylistId = pt.PlaylistId
  group by p.[Name]

-- 16. `tracks_no_id.sql`: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

SELECT t.Name as TrackName,g.Name as Genre,a.Title as AlbumTitle,m.Name as MediaType
  from Track t, Genre g, Album a, MediaType m
  where t.AlbumId = a.AlbumId
  and t.MediaTypeId = m.MediaTypeId
  and t.GenreId = g.GenreId
  order by a.Title
  
-- 17. `invoices_line_item_count.sql`: Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT i.*, count(il.InvoiceLineId) as NumberOfLineItems
	from Invoice i
	join InvoiceLine il
	on i.InvoiceId = il.InvoiceId
	group by i.InvoiceId, i.CustomerId, i.BillingAddress, i.BillingCity, i.BillingCountry, i.BillingPostalCode, i.BillingState, i.InvoiceDate, i.Total

-- 18. `sales_agent_total_sales.sql`: Provide a query that shows total sales made by each sales agent.

SELECT e.EmployeeId, e.FirstName, e.LastName, sum(i.Total) as Sales
  FROM Employee e
  join Customer c on c.SupportRepId = e.EmployeeId
  join Invoice i on c.CustomerId = i.CustomerId
  where e.Title = 'Sales Support Agent'
  group by e.EmployeeId, e.FirstName, e.LastName

-- 19. `top_2009_agent.sql`: Which sales agent made the most in sales in 2009? HINT: [MAX](https://docs.microsoft.com/en-us/sql/t-sql/functions/max-transact-sql)

SELECT e.EmployeeId, e.FirstName, e.LastName, sum(i.Total) as Sales
  FROM Employee e
  join Customer c on c.SupportRepId = e.EmployeeId
  join Invoice i on c.CustomerId = i.CustomerId
  where e.Title = 'Sales Support Agent'
  and i.InvoiceDate between '2009-01-01' and '2009-12-31'
  group by e.EmployeeId, e.FirstName, e.LastName

-- 20. `top_agent.sql`: Which sales agent made the most in sales over all?

SELECT TOP 1 e.EmployeeId, e.FirstName, e.LastName, sum(i.Total) as Sales
  FROM Employee e
  join Customer c on c.SupportRepId = e.EmployeeId
  join Invoice i on c.CustomerId = i.CustomerId
  where e.Title = 'Sales Support Agent'
  group by e.EmployeeId, e.FirstName, e.LastName

-- 21. `sales_agent_customer_count.sql`: Provide a query that shows the count of customers assigned to each sales agent.

SELECT e.EmployeeId, e.FirstName, e.LastName, count(c.CustomerId) as NumberOfCustomers
  FROM Employee e
  join Customer c on c.SupportRepId = e.EmployeeId
  where e.Title = 'Sales Support Agent'
  group by e.EmployeeId, e.FirstName, e.LastName

-- 22. `sales_per_country.sql`: Provide a query that shows the total sales per country.

SELECT i.BillingCountry, sum(i.Total) as TotalSales
  from Invoice i
  group by BillingCountry

-- 23. `top_country.sql`: Which country's customers spent the most?

SELECT i.BillingCountry, sum(i.Total) as TotalSales
  from Invoice i
  group by BillingCountry
  order by BillingCountry desc
  
-- 24. `top_2013_track.sql`: Provide a query that shows the most purchased track of 2013.
-- 25. `top_5_tracks.sql`: Provide a query that shows the top 5 most purchased songs.
-- 26. `top_3_artists.sql`: Provide a query that shows the top 3 best selling artists.
-- 27. `top_media_type.sql`: Provide a query that shows the most purchased Media Type.
