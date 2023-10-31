CREATE DEFINER=`root`@`localhost` PROCEDURE `top_n_markets_net_sales`(
	in_fiscal_year int,
    in_top_n int
)
BEGIN
	SELECT 
		market ,round(sum(net_sales)/1000000,2) as net_sales_millions
		FROM gdb0041.net_sales_view
		where fiscal_year = in_fiscal_year
		group by market 
		order by net_sales_millions desc
		limit in_top_n;
END