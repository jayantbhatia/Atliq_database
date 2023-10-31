CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sales_preinvoice_discount` AS
    SELECT 
        `s`.`date` AS `date`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `s`.`product_code` AS `product_code`,
        `s`.`customer_code` AS `customer_code`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `c`.`market` AS `market`,
        `c`.`customer` AS `customer`,
        `p`.`product` AS `product`,
        `p`.`variant` AS `variant`,
        `g`.`gross_price` AS `gross_price`,
        ROUND((`g`.`gross_price` * `s`.`sold_quantity`),
                2) AS `gross_price_total`,
        `pre`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`
    FROM
        ((((`fact_sales_monthly` `s`
        JOIN `dim_customer` `c` ON ((`s`.`customer_code` = `c`.`customer_code`)))
        JOIN `dim_product` `p` ON ((`p`.`product_code` = `s`.`product_code`)))
        JOIN `fact_gross_price` `g` ON (((`g`.`product_code` = `s`.`product_code`)
            AND (`g`.`fiscal_year` = `s`.`fiscal_year`))))
        JOIN `fact_pre_invoice_deductions` `pre` ON (((`pre`.`customer_code` = `s`.`customer_code`)
            AND (`pre`.`fiscal_year` = `s`.`fiscal_year`))))