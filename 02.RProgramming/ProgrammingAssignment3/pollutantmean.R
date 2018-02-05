pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  ## Get a list of filenames
  filenames <- list.files(path=directory, pattern="*.csv")
  
  ## Initialize a vector to hold values
  vals <- vector()
  
  ## Loop over the passed id's
  for(i in id) {
    
    ## Pad the i to create a filename
    filename <- sprintf("%03d.csv", i)
    filepath <- paste(directory, filename, sep="/")
    
    ## Load the data
    data <- read.csv(filepath)
    
    ## Select our column
    d <- data[,pollutant]
    
    ## Ignore NAs
    d <- d[!is.na(d)]
    
    ## append to our vector
    vals <- c(vals, d)
  }
  
  ## Return the value rounded to 3 dec places
  round(mean(vals), 3)
}