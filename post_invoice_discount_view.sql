CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sales_postinvoice_discout_view` AS
    SELECT 
        `s`.`date` AS `date`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `s`.`customer_code` AS `customer_code`,
        `s`.`product_code` AS `product_code`,
        `s`.`market` AS `market`,
        `s`.`customer` AS `customer`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `s`.`product` AS `product`,
        `s`.`variant` AS `variant`,
        `s`.`gross_price_total` AS `gross_price_total`,
        `s`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        (`s`.`gross_price_total` - (`s`.`gross_price_total` * `s`.`pre_invoice_discount_pct`)) AS `net_invoice_sales`,
        (`pos`.`discounts_pct` + `pos`.`other_deductions_pct`) AS `post_invoice_discount_pct`
    FROM
        (`sales_preinvoice_discount` `s`
        JOIN `fact_post_invoice_deductions` `pos` ON (((`pos`.`date` = `s`.`date`)
            AND (`pos`.`product_code` = `s`.`product_code`)
            AND (`pos`.`customer_code` = `s`.`customer_code`))))