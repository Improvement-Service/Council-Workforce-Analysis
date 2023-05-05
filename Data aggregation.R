library(plyr)
library(tidyverse)
library(readxl)
library(openxlsx)

# Read in all council data --------------------------------------------------

# Directory path 
# (Folder: Research - Formatted Data, has been synced to personal drive)
folder_path <- "C:/Users/connachan.cara/IS/Research - Formatted Data/"


# Function to read clean data sheet of each council file and combine into 1 df
read_files <- function(directory_path, file) {
  # Paste the folder parth with the file name for the council in the loop
  xlsx_file <- paste0(directory_path, file)
  # read through each clean data sheet in each file and store in a data frame
  map_df("Clean Data", 
         read_excel,
         # specify column types so each files reads in the same
         # for some the date column is a date rather than text so need to convert
         col_types = c("text", 
                       "text", 
                       "text",
                       "text",
                       "text",
                       "numeric"
                       ),
         path = xlsx_file
         ) 
}

# List all the council files in the folder
master_data <- list.files(folder_path) %>% 
  # Run the read_files function, looping through each council file and store in a data frame
  map_df(~read_files(folder_path, .))
