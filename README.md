# agronomic-data-automation-r
Automated data processing pipeline for multi-trait plant breeding trials. Uses functional programming in R to summarize plot-level statistics (Mean, SD, N) and analyze inter-plot variability


# Automated Agronomic Data Pipeline 

This project provides a robust framework for automating the summarization of field trial data. It transforms raw "Long Format" field observations into a structured "Wide Format" summary report, suitable for variety selection and breeding analysis.

## Project Overview
In agricultural research, data is often collected per plant but must be analyzed per **Plot**. "Project Connor" automates this aggregation for multiple traits including:
* **Yield Components:** Capsule Count, Caps Count Per Plant.
* **Morphology:** Plant Height, Internode Length, First Capsule Height.
* **Management:** Harvest Date, Plant Count at Harvest.

## Engineering Highlights
* **Functional Automation:** Developed the `summarise_trait()` function to eliminate repetitive code, using dynamic column naming (`!!paste0`).
* **Data Integration:** Utilizes `full_join` chains to merge disparate trait summaries into a single master ledger.
* **Variability Analysis:** Calculates **Within-group vs. Between-group variability** to assess the uniformity of experimental plots.
* **Statistical Comparison:** Integrated t-tests to compare specific plots against the trial average.

## Visual Analytics
The pipeline generates diagnostic plots to visualize trait distribution across plots, identifying outliers and performance gaps.



##  Tech Stack
* **Language:** R
* **Libraries:** `tidyverse` (dplyr, ggplot2, readr)
* **Methods:** Functional Programming, Descriptive Statistics, Variance Analysis.

##  Repository Structure
* `connor_pipeline.R`: The core automation script.
* `data/raw_field_data.csv`: Sample input file (plot, trait, value).
* `final_summary_traits.csv`: The generated master report.
