# Code: basic harvesting of twitter info to csv format for curation
# Purpose: determine feasibility of twitter harvesting


# setup -------------------------------------------------------------------
library(twitteR)
library(tidyverse)

# functions ---------------------------------------------------------------
# Setting up the twitter 
# To fill this in, go to section 3 of: 
# http://geoffjentry.hexdump.org/twitteR.pdfß
setup_twitter_oauth(consumer_key = "your.key.here", 
                    consumer_secret = "your.secret.here",
                    access_token = "your.token.here",
                    access_secret = "your.access.secret.here")


# pipeline ----------------------------------------------------------------

# User input
data_dir <- "twitter.handle.csv.here"
out_dir <- "output.file.directory.here"
setwd(data_dir)

date_from <- "2019-02-01" 
date_to <- Sys.Date() %>% as.character()
preprints_only <- TRUE 

# Read in necessary data
sources <- read_csv(list.files(pattern = "scilit_handles")) %>%
    .[complete.cases(.),]

if(preprints_only == TRUE) {
    sources <- sources[sources$Category == "preprint",]
}

handles <- sources$Handle
source_names <- sources$Source

# Loops through each twitter handle of interest
tw_results <- lapply(seq(length(handles)), function(i) {
    curr <- searchTwitter(searchString = handles[i], 
                          n = 500, 
                          since = date_from,
                          until = date_to)
    if(length(curr) > 0) {
        curr <- twListToDF(curr)
    } else {
        return(NA)
    }
    
    curr$source <- source_names[i]
    Sys.sleep(30)
    message(paste(i, "of", length(handles), "complete"))
    
    return(curr)
}) %>%
    do.call(rbind, .) %>%
    as.tibble()
    
# Tidy
tw_results <- filter(tw_results, tw_results$isRetweet == FALSE) 
tw_results <- filter(tw_results, tw_results$screenName %in% handles)
cols_to_include <- c("source", "screenName", "created", "favoriteCount", "retweetCount", "text")
tw_final <- tw_results[,cols_to_include]
tw_final <- tw_final[order(tw_final$favoriteCount, decreasing = TRUE),]

# Output
setwd(out_dir)
write_csv(tw_final, paste("preprint.papers", date_from, date_to, "csv", sep = "."))

