CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_acc`(
in_fiscal int
)
BEGIN
	SET sql_mode = '';
	with cte1 as (SELECT 
		s.customer_code,
		sum(s.sold_quantity) as total_sold_quantity, 
		sum(s.forecast_quantity) as total_forecast_quantity, 
		sum(abs(forecast_quantity - sold_quantity)) as abs_error,
		sum(abs(forecast_quantity - sold_quantity))*100/sum(forecast_quantity) as abs_error_pct
		
	FROM
		gdb0041.fact_act_est s 
		where s.fiscal = in_fiscal
		group by customer_code)
		
	select e.*,
	c.market,
	c.customer,
	if(abs_error_pct>100 , 0 , (100-abs_error_pct)) as forecast_accuracy 
	from cte1 e
	join dim_customer c 
	using(customer_code)

	order by forecast_accuracy desc;
END