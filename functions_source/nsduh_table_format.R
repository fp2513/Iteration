NSDUH_import = function(html, table_num, drug_name) {
  
  drug_df = 
    html %>% 
    html_table() %>% 
    nth(table_num) %>% 
    slice(-1) %>% 
    mutate(drug = drug_name) %>% 
    select(-contains("P Value"))
  
  return(drug_df)
}