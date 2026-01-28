library(dplyr)

messy_restaurant_data <- read.csv("C:/Users/lufun/Downloads/archive (1)/Balaji Fast Food Sales.csv")
print(messy_restaurant_data)

#Data Cleaning and Exploration

head(messy_restaurant_data)
str(messy_restaurant_data)
summary(messy_restaurant_data)
 
# Reading columns Separately and not as one  
restaurant_df <- data.frame (messy_restaurant_data)
print (restaurant_df)

#checking and deleting of Duplicate rows
sum(duplicated(restaurant_df))

# check Data Types 
summary(restaurant_df)

library(lubridate)

#Change Date Formatting to be consistent

restaurant_df$date <- gsub("/","-", restaurant_df$date)

restaurant_df$date <- mdy(restaurant_df$date)

restaurant_df$year <- year(restaurant_df$date)

restaurant_df$year<- as.factor(restaurant_df$year)

restaurant_df$year

#Create a Month Column

restaurant_df$month <- month(restaurant_df$date)

restaurant_df$month <- as.factor(restaurant_df$month)

restaurant_df$month

# Convert Data Types

restaurant_df$item_type <- as.factor(restaurant_df$item_type)

restaurant_df$item_price <- as.numeric(restaurant_df$item_price)

restaurant_df$quantity <- as.numeric(restaurant_df$quantity)

restaurant_df$transaction_amount <- as.numeric(restaurant_df$transaction_amount)

restaurant_df$item_name <- as.factor(restaurant_df$item_name)

restaurant_df$time_of_sale <- as.factor(restaurant_df$time_of_sale)

restaurant_df$received_by <- as.factor(restaurant_df$received_by)

#Fill Missing transaction_type and Convert Data type
restaurant_df <- restaurant_df %>% 
  
  mutate(transaction_type = ifelse(restaurant_df$transaction_type == ""|transaction_type == "", "Others", transaction_type))

resturant_df$transaction_type <- as.factor(restaurant_df$transaction_type)

#Check Converted Data Types and Structure After Cleaning

str(restaurant_df)


library(tidyverse)
library(conflicted)

# Average monthly revenue per year

monthly_revenue <- resturant_df %>%
  mutate(month = floor_date(as.Date(date), "month")) %>%
  group_by(month) %>%
  summarise(
    total_revenue = sum(transaction_amount, na.rm = TRUE)
  ) %>%
  arrange(month)


# Average Monthly Revenue for 2022 and 2023
ggplot(monthly_revenue, aes(x = month, y = total_revenue, fill = month)) +
  geom_line( color = "white") +
  geom_point(color = "red") +
  scale_x_date(date_labels = "%b %Y", date_breaks = "1 month") +
  labs(
    title = "Monthly Revenue Trend",
    x = "Month",
    y = "Total Revenue"
  ) +
  theme(
    plot.background = element_rect(fill = "black"),
    panel.background = element_rect(fill = "black"),
    panel.grid.major = element_line(color = "gray30"),
    panel.grid.minor = element_line(color = "gray20"),
    text = element_text(color = "white"),
    axis.text = element_text(color = "white"),
    axis.title = element_text(color = "white"),
    plot.title = element_text(color = "white"),
    legend.position = "none"
  )

# Top Purchased product by transaction amount
top_purchased_amount<- restaurant_df %>%
  mutate(month = floor_date(as.Date(date), "month")) %>%
  group_by(month, item_name) %>%
  summarise(
    total_revenue = sum(transaction_amount, na.rm = TRUE)
  ) %>%
  arrange(month)

  ggplot(top_purchased_amount, aes(item_name,total_revenue, fill = item_name)) +
    geom_col() +
    scale_y_continuous(labels = scales::comma) +
    labs(
    title = "Top Purchased Product by Transcation Amount",
    x = "Item Name",
    y = "Total Revenue"
  ) +
    theme(
      plot.background = element_rect(fill = "black"),
      panel.background = element_rect(fill = "black"),
      panel.grid.major = element_line(color = "gray30"),
      panel.grid.minor = element_line(color = "gray20"),
      text = element_text(color = "white"),
      axis.text = element_text(color = "white"),
      axis.title = element_text(color = "white"),
      plot.title = element_text(color = "white"),
      legend.position = "none"
    )
    


#Top Purchased product by Quantity
top_purchased_quantity <- restaurant_df %>%
  mutate(month = floor_date(as.Date(date), "month")) %>%
  group_by(item_name,month) %>%
  summarise(
    total_quantity = sum(quantity, na.rm = TRUE)) %>%
  arrange(month)

  ggplot(top_purchased_quantity, aes(item_name, total_quantity, fill = item_name )) +
  geom_col(position = "dodge")+ 
  labs(
    title = "Top Purchased Product(Quantity)",
    x = "Item Name",
    y = "Number of Items Sold"
  ) +
    theme(
      plot.background = element_rect(fill = "black"),
      panel.background = element_rect(fill = "black"),
      panel.grid.major = element_line(color = "gray30"),
      panel.grid.minor = element_line(color = "gray20"),
      text = element_text(color = "white"),
      axis.text = element_text(color = "white"),
      axis.title = element_text(color = "white"),
      plot.title = element_text(color = "white"),
      legend.position = "none"
    )


#Top used Transaction method

top_used_method <- restaurant_df%>%
  mutate(month = floor_date(as.Date(date), "month") ) %>%
  group_by(transaction_type, month) %>%
  summarise(
    n = n()) %>%
    arrange(month)
  
  ggplot(top_used_method, aes(transaction_type, n, fill = transaction_type)) +
    geom_col()+
  labs(
    title = "Top used Transcation method",
    x = "Transcation Type",
    y = "Number of Transcations"
  ) +
    theme(
      plot.background = element_rect(fill = "black"),
      panel.background = element_rect(fill = "black"),
      panel.grid.major = element_line(color = "gray30"),
      panel.grid.minor = element_line(color = "gray20"),
      text = element_text(color = "white"),
      axis.text = element_text(color = "white"),
      axis.title = element_text(color = "white"),
      plot.title = element_text(color = "white"),
      legend.position = "none"
    )



# Item that sold the most (Revenue)
  item_sales <- restaurant_df %>%
    mutate(month = floor_date(as.Date(date), "month")) %>%
    group_by( item_type, month) %>%
    summarise(total_revenue_sales = sum(transaction_amount)) %>%
    arrange(month)
  
  ggplot(item_sales, aes(item_type, total_revenue_sales, fill = item_type)) +
    geom_col() +
    scale_y_continuous(labels = scales::comma) +
    labs(
         title = "Type of item that made the most revenue",
         x = "Type of Item",
         y = "Total Revenue"
         ) +
     theme(
       plot.background = element_rect(fill = "black"),
       panel.background = element_rect(fill = "black"),
       panel.grid.major = element_line(color = "gray30"),
       panel.grid.minor = element_line(color = "gray20"),
       text = element_text(color = "white"),
       axis.text = element_text(color = "white"),
       axis.title = element_text(color = "white"),
       plot.title = element_text(color = "white"),
       legend.position = "none"
     )
  
   
 
#Item that sold the most (Quantity)
 
 item_sales_quantity <- restaurant_df %>%
   mutate(month = floor_date(as.Date(date), "month")) %>%
   group_by(item_type, month) %>% 
   summarise(total_quantity_item_type = sum(quantity)) %>%
   arrange(month)
 
   ggplot(item_sales_quantity, aes(item_type, total_quantity_item_type, fill = item_type)) +
   geom_col(position = "dodge", 
            ) +
   scale_y_continuous(labels = scales::comma) +
   labs(
     title = "Type of Item that sold the most Units",
     x ="Type of Item",
     y ="Total units Sold"
   ) +
  theme(
       plot.background = element_rect(fill = "black"),
       panel.background = element_rect(fill = "black"),
       panel.grid.major = element_line(color = "gray30"),
       panel.grid.minor = element_line(color = "gray20"),
       text = element_text(color = "white"),
       axis.text = element_text(color = "white"),
       axis.title = element_text(color = "white"),
       plot.title = element_text(color = "white"),
       legend.position = "none"
     )
 
#Best Performing Employee
 staff_category <- restaurant_df%>%
   mutate(month = floor_date(as.Date(date), "month")) %>%
   group_by( received_by , month) %>%
   summarise(total_quantity_employee = sum(quantity)) %>%
   arrange(month)
 
   ggplot(staff_category, aes( received_by, total_quantity_employee,
                               fill = received_by)) +
   geom_col() +
   labs(
     title = "Sales Volume by Staff category ",
     subtitle = "Staff Category That Sold the Most Items",
     x = "Staff Category",
     y = "Quantity" ) +
     theme(
       plot.background = element_rect(fill = "black"),
       panel.background = element_rect(fill = "black"),
       panel.grid.major = element_line(color = "gray30"),
       panel.grid.minor = element_line(color = "gray20"),
       text = element_text(color = "white"),
       axis.text = element_text(color = "white"),
       axis.title = element_text(color = "white"),
       plot.title = element_text(color = "white"),
       legend.position = "none"
     )
   
 