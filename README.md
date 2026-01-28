# Restuarant Sales Analysis
## Project Overview
This project analyses sales data from a fast‑food restaurant to uncover sales trends, customer behaviour, and revenue insights. The goal is to demonstrate practical data analysis skills using R, with a focus on cleaning messy data, exploratory data analysis (EDA), and visualisation.

This project is designed to reflect the type of analysis a junior data analyst would perform in a real business setting.

## Objectives
- Clean and prepare raw sales data for analysis

- Understand sales performance across time and transaction types

- Identify trends that could inform business decisions

- Communicate insights clearly using visualisations

## Dataset
- **Source:** Kaggle - Balaji Food Sales dataset
- **Format:** CSV
- **Key features include:**
  - `item_name`: name of the food
    
  - `item_type`: category of item (Fastfood or Beverages)
    
  - `quantity`: how much quantity the customer orders
    
  - `transaction_type`: payment method (cash, online, others)
    
  - `transaction_amount`: the total amount paid by customers
    
  - `recieved_by`: gender of the person handling the transaction

## Tools & Technologies
- R

- RStudio

- dplyr – data manipulation

- ggplot2 – data visualisation

- Git & GitHub – version control

- lubridate - date handling and feature extraction

## Key Analysis Steps
### 1. Data Ingestion & Intial Exploration
   - Loaded raw sales data from CSV
   - Inspected structure, summaries, and data types using `str()` and `summary`
   - Checked for duplicate records
     
### 2. Data Cleaning and Feature Engineering
   - Standardised date formats and converted t proper `Date` objects using **lubridate**
   - Extracted **year** and **month** features for time-based analysis
   - Converted relevant variables to appropriate data types (factors and numeric)
   - Handled missing or blank `transaction_type` values by assigning an `Others` category
     
### 3. Exploratory Data Analysis(EDA)
   - Analysed monthly revenue trends across the dataset
   - Compared product performance by **revenue** and **quatity sold**
   - Examined transcation methods and their usage over time
   - Evaluated performance by item type and staff category

### 4. Visualisation 
  - Line and point plots to show monthly  revenue trends
  - Bar Charts to compare revenue and quantity aross product and categories
  - Categorical comparisons for transaction types and staff performance

## Key Insights
- **Fast food items generate the highest revenue**, even though beverage items are sold in higher quantities
- **Beverages have high sales volume but lower transcation value**, indicating potential pricing  or bundling opportunities
- Monthly revenue shows a noticeable variation, suggesting the presence of **seasonal demand patterns**
- Certain transcation types are used more frequently, highlighting preferred customer purchasing channels
- Sales volume differs across staff categories, indicating differences in sales contribution by role

These insights highlight opportunities for **improving pricing strategy, promotions, and operational focus**.

## Repository Structure 
```text
Resturant-Sales-Analysis/
|- Balaji Fast Food Sales.csv        # Raw sales data
|- Restaurant EDA code.R            # Exploratory Data Analysis
|- Restaurant sales Analysis code.R # Detailed sales analysis
|- Restaurant-analysis.Rproj        # RStudio project file
|- .gitignore                       # Git ignore file
|- README.md                        # Project documentation
```

## How to Run the Project
1. Clone the repository
2. Open `Resturant-analysis.Rpoj` in RStudio
3. Install required packages:
   `install.packages(c("dplyr", "ggplot2"))`
4. Run the R scripts in order to reproduce the analysis

## Future Improvements
- Add profit margin analysis
- build an interactive dashboard (Power BI or Shiny)
- Perform cutomer segementation

## Author 
Lufuno Masuku

Aspiring Data Analyst| Data Science & Analytics

## License 
This project is for educational and portfolio purposes
   
