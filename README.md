# Data Analysis and Visualization of Apple Store Apps

Welcome to the repository for the analysis and visualization of Apple Store apps using R. This project leverages various R libraries to clean, process, and visualize data to uncover valuable insights about app attributes, user ratings, and market trends.

[![GitHub Repo](https://img.shields.io/badge/GitHub-Repo-brightgreen)](https://github.com/4Pranjal/DataAnalysis-using-R/)

## Overview

In this project, we explore a dataset from Kaggle containing detailed information about apps available on the Apple App Store. Through a series of visualizations, we aim to understand user preferences, app trends, and key factors that contribute to app popularity.

## Methodology

### Data Collection

- **Source**: [Kaggle - Apple Store Analysis: Trends and Patterns](https://www.kaggle.com/code/nileshely/app-store-analysis-trends-and-patterns)
- **Dataset**: AppleStore.csv, containing various attributes of Apple Store apps.

### Data Preprocessing

Data preprocessing is crucial for accurate analysis. The dataset was clean and pre-processed, allowing us to directly load and analyze it using the following R libraries:

- `ggplot2`
- `dplyr`
- `reshape2`
- `viridis`
- `scales`

### Visualization Techniques

We employed a variety of plot types to visualize the data, each providing unique insights:

- **Histograms & Density Plots**: Distribution of app sizes and user ratings.
- **Scatter Plots**: Relationship between app size/price and user ratings.
- **Box Plots**: Comparison of user ratings and app prices across content ratings and genres.
- **Bar Plots & Pie Charts**: Distribution of app genres and the proportion of free vs. paid apps.
- **Correlation Heatmap**: Relationships between various app attributes.
- **Line Plots & Stacked Bar Charts**: Trends in app size over different versions and user ratings by content category.

## Key Insights

- **Top Genre**: Games dominate the app market.
- **Optimal App Size**: Apps under 150MB are more popular and highly rated.
- **User Demographics**: Majority of high-rating apps are suitable for ages 4+.
- **Version Preference**: Users show a preference for apps with version 3.13.

## Conclusion

Through this analysis, we gained significant insights into the Apple Store app market. The findings highlight the importance of optimizing app size, focusing on popular genres, and maintaining updated versions to meet user preferences.

## Future Work

To further enhance our analysis, incorporating more granular data such as yearly trends and regional statistics will provide deeper insights and help tailor development strategies more effectively.

## Repository Structure

- `data/`: Contains the dataset.
- `scripts/`: R scripts used for data preprocessing and visualization.
- `plots/`: Generated plots and visualizations.
- `docs/`: Detailed descriptions and interpretations of the visualizations.

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/4Pranjal/DataAnalysis-using-R.git
2. **Install necessary libraries**:
   ```bash
   install.packages(c("ggplot2", "dplyr", "reshape2", "viridis", "scales"))
3. **IRun the analysis:**:
   Execute the R scripts in the scripts directory to reproduce the analysis and generate visualizations.

## Contributions

Contributions are welcome! If you have any suggestions or improvements, feel free to open an issue or submit a pull request.
License

## This project is licensed under the MIT License - see the LICENSE file for details.
Contact

For any queries or feedback, please contact Pranjal.

 
