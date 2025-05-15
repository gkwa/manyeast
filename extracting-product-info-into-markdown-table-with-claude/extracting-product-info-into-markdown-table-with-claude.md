You will be converting given data into a markdown format table with specific formatting requirements. Here is the table data you will be working with:

<table_data>
{{ .TableData }}
</table_data>

Your task is to convert this table into a markdown table format. Follow these steps:

1. Create a markdown table with the following columns in this order:
   Price per oz, Price per lb, Price per unit, Store, Product Name, Date

2. Order the rows by the "Price per oz" column, from lowest to highest.

3. In the "Product Name" column, create a link for each product using the provided link back to the store record.

4. In the "Price per unit" column, ensure that the format is $${price per product}/${product weight or volume}. For example, "$4.49/lb" or "$2.49/8 oz".

5. Use the following markdown table structure:

```
| Price per oz | Price per lb | Price per unit | Store | Product Name | Date |
|--------------|--------------|----------------|-------|--------------|------|
| $0.28        | $4.49        | $4.49/lb       | ...   | [Product](link) | ... |
```

Ensure that you maintain proper alignment and use the correct number of hyphens in the separator row.

Present your final markdown table without any additional text or explanations. Make sure to double-check your work for accuracy in sorting, link creation, and formatting before submitting your answer.

Output your markdown table inside <markdown_table> tags.
