library(tidyverse)

# 1. Data Ingestion -------------------------------------------------------
# Loading raw field data (Expected columns: plot, trait, value)
raw_data <- read_csv("data/raw_field_data.csv")

# 2. Functional Core ------------------------------------------------------
# This function automates the extraction and summarization of any trait
summarise_trait <- function(df, trait_name, prefix) {
  df %>%
    filter(trait == trait_name) %>%
    mutate(value = as.numeric(value)) %>%
    group_by(plot) %>%
    summarise(
      !!paste0("mean_", prefix) := mean(value, na.rm = TRUE),
      !!paste0("sd_", prefix) := sd(value, na.rm = TRUE),
      !!paste0("n_", prefix) := n(),
      .groups = "drop"
    )
}

# 3. Processing Pipeline --------------------------------------------------
# Batch processing of various agronomic indicators
height_stats  <- summarise_trait(raw_data, "Plant Height (Avg.)", "height")
caps_stats    <- summarise_trait(raw_data, "Capsule Count", "capsules")
yield_stats   <- summarise_trait(raw_data, "Caps Count In One Plant (Avg.)", "caps_per_plant")
internode_stats <- summarise_trait(raw_data, "Internode Length (Avg.)", "internodes")

# 4. Master Table Construction --------------------------------------------
final_summary <- height_stats %>%
  full_join(caps_stats, by = "plot") %>%
  full_join(yield_stats, by = "plot") %>%
  full_join(internode_stats, by = "plot") %>%
  arrange(plot)

# 5. Variability & Statistical Testing ------------------------------------
# Analyze "Plant Height" across plots
height_data <- raw_data %>% 
  filter(trait == "Plant Height (Avg.)") %>% 
  mutate(value = as.numeric(value))

# T-test example: Comparing a specific plot to the trial population
# Replace 'Plot_A' with your actual plot ID
plot_id <- "Plot_A"
plot_x <- height_data %>% filter(plot == plot_id) %>% pull(value)
others <- height_data %>% filter(plot != plot_id) %>% pull(value)
t_test_results <- t.test(plot_x, others)

# 6. Export ---------------------------------------------------------------
write_csv(final_summary, "results/final_agronomic_summary.csv")
