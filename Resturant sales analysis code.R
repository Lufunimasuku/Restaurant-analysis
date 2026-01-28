library(dplyr)

messy_resturant_data <- read.csv("C:/Users/lufun/Downloads/archive (1)/Balaji Fast Food Sales.csv")
print(messy_resturant_data)

#Data Cleaning and Exploration

head(messy_resturant_data)
str(messy_resturant_data)
summary(messy_resturant_data)
 
# Reading columns Separately and not as one  
resturant_df <- data.frame (messy_resturant_data)
print (resturant_df)

#checking and deleting of Duplicate rows
sum(duplicated(resturant_df))

# check and convert data types
summary(resturant_df)

library(lubridate)
resturant_df$date <- gsub("/","-", resturant_df$date)
resturant_df$date <- mdy(resturant_df$date)
resturant_df$date
resturant_df$year <- year(resturant_df$date)
resturant_df$year <- as.factor(resturant_df$year)
str(resturant_df$year)

resturant_df$item_type <- as.factor(resturant_df$item_type)
str(resturant_df$item_type)

resturant_df$item_price <- as.numeric(resturant_df$item_price)
str(resturant_df$item_price)

resturant_df$quantity <- as.numeric(resturant_df$quantity)
str(resturant_df$quantity)

resturant_df$transaction_amount <- as.numeric(resturant_df$transaction_amount)
str(resturant_df$transaction_amount)

resturant_df <- resturant_df %>% 
  mutate( resturant_df$transaction_type = ifelse(resturant_df$transaction_type == ""|transaction_type == "", "Others", transaction_type))
resturant_df$transaction_type

resturant_df$transaction_type <- as.factor(resturant_df$transaction_type)
str(resturant_df$transaction_type)

resturant_df$item_name <- as.factor(resturant_df$item_name)
str(resturant_df$item_name)

resturant_df$time_of_sale <- as.factor(resturant_df$time_of_sale)
str(resturant_df$time_of_sale)

resturant_df$received_by <- as.factor(resturant_df$received_by)
str(resturant_df$received_by)
print(resturant_df)

library(tidyverse)
library(conflicted)

total_revenue<- sum(resturant_df$transaction_amount, na.rm = TRUE)
total_revenue

resturant_df %>%
  group_by(year) %>%
  summarise(total_revenue)

# Total Revenue for 2022 and 2023
ggplot(resturant_df,aes(year, total_revenue)) +
  geom_col(
    fill = resturant_df$year) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Total Revenue for each Partial Year",
    x = "Year",
    y = "Total Revenue"
  ) +
  theme_minimal()

# Top Purchased product by transaction amount
resturant_df%>%
  group_by(item_name, year) %>%
  summarise(total_revenue = sum(transaction_amount)) %>%
  ggplot(aes(item_name,total_revenue, fill = year))+
  geom_col(position = position_dodge()) +
  scale_y_continuous(labels = scales::comma)
  labs(
    title = "Top Purchased Product by Transcation Amount",
    x = "Item Name",
    y = "Total Revenue"
  )


#Top Purchased product by Quantity
resturant_df %>%
  group_by(item_name,year) %>%
  summarise(total_quantity = sum(quantity, na.rm = TRUE)) %>% 
  ggplot(aes(item_name, total_quantity, fill = year )) +
  geom_col(position = "dodge")+ 
  labs(
    title = "Top Purchased Product(Quantity)",
    x = "Item Name",
    y = "Number of Items Sold"
  )

#Top used Transaction method

resturant_df %>%
  group_by(transaction_type, year) %>%
  summarise(n = n()) %>%
  ggplot(aes(transaction_type, n, fill = year)) +
  geom_col(position = "dodge") +
  labs(
    title = "Top used Transcation method",
    x = "Transcation Type",
    y = "Number of Transcations"
  )

# Item that sold the most (Revenue)
 resturant_df %>%
   group_by( item_type, year) %>%
   summarise(total_revenue_by_item_type = sum(transaction_amount)) %>%
   ggplot(aes(item_type, total_revenue_by_item_type, fill = year)) +
   geom_col(position = "dodge") +
   labs(
     title = "Type of item that made the most revenue",
     x = "Type of Item",
     y = "total Revenue"
   )
 
#Item that sold the most (Quantity)
 
 resturant_df %>%
   group_by(item_type, year) %>% 
   summarise(total_quantity_item_type = sum(quantity)) %>% 
   ggplot(aes(item_type, total_quantity_item_type, fill = year)) +
   geom_col(position = "dodge") +
   labs(
     title = "Type of Item that sold the most(Quantity)",
     x = "Type of Item",
     y = "Total units Sold"
   )
 
 
#Best Performing Employee
 resturant_df %>%
   group_by(received_by, year) %>%
   summarise(total_quantity_employee = sum(quantity)) %>%
   ggplot(aes(received_by, total_quantity_employee, fill = year)) +
   geom_col(position = "dodge") +
   labs(
     title = "Sales Volume by Staff category ",
     subtitle = "Staff Category That Sold the Most Items",
     x = "Staff Category",
     y = "Quantity" 
    
   )
   



 
  
 


