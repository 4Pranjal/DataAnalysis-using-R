# Required Libraries
library(ggplot2)
library(dplyr)
library(reshape2)
library(viridis)
library(scales)

# Read Data 
app_data <- read.csv("AppleStore.csv")

# Initialize an empty list to store plots
plot_list <- list()

# Histograms
# Plot 1: Histogram of User Ratings
plot_list[[1]] <- ggplot(app_data, aes(x=user_rating)) +
  geom_histogram(binwidth=0.5, fill="blue", color="black") +
  labs(title="Distribution of User Ratings", x="User Rating", y="Frequency") +
  theme_minimal()

# Plot 2: Histogram of App Sizes
plot_list[[2]] <- ggplot(app_data, aes(x=size_bytes)) +
  geom_histogram(binwidth=50000000, fill="yellow", color="black") +
  labs(title="Distribution of App Sizes", x="Size (bytes)", y="Frequency") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

# Density Plots
# Plot 3: Density Plot of App Sizes
plot_list[[3]] <- ggplot(app_data, aes(x=size_bytes)) +
  geom_density(fill="cyan", alpha=0.5) +
  labs(title="Density of App Sizes", x="Size (bytes)", y="Density") +
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::scientific) +
  theme_minimal()

# Plot 4: Density Plot of User Ratings
plot_list[[4]] <- ggplot(app_data, aes(x=user_rating)) +
  geom_density(fill="red", alpha=0.5) +
  labs(title="Density of User Ratings", x="User Rating", y="Density") +
  theme_minimal()

# Scatter Plots
# Plot 5: Scatter Plot of Size vs. User Ratings
plot_list[[5]] <- ggplot(app_data, aes(x=size_bytes, y=user_rating)) +
  geom_point(color="red", alpha=0.6) +
  labs(title="App Size vs. User Ratings", x="Size (bytes)", y="User Rating") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

# Plot 6: Scatter Plot of Price vs. User Ratings
plot_list[[6]] <- ggplot(app_data, aes(x=price, y=user_rating)) +
  geom_point(color="orange") +
  labs(title="Price vs. User Ratings", x="Price (USD)", y="User Rating") +
  theme_minimal()

# Define filtered_data for Plot 8 and Plot 19
top_5_content_ratings <- app_data %>%
  filter(!is.na(cont_rating)) %>%
  count(cont_rating, sort = TRUE) %>%
  top_n(5, n) %>%
  pull(cont_rating)

filtered_data <- app_data %>%
  filter(cont_rating %in% top_5_content_ratings, !is.na(size_bytes), !is.na(ver)) %>%
  mutate(ver = as.numeric(ver)) %>%
  filter(!is.na(ver))  # Remove rows with NA versions after conversion

# Plot 8: Boxplot of User Ratings by Content Rating
plot_list[[8]] <- ggplot(filtered_data, aes(x=cont_rating, y=user_rating)) +
  geom_boxplot(fill="lightblue", color="darkblue") +
  labs(title="User Ratings by Content Rating", x="Content Rating", y="User Rating") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Plot 9: Boxplot of Price by Prime Genre
plot_list[[9]] <- ggplot(app_data, aes(x=prime_genre, y=price)) +
  geom_boxplot(fill="pink") +
  labs(title="App Price by Genre", x="Genre", y="Price") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

# Violin Plot
# Plot 10: Violin Plot of User Ratings by Genre
plot_list[[10]] <- ggplot(app_data, aes(x=prime_genre, y=user_rating)) +
  geom_violin(fill="lightblue") +
  labs(title="User Ratings by Genre", x="Genre", y="User Rating") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

# Bar Plots
# Plot 11: Bar Plot of Apps by Prime Genre (Improved Readability)
plot_list[[11]] <- ggplot(app_data, aes(x=prime_genre)) +
  geom_bar(fill="purple") +
  labs(title="Number of Apps by Genre", x="Genre", y="Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

# Plot 12: Bar Plot of Content Ratings
plot_list[[12]] <- ggplot(app_data, aes(x=cont_rating)) +
  geom_bar(fill="green") +
  labs(title="Count of Apps by Content Rating", x="Content Rating", y="Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip()

# Plot 13: Bar Plot of Number of Supported Devices
plot_list[[13]] <- ggplot(app_data, aes(x=sup_devices.num)) +
  geom_bar(fill="brown") +
  labs(title="Number of Supported Devices", x="Number of Supported Devices", y="Count") +
  theme_minimal()

# Plot 14: Top 10 Apps by User Rating
top_10_apps <- app_data %>%
  arrange(desc(user_rating)) %>%
  head(10)
plot_list[[14]] <- ggplot(top_10_apps, aes(x=reorder(track_name, user_rating), y=user_rating)) +
  geom_bar(stat="identity", fill="steelblue") +
  labs(title="Top 10 Apps by User Rating", x="App Name", y="User Rating") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme_minimal() +
  coord_flip()

# Plot 15: Top 10 Genres by Number of Apps
top_10_genres <- app_data %>%
  group_by(prime_genre) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  head(10)
plot_list[[15]] <- ggplot(top_10_genres, aes(x=reorder(prime_genre, count), y=count)) +
  geom_bar(stat="identity", fill="purple") +
  labs(title="Top 10 Genres by Number of Apps", x="Genre", y="Number of Apps") +
  theme_minimal() +
  coord_flip()

# Correlation Heatmap
# Plot 16: Correlation Heatmap
cor_matrix <- round(cor(select(app_data, rating_count_tot, rating_count_ver, user_rating, user_rating_ver, size_bytes, price), use="complete.obs"), 2)
melted_cor_matrix <- melt(cor_matrix, varnames = c("Variable1", "Variable2"))
plot_list[[16]] <- ggplot(data = melted_cor_matrix, aes(x=Variable1, y=Variable2, fill=value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  labs(title="Correlation Matrix Heatmap", x="", y="") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme_minimal()

# Pie Charts
# Plot 17: Pie Chart of Prime Genre Distribution
plot_list[[17]] <- ggplot(app_data, aes(x="", fill=prime_genre)) +
  geom_bar(width=1) +
  coord_polar("y") +
  labs(title="Prime Genre Distribution") +
  theme_void() +
  theme(legend.position="right")

# Plot 18: Pie Chart of Free vs Paid App Comparison with Percentages
price_type_data <- app_data %>%
  mutate(price_type = ifelse(price == 0, "Free", "Paid")) %>%
  group_by(price_type) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)
plot_list[[18]] <- ggplot(price_type_data, aes(x="", y=percentage, fill=price_type)) +
  geom_bar(width=1, stat="identity") +
  coord_polar("y") +
  geom_text(aes(label = scales::percent(percentage/100)), position = position_stack(vjust = 0.5)) +
  labs(title="Free vs Paid App Comparison") +
  theme_void() +
  theme(legend.position="right")

# Line Plot
# Plot 19: Average App Size by Top 5 Content Ratings Over Versions
# Calculate the average app size for each version and content rating
average_size_by_version_rating <- filtered_data %>%
  group_by(ver, cont_rating) %>%
  summarise(average_size = mean(size_bytes, na.rm = TRUE)) %>%
  arrange(ver)

# Improved line plot
# top 5 and lowest 5 versions by average app size
top_versions <- average_size_by_version_rating %>%
  group_by(ver) %>%
  summarise(average_size = mean(average_size, na.rm = TRUE)) %>%
  top_n(5) %>%
  arrange(desc(average_size)) %>%
  pull(ver)

lowest_versions <- average_size_by_version_rating %>%
  group_by(ver) %>%
  summarise(average_size = mean(average_size, na.rm = TRUE)) %>%
  top_n(5, wt = -average_size) %>%
  arrange(average_size) %>%
  pull(ver)

# Filter data for the selected versions
filtered_data_top <- average_size_by_version_rating %>%
  filter(ver %in% top_versions)

filtered_data_lowest <- average_size_by_version_rating %>%
  filter(ver %in% lowest_versions)

# Create line plots for top and lowest versions
plot_list[[19]] <- ggplot(filtered_data_top, aes(x=ver, y=average_size, color=cont_rating)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = seq(min(filtered_data_top$ver), 
                                  max(filtered_data_top$ver), by = 1)) +
  labs(title="Average App Size by Top 5 Content Ratings Over Versions (Top Versions)", x="Version", y="Average Size (bytes)") +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "bottom")

plot_list[[20]] <- ggplot(filtered_data_lowest, aes(x=ver, y=average_size, color=cont_rating)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = seq(min(filtered_data_lowest$ver), 
                                  max(filtered_data_lowest$ver), by = 1)) +
  labs(title="Average App Size by Top 5 Content Ratings Over Versions (Lowest Versions)", x="Version", y="Average Size (bytes)") +
  scale_y_continuous(labels = scales::comma) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "bottom")

# Stacked Bar Chart
# Plot 21: Stacked Bar Chart of User Ratings by Content Rating
app_data$user_rating_category <- cut(app_data$user_rating, breaks=c(0, 1, 2, 3, 4, 5), labels=c("0-1", "1-2", "2-3", "3-4", "4-5"))
plot_list[[21]] <- ggplot(app_data, aes(x=cont_rating, fill=user_rating_category)) +
  geom_bar(position="fill") +
  scale_fill_viridis(discrete=TRUE) +
  labs(title="Distribution of User Ratings by Content Rating", x="Content Rating", y="Proportion", fill="User Rating") +
  theme_minimal()

# Save all plots to a single PDF
pdf("all_plots55.pdf", width = 10, height = 8)
for (plot in plot_list) {
  print(plot)
}
dev.off()
