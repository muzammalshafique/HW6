# install.packages("tidyverse")
library(tidyverse)

load("house_prices.rda")

# Q 1 (a)
ggplot(house_prices, aes(x = date, y = house_price_index)) +
  geom_line() +
  facet_wrap(~ state) +
  # Use scale_x_date for date axes
  scale_x_date(breaks = as.Date(c("1980-01-01", "2000-01-01", "2020-01-01")), # Specify breaks as dates
               labels = c("'80", "'00", "'20")) + # Your desired labels
  labs(title = "Trend of House Price Index by State", # Adjusted title slightly
       x = "Year", # You can still label the axis "Year" for clarity
       y = "House Price Index")

# Q 1 (b)
house_reshaped <- house_prices %>%
  gather(
    key = "measure",                # Name of the new column holding the original column names
    value = "value",                # Name of the new column holding the values
    house_price_index, unemploy_perc # The columns to gather
  )

# Display the first few rows - should be identical to pivot_longer result
head(house_reshaped)

# Q 1 (c)
plot_c <- ggplot(house_reshaped, aes(x = date, y = value, color = measure)) +
  geom_line(na.rm = TRUE) + # Added na.rm=TRUE
  facet_wrap(~ state) +
  scale_x_date(
    breaks = as.Date(c("1980-01-01", "2000-01-01", "2020-01-01")),
    labels = c("'80", "'00", "'20")
  ) +
  labs(
    title = "House Price Index vs. Unemployment Percentage by State",
    x = "Year",
    y = "Value", # Generic label as units differ
    color = "Metric" # Legend title
  ) +
  theme_minimal()