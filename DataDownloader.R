
# Create API Database ElephantSQL 

library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")


con <- dbConnect(drv,
                 dbname = 'psruiyjn', 
                 host = 'john.db.elephantsql.com', 
                 port = 5432,
                 user = 'psruiyjn', 
                 password = 'uefJQtwT4FIP4RlnF3VocwFOC4pWVvT9'
)


# Get yield curve
library(RCurl)
download <- getURL("https://home.treasury.gov/resource-center/data-chart-center/interest-rates/daily-treasury-rates.csv/all/all?type=daily_treasury_yield_curve&field_tdr_date_value=all&page&_format=csv")
data <- read.csv(text = download)

# Send data to elephant sql
dbWriteTable(conn = con, 
             name = "UpdateTreasury", 
             value = data, 
             append = FALSE, 
             row.names = TRUE, 
             overwrite=TRUE)

on.exit(dbDisconnect(con)) 
