CREATE DEFINER=`root`@`localhost` PROCEDURE `top_n_products_per_division`(
in_fiscal_year int, 
in_top_n int 
)
BEGIN
with cte1 as (select
				p.division,
				p.product, 
				sum(sold_quantity) as total_quantity
			FROM fact_sales_monthly s
			join dim_product p
			on p.product_code = s.product_code
			where fiscal_year = in_fiscal_year
			group by p.division,p.product),
            
cte2 as (
	select * , dense_rank() over(partition by division order by total_quantity desc) as drnk 
    from cte1
)

select * from cte2 where drnk <=in_top_n;
END