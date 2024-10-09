library(ggplot2)
library(dplyr)
library(tidyr)
library(plotly)
source("hw.R")

library(ggplot2)
library(plotly)


Dataset$Date <- as.Date(Dataset$Date) #changing date column

# Filter out NAs if any
Dataset <- Dataset %>%
  filter(!is.na(Change_in_Deaths_Per_Day))

# Redesign plot
redesign1 <- ggplot(Dataset, aes(x = Date, y = Change_in_Deaths_Per_Day, color = Country)) +
  geom_line(size = 1) +  # Line plot for each country
  labs(title = "Change in Deaths Per Day for Each Country", 
       x = "Date", 
       y = "Change in Deaths Per Day") +
  facet_wrap(~Country, scales = "free_y") +  # Separate graphs for each country
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),  # Title in the center
        strip.text = element_text(size = 12),    # Facet titles size
        axis.title = element_text(size = 12),    # Adjusting axis titles
        legend.position = "none") +              # Removing the legend
  scale_color_manual(values = c("aquamarine4", "darkkhaki", "burlywood4", "darkmagenta", "coral4", "purple", "cornflowerblue")) 

# Convert the plot to an interactive version using plotly
faceted_plot <- ggplotly(redesign1)

# Display the interactive plot
faceted_plot




# Creating a stacked area chart which showing total deaths over time by country
redesign2 <- ggplot(Dataset, aes(x = Date, y = Average_Deaths_Per_Day, fill = Country)) +
  geom_area(alpha = 0.6 , size = 0.5, color = "black")  +  
  labs(title = "Total Daily Deaths Over Time by Country (Stacked Area Chart)",
       x = "Date", 
       y = "Deaths Per Day",
       fill = "Country") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

#creating interactive plot using plotly
stacked_area_plot <- ggplotly(redesign2)

# graph
stacked_area_plot

# Create a bubble chart for cumulative deaths per country
# Install necessary packages if not installed
# install.packages("ggplot2")
# install.packages("plotly")
# install.packages("dplyr")

library(ggplot2)
library(plotly)
library(dplyr)

# Calculating cumulative deaths per day in each country
Dataset <- Dataset %>%
  group_by(Country) %>%
  arrange(Date) %>%
  mutate(Cumulative_Deaths_Per_Day = cumsum(Average_Deaths_Per_Day)) %>%
  ungroup()

# Create a bubble chart for cumulative deaths per country
redesign3 <- ggplot(Dataset, aes(x = Country, y = Cumulative_Deaths_Per_Day, 
                                      size = Cumulative_Deaths_Per_Day, color = Country)) +
  geom_point(alpha = 0.3) +  # Bubble chart with transparency
  scale_size(range = c(2, 10)) +  # Adjust bubble sizes
  #scale_color_manual(values = c("China" = "lightpink", "France" = "lightyellow", "Germany" = "lightgreen", "Italy"="cyan", "Spain" = "lightblue", "UK" = "cornflowerblue", "USA" = "hotpink")) +  # Custom colors for each country
  labs(title = "Cumulative Deaths by Country (Bubble Chart)", 
       x = "Country", 
       y = "Cumulative Deaths",
       size = "Cumulative Deaths") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# Creating interactive bubble chart using plotly
bubble_chart <- ggplotly(redesign3)

# graph
bubble_chart


