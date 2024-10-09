library(readxl) #
library(ggplot2)
library(plotly)
library(dplyr)
source("hw.R")

colnames(oildataset)


# Creating a bar plot of oil production by country

library(ggplot2)
library(plotly)

# Creating a bar plot of oil production by country with custom colors
visualization1 <- ggplot(oildataset, aes(x = reorder(Country, `Oil Production (Thousand B/D)`), 
                                         y = `Oil Production (Thousand B/D)`, fill = Group)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(title = "Oil Production by Country in 2022", x = "Country", y = "Production (Thousand B/D)") +
  scale_fill_manual(values = c("Non-OPEC Countries" = "darkmagenta", 
                               "OPEC Countries" = "chocolate", 
                               "OPEC+ Countries" = "darkolivegreen4")) +  
  theme_minimal()

#interactive 
bar_chart <- ggplotly(visualization1)

# graph
bar_chart









install.packages("rnaturalearth") #package that allows access to Natural Earth map data.
install.packages("rnaturalearthdata") #this package provides the actual Natural Earth datasets.


library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
library(dplyr)
library(plotly)

# Load world map data from rnaturalearth
world <- ne_countries(scale = "medium", returnclass = "sf")

# merging oil production data with world map 
map_data <- world %>%
  left_join(oildataset, by = c("name" = "Country"))


# geospatial map 
library(ggplot2)
library(plotly)
library(sf)        # For spatial data
library(viridis)   # For color scales

# creating a simple geospatial map for oil production
geo_map <- ggplot(map_data) +
  geom_sf(aes(fill = `Oil Production (Thousand B/D)`), color = "white") +  # Fill countries with oil production data
  scale_fill_gradientn(colors = c("purple", "coral2", "darkgoldenrod2"), na.value = "gray") + 
  labs(title = "Global Oil Production in the year 2022", fill = "Thousand B/D") +  # Adding titles and legend labels
  theme_minimal() +  # Simple theme
  theme(plot.title = element_text(hjust = 0.5))  # Center the title

# normal graph to interactive
interactive_geo_map <- ggplotly(geo_map)

# display
interactive_geo_map

