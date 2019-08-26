
# 2.dplyr_ R - With solutions

# Manipulating, analyzing and exporting data with tidyverse
# Heavely based on https://datacarpentry.org/R-ecology-lesson/03-dplyr.html, https://r4ds.had.co.nz and others (see ppt for references)
# March.2019


# General R
# Object names must start with a letter, and can only contain letters, numbers, underscore (_) and dots (.)
# If you get + in the console, after running some code, R is telling you that it's waiting for more input; it doesn't think you're done yet. 
# to get rid of that + sign, finish your line of code, or press Esc
# Consider that numeric, integer and double are the same

# Chunk 1  -------------------------------

# Working directory ----

# Set working directory. The place where the file(s) you want to call into R live
setwd("H:/R training/R and SNA Training CDPH/2.dplyr") # remember to reverse the back slash (\) to a normal slash (/)
      # Two other ways I do not use:
      # a)Use RStudio's Files pane to navigate to a directory and then set it as working directory from the menu: 
      #       Session -> Set Working Directory -> To Files Pane Location (You'll see even more options there)
      # b)Within the Files pane, choose More and Set As Working Directory
# Get working directory
getwd()
# List files in my wd
list.files()
#list files that end with the word "csv"
list.files (pattern = "csv$")

# # Move one folder up
setwd('..')
getwd() # check where you are now
list.files() # List files in the wd
# List objects we have created in this R session
ls() # none yet! You can use this command later on


# Read a csv file ----  
# Download combined data from: https://figshare.com/articles/Portal_Project_Teaching_Database/1314459
setwd("H:/R training/R and SNA Training CDPH/2.dplyr")
surveys_base <- read.csv("combined.csv") # The file you want to read must be inside your working directory!
# Did it work? Check the environment

# Explore your dataset ----
#Size:
dim(surveys_base) # returns a vector with the number of rows in the first element, and the number of columns as the second element (the dimensions of the object)
nrow(surveys_base) # returns the number of rows
ncol(surveys_base) # returns the number of columns

#Content:
head(surveys_base) # shows the first 6 rows 
tail(surveys_base) # shows the last 6 rows

#Names:
names(surveys_base) # returns the column names (synonym of colnames() for data.frame objects)
#rownames(surveys_base) # returns the row names

#Summary:
str(surveys_base) # structure of the object and information about the class, length and content of each column
summary(surveys_base) # summary statistics for each column

# View entire df
View(surveys_base) # a new tab will open



## >> C1.1.Exercise  ----
#   Based on the output of str(surveys), can you answer the following questions?
#   What is the class of the object surveys? 'data.frame'
#   How many rows and how many columns are in this object? 34786 rows and 13 columns
#   How many species have been recorded during these surveys? 40
#   Note the empty values in variable sex. Why may this be happening? TIP: Exploring the output of str() should make you think on using levels()
str(surveys_base)
levels(surveys_base$sex) # R doesn't read the "empty" values in sex as NA. R thinks there is a level that is ""
## FIN Exercise  



## >> C1.2.Exercise  ----
# Create a data.frame (df) called surveys_200 containing only the data in row 200 of the surveys df.
surveys_200 <- surveys_base[200,]
surveys_200
surveys_base[200,]

# Create a df called surveys_last containing only the data in the last row of the surveys df using two different commands. 
# TIP: You can use nrow() and tail().
# Option one
nrow(surveys_base)
surveys_base[34786,] # using the row number
surveys_base[nrow(surveys_base),] # using indexing of a df combined with nrow(). This is better! Only one line of code :)
# Option two:
tail(surveys_base,1) # Starting from the bottom tail (from the end of the df), extract the first element of surveys df
tail(surveys_base,1) == surveys_base[nrow(surveys_base),] # Are my results equivalent? 

# choose any of those methods to create surveys_last:
surveys_last <- tail(surveys_base,1)
## FIN Exercise



## >> C1.3.Exercise  ----
# Load the file nodes_data_final.csv into an object called nodes_base and explore its values
nodes_base<-read.csv("nodes_data_final.csv") # This file must be inside your working directory!
str(nodes_base)
head(nodes_base)
summary(nodes_base)
# What type of premises do we have?
summary(nodes_base)
summary(nodes_base$premise_type)
levels(nodes_base$premise_type)
## FIN Exercise
# INSTALL TIDYVERSE!!!


# Chunk 2  -------------------------------

# tidyverse ----
# Packages
    # Install: You only need to install a package ONCE in all your R/Rstudio life.
    # However, if you update R/Rstudio, you'll need to install the package again (only ONCE again)
# install.packages("tidyverse") # Use only once
library(tidyverse) # I usually put all my libraries at the beginning of the R script
        # dplyr overwrites some functions in base R. 
        # If you want to use the base version of these functions after loading dplyr, you'll need to use their full names: stats::filter() and stats::lag()
        # tidyverse_conflicts() # lists all the conflicts between packages in the tidyverse and other packages that you have loaded.
        # suppressWarnings(suppressMessages(library(tidyverse)))
# Get info about the package
#packageDescription("tidyverse")
#help(package = "tidyverse")


# tidyverse has a different way of reading files
# Earlier, we read our data as: using read.csv()
# tidyverse - specifically the package "readr" - uses a similar but different function read_csv()

surveys <- read_csv("combined.csv")
surveys
      # Note that readr automatically guesses the class/type of each column, 
      # but it does not automatically convert strings to factors (as read.csv() does!)
      # You can override the default guess through the read_csv() argument col_types:
            # Copy-paste the parsed code, and then tweak it to fix the parsing problems as shown below.
            surveys <- read_csv("combined.csv", 
                                col_types = cols(
                                  record_id = col_double(),
                                  month = col_double(),
                                  day = col_double(),
                                  year = col_double(),
                                  plot_id = col_double(),
                                  species_id = col_factor(), # changed to factor
                                  sex = col_factor(), # changed to factor
                                  hindfoot_length = col_double(),
                                  weight = col_double(),
                                  genus = col_factor(), # changed to factor
                                  species = col_factor(), # changed to factor
                                  taxa = col_factor(), # changed to factor
                                  plot_type = col_factor() # changed to factor
                                    )
                                ) 
surveys
      

# Compare differences between the two survey files (base-R and tidyverse):
head(surveys_base) # base-R, read as read.csv()
head(surveys) # tidyverse,  read as read_csv()
#Tibbles are similar to data frames, but are slightly tweaked to work better in the tidyverse
# https://www.tidyverse.org/articles/2018/12/readr-1-3-1/
str(surveys_base)
str(surveys)

class(surveys_base)
class(surveys)









# There are two main differences between data.frames and tibbles:
      # 1. PRINTING
      #surveys_base # automatically prints it all (or the maximum specified in your Rstudio. See getOption("max.print") )
      surveys # only prints the first 10 rows
      #View(surveys) # If you want to see it all
      # if you want to print 15 rows of a tibble:
      print(surveys, n = 15) 
      print(surveys, n = 15, width = Inf) # width = Inf indicates that we want all columns 
                                          # => Important if width of source is small!
      print(surveys, n = 15) # run this line with a narrow Console window to see what happens!
      head(surveys, 15) # same as head(surveys, n = 15)
      
      # 2. INDEXING (or Subsetting)
      # Single-square brackets [] and $ are not much used to subset, instead, use filter() or select(), althogh you can still use:
      # surveys %>% .$month # where %>% is a "pipe". It reads as "then...". More about this, below.
      # surveys %>% .[["month"]]
      # surveys$month 

      # Some older functions don't work with tibbles. 
      # The main reason for some functions not to run properly is the [ function. 
      # We don't use [ much in tidyverse because dplyr::filter() and dplyr::select() 
      # allow you to solve the same problems with clearer code.
      
      # With base-R data frames, [ sometimes returns a data frame, and sometimes it returns a vector. This is not consistent!
      # With tibbles, [ always returns another tibble.
              # Example for two dimensional single-square brackets subsetting
              class(surveys[,"month"]) # returns a tibble
              class(surveys[,c("month", "day")]) # returns a tibble
              
              class(surveys_base[,"month"]) # returns a vector (integer vector)
              class(surveys_base[,c("month", "day")]) # returns a data.frame
      
      # $ always returns a vector (you may see that some people use [[ as $ => $ is a shortcut for [[ )

              class(surveys$month) # returns a vector (numeric vector)
              class(surveys_base$month) # returns a vector (integer vector)
              

              
# If you encounter one of the functions that don't work with tibbles, use as.data.frame() to turn a tibble back to a data.frame
as.data.frame(surveys)        
# If you want to transfrom a data frame to a tibble, use as_tibble()
as_tibble(surveys_base)






# Chunk 3  -------------------------------
# Functions from dplyr ----
# The first argument is always the data you want to work with

# > 1. Selecting columns and filtering rows ----
select(surveys, plot_id, species_id, weight)
select(surveys, -record_id, -species_id)# remove columns
select(surveys, plot_id,-record_id)
filter(surveys, year==1995) # same as old (base-R): surveys[which(surveys$year == 1995),]


## >> C3.1.1.Exercise  ----
# read the nodes_data_final.csv file using the tidiverse function read_csv() from the readr package
nodes<-read_csv("nodes_data_final.csv") # This file must be inside your working directory!
# Subset the df nodes choosing only the farm nodes and print only the first 6 rows of it.
filter(nodes,premise_type == "farm")
head(filter(nodes,premise_type == "farm"))

# Subset the df nodes choosing only the geocoordinates variables, and print the first 18 rows of it
select(nodes, latitude, longitude)
head(select(nodes, latitude, longitude), 18)

# Subset the df nodes choosing only the geocoordinates variables of the farm nodes.

    # This is the so called intermediate step (it has two distinct steps). But there is a better way!
    df_premise_type <- filter(nodes,premise_type == "farm")
    select(df_premise_type, latitude, longitude) 
    
    # This is the so called nested function. But there is a better way!
    select(filter(nodes,premise_type == "farm"), latitude, longitude)
    
# Did you notice what happened with the decimal points in longitude/latitude? try imputting your code in: print.data.frame()
    print.data.frame(head(select(nodes, latitude, longitude)))
## FIN Exercise
      
    
    
     
# > 2. Pipes ----
# What if you want to select and filter at the same time? 
# There are three ways to do this: use intermediate steps, nested functions (both of them already seen above), or pipes.
        
        # 2.a Intermediate
        surveys2 <- filter(surveys, weight < 5)
        surveys_int <- select(surveys2, species_id, sex, weight)
        surveys_int
        
        # 2.b Nested functions
        surveys_nested <- select(filter(surveys, weight < 5), species_id, sex, weight)
        surveys_nested
        
        # 2.c Pipes: (Cnt) + (Shift) + (M) = %>% = "then..."): 
        # Take the data frame surveys, 
        # then, filter for rows with weight < 5,
        # then, select columns species_id, sex, and weight.
        surveys %>%
          filter(weight < 5) %>%
          select(species_id, sex, weight)
        
        surveys %>%
          filter(weight < 5) %>%
          select(species_id, sex, weight) %>% 
          print(n=10) # print indicates how many rows I want to print
        
        
## >> C3.2.1.Exercise  ----
# Using pipes, subset the surveys data to include animals collected before 1995 
# and retain only the columns year, sex, and weight.
surveys %>% 
  filter(year<1995) %>% 
  select(year, sex, weight)
## FIN Exercise

## >> C3.2.2.Exercise  ----
# Using pipes, subset the df nodes choosing only the geocoordinates variables of the farm nodes.
nodes %>% 
    filter(premise_type == "farm") %>% 
    select(latitude, longitude)
        
print.data.frame(nodes %>% 
    filter(premise_type == "farm") %>% 
    select(latitude, longitude))      
## FIN Exercise

# > 3. Arrange ---- 
# Rearrange the result of a query to inspect the values. 
arrange(surveys, weight) # increasing order
arrange(surveys, desc(weight)) # decreasing order   

 #Missing values are always sorted at the end 
tail(arrange(surveys, weight)) # increasing order
tail(arrange(surveys, desc(weight))) # decreasing order


## >> C3.3.1.Exercise  ----
# Using pipes and surveys df, create a df ordered by weight (increasing order), 
# with columns species_id, sex, and weight,
# and where we only have those weight values that are lower than the average weight,
# Print the first 13 observations.
# TIP: My instructions may or may not correspond with the order in which you need to type the commands. 
# TIP: Remember that some functions need help when dealing with NA        

surveys %>%
  filter(weight < mean(weight, na.rm = TRUE)) %>%
  arrange(weight) %>% 
  select(species_id, sex, weight) %>% 
  print(n=13)

surveys %>% 
    select(species_id, sex, weight) %>% 
    filter(weight < mean(weight, na.rm=TRUE)) %>% 
    arrange(weight) %>% 
    print(n=13)

## FIN Exercise


        
# > 4. Mutate ----
# Create new columns based on the values in existing columns

surveys %>%                                # Take the df surveys, then...
  mutate(weight_kg = weight / 1000,        # Create a variable weight variable in kg (instead of grams)
         weight_kg2 = weight_kg * 2) %>%          # and create a variable that contains the square value of the weight variable in kg, then...
  head()                                   # Show me the first 6 rows of what I just did

surveys %>%                                # Take the df surveys, then...
  mutate(weight_kg = weight / 1000,        # Create a variable weight variable in kg (instead of grams)
         weight_kg2 = weight_kg * 2) %>%          # and create a variable that contains the weight variable in kg times two, then...
  print(n=15)                               # Show me the first 15 rows of what I just did

      
# Remove NAs in weight variable:
surveys %>%                               # Take the df surveys, then...
  filter(!is.na(weight)) %>%              # Select only the values that are NOT NA, then... 
  mutate(weight_kg = weight / 1000) %>%   # Create a variable weight variable in kg (instead of grams), then...
  head()                                  # Show me the first 6 rows of what I just did


## >> C3.4.1.Exercise  ----
# Create a new df (called surveys_hindfoot_half) from the surveys data that meets the following criteria: 
      # Contains only the species_id column and a new column called hindfoot_half containing
                                          # values that are half the hindfoot_length values. 
      # Once you create the hindfoot_half column, be sure that there are no NAs and all values are less than 30.

surveys_hindfoot_half1<-surveys %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(!is.na(hindfoot_half)) %>% 
  filter(hindfoot_half<30) %>% 
  select(species_id, hindfoot_half)

surveys_hindfoot_half2<-surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half= hindfoot_length/2) %>% 
  filter(hindfoot_half<30) %>% 
  select(species_id, hindfoot_half)

summary(surveys_hindfoot_half1 == surveys_hindfoot_half2) # Are my two options equivalent? Yes! :)

surveys_hindfoot_half3 <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  filter(hindfoot_length <30) %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  select(species_id, hindfoot_half)

summary(surveys_hindfoot_half3 == surveys_hindfoot_half1) # they don't even have the same dimensions!
dim(surveys_hindfoot_half3)
dim(surveys_hindfoot_half1)
dim(surveys_hindfoot_half2)
## FIN Exercise


## >> C3.4.2.Exercise  ----
# Load the file edges_data_final.csv into an object called edges and explore its values.
# Make sure origin, dest, month, origin_type and dest_type are factors
edges<-read_csv("edges_data_final.csv") # This file must be inside your working directory!

edges <- read_csv("edges_data_final.csv",
  col_types = cols(
    origin = col_factor(),
    dest = col_factor(),
    month = col_factor(),
    nb_pigs = col_double(),
    longitude1 = col_double(),
    latitude1 = col_double(),
    longitude2 = col_double(),
    latitude2 = col_double(),
    origin_type = col_factor(),
    dest_type = col_factor()
  )
)

str(edges)
head(edges)
summary(edges)
dim(edges)
summary(is.na(edges))

# Create a new variable in edges called nb_pigs_abvmean. 
# This variable should be one (1) if the nb_pigs is above the mean of nb_pigs, and zero (0) otherwise.
# TIP: 
# Check ifelse() documentation, once you understand how the ifelse() function works - it
# is very similar to IF function in excel-, use a pipe and mutate. 
# You will insert the ifelse() function inside mutate()
# Store the results in an object called edges_abvmean
edges_abvmean <- edges %>% 
  mutate(nb_pigs_abvmean = ifelse(nb_pigs > mean(nb_pigs), 1, 0))
edges_abvmean

## FIN Exercise
# Break


# > 5. Split-apply-combine ----
# Split the data into groups, apply some analysis to each group, and then combine the results
# gourp_by and summarise/summarize

# Compute the mean weight, by sex
surveys %>%  
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
  # ?forcats::fct_explicit_na =>  gives missing value an explicit factor level
  surveys %>%  
    group_by(fct_explicit_na(sex)) %>%
    summarize(mean_weight = mean(weight, na.rm = TRUE))

# Compute the mean weight, by sex and species_id
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) # A tibble: 92 x 3
  
# Note: arrange() after group_by()+summaruse() needs another argument:
        surveys %>%
            group_by(sex) %>%
            arrange(weight) %>%  # Not doing as expected! It is mixing Males and Females!
            print(n=20)
        
        surveys %>%
            group_by(sex) %>%
            arrange(weight, .by_group = TRUE) %>%  # Now it does behave! :)
            print(n=20)

# Remove the NAs of weight
surveys %>%
  filter(!is.na(weight)) %>% # Remove the NAs of weight at the beginning, so no need to specify na.rm = TRUE when doing the mean
  group_by(sex, species_id) %>% # Note we still have NA in sex
  summarize(mean_weight = mean(weight)) %>% # A tibble: 64 x 3
  print(n=13)

# To what we have above, add a column indicating the minimum weight for each species for each sex 
# and then sort on min_weight putting the heavier species first
surveys %>% 
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>% # column for min weight
  arrange(desc(min_weight)) # descending order by min_weight
  # We forgot  .by_group = TRUE !! See below and compare:                  
  surveys %>% 
    filter(!is.na(weight)) %>%
    group_by(sex, species_id) %>%
    summarize(mean_weight = mean(weight),
              min_weight = min(weight)) %>% 
    arrange(desc(min_weight), .by_group = TRUE)
 

## >> C3.5.1.Exercise  ----
# Using edges df, use group_by() and summarize() to find the mean, min, and max nb_pigs for each origin_type 
# Also add the number of observations (TIP: see ?n). Using edges df
edges  %>% 
  group_by(origin_type) %>% 
  summarize(mean_nbp = mean(nb_pigs),
            min_nbp = min(nb_pigs),
            max_nbp = max(nb_pigs),
            nb_obs = n())
## FIN Exercise
  
## >> C3.5.2.Exercise  ----
# When (month) did the largest transfer of pigs occured?
edges %>% 
  group_by(month) %>% 
  summarise(largest = max(nb_pigs)) %>% 
  arrange(desc(largest), .by_group= TRUE) # July, with 350 pigs

edges %>% 
  group_by(month) %>% 
  filter(nb_pigs == max(nb_pigs)) %>% 
  arrange(desc(nb_pigs)) # Note how arrange only needs the .by_group() argument if we run it just after group_by()+summarise(). 

edges %>% 
  group_by(month) %>% 
  filter(nb_pigs == max(nb_pigs)) %>% 
  arrange(desc(nb_pigs), .by_group = TRUE)  #   Adding .by_group = TRUE in this line of code messes things up.
## FIN Exercise

# > 6. Count ---- 
# Creates frequency tables
    # One factor
    surveys %>%
      count(sex)  
  
    surveys %>%
      count(sex, sort = TRUE) # if TRUE, R will sort the output in descending order of n (from higher to lower)
    
    surveys %>%
      count(sex, sort = FALSE) # Not behaving??
  
    # same as:
    surveys %>%
      group_by(sex) %>%
      summarise(count = n())

    # Combine factors
    surveys %>%
      count(sex, species)

    # Arrange the table above in:
    # (i) an alphabetical order of the levels of the species and
    # (ii) in descending order of the count
    surveys %>%
      count(sex, species) %>%
      arrange(species, desc(n)) 
    
## >> C3.6.1.Exercise  ----
# Using edges df, how many transfers happened on March?
edges %>% 
  group_by(month) %>% 
  summarise(nb_transfers = n()) # 16 transfers

edges %>% 
  count(month)
## FIN Exercise

## >> C3.6.2.Exercise  ----
# Using edges df, how many nb_pigs were transfered on March?
edges %>% 
  group_by(month) %>% 
  count(sum(nb_pigs)) # 1479 pigs

edges %>% 
  group_by(month) %>% 
  summarise(n_obs = sum(nb_pigs)) # 1479 pigs
## FIN Exercise

## >> C3.6.3.Exercise  ----
# Using nodes df, create a frequency table of premise_type and scale
nodes %>% 
  count(premise_type, scale)
## FIN Exercise


# Chunk 4  -------------------------------
# install.packages("magick")
library(magick)

# > 7. Spread ----
spread_pic <- image_read('H:/R training/R and SNA Training CDPH/2.dplyr/spread_pic.png')
print(spread_pic)

# Find the mean weight of each genus in each plot over the entire survey period
# 7.a. Filter our observations and variables of interest, and create a new variable for the mean_weight
  head(surveys)      
  surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarize(mean_weight = mean(weight))

head(surveys_gw)

# It will be more usefull to have a row for each plot and a columnn for each genus, with teh mean_weight values as cell values.
# Using spread(), use genus as key and populate the cells with the values of mean_weight
# Remember the structure: data %>% spread( key , value ) 
surveys_spread <- surveys_gw %>% spread(key = genus, value = mean_weight)  # One row for each plot

head(surveys_spread)
str(surveys_spread)

 
## >> C4.7.1.Exercise  ----
# Spread the surveys data frame with year as columns, plot_id as rows, and the number 
# of genera (plural for genus) per plot as the values. You will need to summarize before reshaping, 
# and use the function n_distinct() to get the number of unique genera (genus) within a 
# particular chunk of data. It's a powerful function! See ?n_distinct for more.
# Name this new object surveys_sprd

surveys_sprd <- surveys %>%  
  group_by(plot_id, year) %>% 
  summarise(nb_genera = n_distinct(genus)) %>% 
  spread (key = year, value= nb_genera) 

head(surveys_sprd)
## FIN Exercise




# > 8. Gather ----
gather_pic <- image_read('H:/R training/R and SNA Training CDPH/2.dplyr/gather_pic.png')
print(gather_pic)
# Create a key called genus and value (new column) called mean_weight and use all columns except plot_id
# Remember the structure: data %>% gather( key , value , var-to-be-removed) 
surveys_gather <- surveys_spread %>% gather(key = genus, value = mean_weight, -plot_id)

head(surveys_gather)
str(surveys_gather)

# using the : operator:
surveys_spread %>%
  gather(key = genus, value = mean_weight, Baiomys:Spermophilus) %>%
  head()

## >> C4.8.1.Exercise  ----
# b.Take surveys_sprd and gather() it, so that each row is a unique plot_id by year combination.
surveys_sprd %>% gather(key = year, value=nb_genera, -plot_id)
## FIN Exercise





# NAs and dplyr ----
# Keep only those complete cases (no NAs)
surveys # A tibble: 34,786 x 13
summary(is.na(surveys))

surveys %>% na.omit # A tibble: 30,676 x 13
surveys %>% filter(complete.cases(.)) # A tibble: 30,676 x 13
library(tidyr)
surveys %>% drop_na # A tibble: 30,676 x 13
surveys %>% filter(!is.na(sex)) # If you want to filter based on one variable's missingness
                                # A tibble: 33,038 x 13


# Export your df into a csv ----
#write_csv(edges_abvmean, path = "new_edges_abvmean.csv")


# Quitting R ----
# Save your script (although you should really be doing it constantly while coding)
# When quitting R and saving workspace image - if desired! => Saved as ".RData" file
# I only do it if I have been running heavy models that took hours to run.


# SUMMARY of this workshop ----

# Choose column: select()

# Choose row: filter()

# Link the output of one dplyr function to the input of another function with the 'pipe' operator %>%

# Add columns: mutate() 

# group_by() takes as arguments the column names that contain the categorical variables for which 
# you want to calculate the summary statistic

# summarize() collapses each group into a single-row summary of that group

# Print specific number of rows: use the print() function at the end of your 
# chain with the argument n= specifying the number of rows to display

# count(): Number of observations found for each factor or combination of factors

# spread() makes wide data (from long). Takes three principal arguments:
      # the data
      # the key column variable whose values will become new column names.
      # the value column variable whose values will fill the new column variables.

# gather() makes long format (form wide). Takes four principal arguments
      # the data
      # the key column variable we wish to create from column names.
      # the value column variable we wish to create and fill with values associated with the key.
      # the names of the columns we use to fill the key variable (or to drop).






