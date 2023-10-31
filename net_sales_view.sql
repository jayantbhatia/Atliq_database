CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `net_sales_view` AS
    SELECT 
        `sales_postinvoice_discout_view`.`date` AS `date`,
        `sales_postinvoice_discout_view`.`fiscal_year` AS `fiscal_year`,
        `sales_postinvoice_discout_view`.`customer_code` AS `customer_code`,
        `sales_postinvoice_discout_view`.`product_code` AS `product_code`,
        `sales_postinvoice_discout_view`.`sold_quantity` AS `sold_quantity`,
        `sales_postinvoice_discout_view`.`market` AS `market`,
        `sales_postinvoice_discout_view`.`customer` AS `customer`,
        `sales_postinvoice_discout_view`.`product` AS `product`,
        `sales_postinvoice_discout_view`.`variant` AS `variant`,
        `sales_postinvoice_discout_view`.`gross_price_total` AS `gross_price_total`,
        `sales_postinvoice_discout_view`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        `sales_postinvoice_discout_view`.`net_invoice_sales` AS `net_invoice_sales`,
        `sales_postinvoice_discout_view`.`post_invoice_discount_pct` AS `post_invoice_discount_pct`,
        ((1 - `sales_postinvoice_discout_view`.`post_invoice_discount_pct`) * `sales_postinvoice_discout_view`.`net_invoice_sales`) AS `net_sales`
    FROM
        `sales_postinvoice_discout_view`