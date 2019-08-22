---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Chunk 6"
summary:
date: 2019-08-22T11:08:20-04:00
lastmod: 2019-08-22T11:08:20-04:00
draft: false  # Is this a draft? true/false
toc: true  # Show table of contents? true/false
type: docs  # Do not modify.

# Add menu entry to sidebar.
# - Substitute `example` with the name of your course/documentation folder.
# - name: Declare this menu item as a parent with ID `name`.
# - parent: Reference a parent ID if this page is a child.
# - weight: Position of link in menu.
menu:
  new_r_and_sna:
    name: Chunk 6
    parent: 2. dplyr
    weight: 10
---

## **Basic `dplyr` functions**

As a summary, these are the main functions we are going to be working with:

* `select()`: Choose column
* `filter()`: Choose row
* Pipe operator `%>%`: Link the output of one `dplyr` function to the input of another function
* `mutate()`: Create new columns
* `group_by()` takes as arguments the column names that contain the categorical variables for which you want to calculate a summary statistic
* `summarize()` collapses each group into a single-row summary of that group
* `count()`: Number of observations found for each factor or combination of factors
* `spread()` makes wide data (from long)
* `gather()` makes long format (form wide)


Let's try them!

With `dplyr`, the first argument you will use is the data you want to work with (in our case, `surveys` - be sure to have it loaded into your RSession!):

## **1 - Selecting columns and filtering rows**

```{r, echo = TRUE}
select(surveys, plot_id, species_id, weight)
select(surveys, -record_id, -species_id)# remove columns
select(surveys, plot_id,-record_id)
filter(surveys, year == 1995) # same as old (base-R): surveys[which(surveys$year == 1995),]
```

**Exercise 1**: 

Read the `nodes_data_final.csv` file using the tidiverse function `read_csv()` from the `readr` package. To download the file, clink n this [hyperlink](https://raw.githubusercontent.com/EKuki/website/master/content/courses/new_r_and_sna/nodes_data_final.csv), right click and save as.

```{r, echo = TRUE}
nodes<-read_csv("nodes_data_final.csv") # This file must be inside your working directory!
# nodes<-read_csv("https://raw.githubusercontent.com/EKuki/website/master/content/courses/new_r_and_sna/nodes_data_final.csv")# If you want to load it directly from the web, you could use this code
```

Subset the df `nodes` choosing only the farm nodes and print only the first 6 rows of it.

```{r, echo = TRUE}
filter(nodes,premise_type == "farm")
head(filter(nodes,premise_type == "farm"))
```

Subset the df `nodes` choosing only the geocoordinates variables, and print the first 18 rows of it:

```{r, echo = TRUE}
select(nodes, latitude, longitude)
head(select(nodes, latitude, longitude), 18)
```

Subset the df `nodes` choosing only the geocoordinates variables of the farm nodes.
There are a few ways you could do this:

a - This is the so called intermediate step (it has two distinct steps). But there is a better way!

```{r, echo = TRUE}
    df_premise_type <- filter(nodes,premise_type == "farm")
    select(df_premise_type, latitude, longitude) 
```
    
b - This is the so called nested function. But there is a better way! (Pipes!)
```{r, echo = TRUE}
    select(filter(nodes,premise_type == "farm"), latitude, longitude)
    ```
    
> Did you notice what happened with the decimal points in longitude/latitude? Try embedding your code in: `print.data.frame()`

```{r, echo = TRUE}
print.data.frame(head(select(nodes, latitude, longitude)))
```

> End of Exercise 1
      
      
## **2 - Pipes `%>%`**

What if you want to select and filter at the same time? 
There are three ways to do this: use intermediate steps, nested functions (both of them already seen above), or pipes.
        
**a - Intermediate steps**        

```{r, echo = TRUE}
surveys2 <- filter(surveys, weight < 5)
        surveys_int <- select(surveys2, species_id, sex, weight)
        surveys_int
```        
**b - Nested functions**
```{r, echo = TRUE}
        surveys_nested <- select(filter(surveys, weight < 5), species_id, sex, weight)
        surveys_nested
```
**c - Pipes**
A shortcut on your keyboard is: `Cnt` + `Shift` + `M` = `%>%`. When you see a `%>%`, you can read it as "then...". Let's see an example, step by step. I am going to ask R to: 

* Take the data frame surveys,
* then, filter for rows with weight < 5,
* then, select columns species_id, sex, and weight.

```{r, echo = TRUE}
        surveys %>%               # Take the data frame surveys,
          filter(weight < 5) %>%  # then, filter for rows with weight < 5,
          select(species_id, sex, weight) # then, select columns species_id, sex, and weight.
        
        surveys %>%
          filter(weight < 5) %>%
          select(species_id, sex, weight) %>% 
          print(n=10) # print indicates how many rows I want to print
```        
        
**Exercise 2**:

Using pipes, subset the surveys data to include animals collected before 1995 and retain only the columns year, sex, and weight.

```{r, echo = TRUE}
surveys %>% 
  filter(year<1995) %>% 
  select(year, sex, weight)
```  
> End of Exercise 2

**Exercise 3**:

Using pipes, subset the df nodes choosing only the geocoordinates variables of the farm nodes.

```{r, echo = TRUE}
nodes %>% 
    filter(premise_type == "farm") %>% 
    select(latitude, longitude)
        
print.data.frame(nodes %>% 
    filter(premise_type == "farm") %>% 
    select(latitude, longitude))      
```

> End of Exercise 3


## **3 - Arrange**

Arrange allowes you to rearrange the result of a query to inspect the values. 

```{r, echo = TRUE}
arrange(surveys, weight) # increasing order
arrange(surveys, desc(weight)) # decreasing order   
```

Missing values are always sorted at the end:

```{r, echo = TRUE}
tail(arrange(surveys, weight)) # increasing order
tail(arrange(surveys, desc(weight))) # decreasing order
```

**Exercise 4**

Using pipes and surveys df, create a df ordered by weight (increasing order), with columns `species_id`, `sex`, and `weight`, and where we only have those weight values that are lower than the average weight. Print the first 13 observations.

>TIP: My instructions may or may not correspond with the order in which you need to type the commands. 

>TIP: Remember that some functions need help when dealing with NA        

```{r, echo = TRUE}
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
```

> End of Exercise 4

## **4 - Mutate**

Mutate creates new columns based on the values in existing columns.

```{r, echo = TRUE}
surveys %>%                                # Take the df surveys, then...
  mutate(weight_kg = weight / 1000,        # Create a variable weight variable in kg (instead of grams)
         weight_kg2 = weight_kg * 2) %>%          # and create a variable that contains the square value of the weight variable in kg, then...
  head()                                   # Show me the first 6 rows of what I just did

surveys %>%                                # Take the df surveys, then...
  mutate(weight_kg = weight / 1000,        # Create a variable weight variable in kg (instead of grams)
         weight_kg2 = weight_kg * 2) %>%          # and create a variable that contains the weight variable in kg times two, then...
  print(n=15)                               # Show me the first 15 rows of what I just did
```
      
You can use it to remove NAs in a variable, for example, in `weight`:

```{r, echo = TRUE}
surveys %>%                               # Take the df surveys, then...
  filter(!is.na(weight)) %>%              # Select only the values that are NOT NA, then... 
  mutate(weight_kg = weight / 1000) %>%   # Create a variable weight variable in kg (instead of grams), then...
  head()                                  # Show me the first 6 rows of what I just did
```

**Exercise 5**

Create a new df (called `surveys_hindfoot_half`) from the surveys data that meets the following criteria: 
* Contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. 
* Once you create the hindfoot_half column, be sure that there are no NAs and all values are less than 30.

```{r, echo = TRUE}
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
```
> End of Exercise 5


**Exercise 6**

Load the file `edges_data_final.csv` into an object called `edges` and explore its values.
Make sure `origin`, `dest`, `month`, `origin_type` and `dest_type` are factors.

```{r, echo = TRUE}
edges<-read_csv("https://raw.githubusercontent.com/EKuki/website/master/content/courses/new_r_and_sna/edges_data_final.csv") # This file must be inside your working directory!

edges <- read_csv("https://raw.githubusercontent.com/EKuki/website/master/content/courses/new_r_and_sna/edges_data_final.csv",
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
```

Create a new variable in `edges` called `nb_pigs_abvmean`. This variable should be one (1) if the nb_pigs is above the mean of nb_pigs, and zero (0) otherwise.

> TIP: Check `ifelse()` documentation, once you understand how the `ifelse()` function works - it is very similar to IF function in excel-, use a pipe and mutate. You will insert the `ifelse()` function inside `mutate()`. Store the results in an object called `edges_abvmean`.

```{r, echo = TRUE}
edges_abvmean <- edges %>% 
  mutate(nb_pigs_abvmean = ifelse(nb_pigs > mean(nb_pigs), 1, 0))
edges_abvmean
```

> End of Exercise 6

## **5 - Split-apply-combine**

We will split the data into groups, apply some analysis to each group, and then combine the results. For this, we are going to use `gourp_by()` and `summarise/summarize()`

Let's see an example: Compute the mean weight, by `sex`:

```{r, echo = TRUE}
surveys %>%  
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
  # ?forcats::fct_explicit_na =>  gives missing value an explicit factor level
  surveys %>%  
    group_by(fct_explicit_na(sex)) %>%
    summarize(mean_weight = mean(weight, na.rm = TRUE))
```

Now, compute the mean weight, by `sex` and `species_id`:

```{r, echo = TRUE}
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) # A tibble: 92 x 3
```

>Note: `arrange()` after `group_by()`+`summarise()` needs another argument:

```{r, echo = TRUE}
        surveys %>%
            group_by(sex) %>%
            arrange(weight) %>%  # Not doing as expected! It is mixing Males and Females!
            print(n=20)
        
        surveys %>%
            group_by(sex) %>%
            arrange(weight, .by_group = TRUE) %>%  # Now it does behave! :)
            print(n=20)
```

Let's now remove the NAs of `weight`:

```{r, echo = TRUE}
surveys %>%
  filter(!is.na(weight)) %>% # Remove the NAs of weight at the beginning, so no need to specify na.rm = TRUE when doing the mean
  group_by(sex, species_id) %>% # Note we still have NA in sex
  summarize(mean_weight = mean(weight)) %>% # A tibble: 64 x 3
  print(n=13)
```

To what we have above, add a column indicating the minimum weight for each species for each `sex` and then sort on min_weight putting the heavier species first:

```{r, echo = TRUE}
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
 ```

**Exercise 7**

Using `edges` df, use `group_by()` and `summarize()` to find the mean, min, and max `nb_pigs` for each `origin_type`. Also add the number of observations *(TIP: see ?n)*. Using `edges df`:

```{r, echo = TRUE}
edges  %>% 
  group_by(origin_type) %>% 
  summarize(mean_nbp = mean(nb_pigs),
            min_nbp = min(nb_pigs),
            max_nbp = max(nb_pigs),
            nb_obs = n())
```

> End of  Exercise 7
  
**Exercise 8**

When (month) did the largest transfer of pigs occured?

```{r, echo = TRUE}
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
```

> End of Exercise 8

##  **6 - Count**

`Count` creates frequency tables:

```{r, echo = TRUE}
    # One factor
    surveys %>%
      count(sex)  
  
    surveys %>%
      count(sex, sort = TRUE) # if TRUE, R will sort the output in descending order of n (from higher to lower), ignoring NA
    
    surveys %>%
      count(sex, sort = FALSE) 
  
    # same as:
    surveys %>%
      group_by(sex) %>%
      summarise(count = n())

    # Combine factors
    surveys %>%
      count(sex, species)
```

Now, let's arrange the table above in:
   * an alphabetical order of the levels of the species and
   * in descending order of the count
    
```{r, echo = TRUE}    
    surveys %>%
      count(sex, species) %>%
      arrange(species, desc(n)) 
```

    
**Exercise 9**

Using `edges` df, how many transfers happened on March?

```{r, echo = TRUE}
edges %>% 
  group_by(month) %>% 
  summarise(nb_transfers = n()) # 16 transfers

edges %>% 
  count(month)
```

> End of Exercise 9

**Exercise 10**

Using `edges` df, how many `nb_pigs` were transfered on March?

```{r, echo = TRUE}
edges %>% 
  group_by(month) %>% 
  count(sum(nb_pigs)) # 1479 pigs

edges %>% 
  group_by(month) %>% 
  summarise(n_obs = sum(nb_pigs)) # 1479 pigs
```

> End of Exercise 10

**Exercise 11**

Using `nodes` df, create a frequency table of `premise_type` and `scale`

```{r, echo = TRUE}
nodes %>% 
  count(premise_type, scale)
```  

> End of Exercise 11


## **7 - Spread**

We are going to install a different package so you can load an image in your R Viewer. As usual, I want you to follow these instructions with the power point and yourube videos, but having this image in RStudio may be handy to you.

```{r, echo = TRUE}
#install.packages("magick") # Do this only once! To run this piece of code, remember not to run the `#` sign.
library(magick)
```

And now, load the picture I want you to see:
```{r, echo = TRUE}
spread_pic <- image_read("https://raw.githubusercontent.com/EKuki/website/master/content/courses/new_r_and_sna/spread_pic.png")
print(spread_pic)
```

Let's find the mean weight of each `genus` in each `plot_id` over the entire survey period. Also, filter our observations and variables of interest, and create a new variable for `mean_weight`.

```{r, echo = TRUE}  
  head(surveys)      
  surveys_gw <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id, genus) %>%
  summarize(mean_weight = mean(weight))

head(surveys_gw)
```

It will be more usefull to have a row for each plot and a columnn for each genus, with the `mean_weight` values as cell values...

Using `spread()`, use `genus` as key and populate the cells with the values of `mean_weight`.
>Remember the structure: data %>% spread( key , value ) 

```{r, echo = TRUE}
surveys_spread <- surveys_gw %>% spread(key = genus, value = mean_weight)  # One row for each plot

head(surveys_spread)
str(surveys_spread)
```
 
**Exercise 12**

Spread the `surveys` data frame with `year` as columns, `plot_id` as rows, and the number of genera (plural for `genus`) per `plot_id` as the values. You will need to summarize before reshaping, and use the function `n_distinct()` to get the number of unique genera (genus) within a particular chunk of data. It's a powerful function! See `?n_distinct` for more. Name this new object `surveys_sprd`.

```{r, echo = TRUE}
surveys_sprd <- surveys %>%  
  group_by(plot_id, year) %>% 
  summarise(nb_genera = n_distinct(genus)) %>% 
  spread (key = year, value= nb_genera) 

head(surveys_sprd)
```

> End of Exercise 12


## **8 - Gather**

Get the picture:
```{r, echo = TRUE}
gather_pic <- image_read("https://raw.githubusercontent.com/EKuki/website/master/content/courses/new_r_and_sna/gather_pic.png")
print(gather_pic)
```

Create a key called `genus` and a value (new column) called `mean_weight` and use all columns except `plot_id`.

>Remember the structure: data %>% gather( key , value , var-to-be-removed) 

```{r, echo = TRUE}
surveys_gather <- surveys_spread %>% gather(key = genus, value = mean_weight, -plot_id)

head(surveys_gather)
str(surveys_gather)

# using the : operator:
surveys_spread %>%
  gather(key = genus, value = mean_weight, Baiomys:Spermophilus) %>%
  head()
```

**Exercise 13**

Take `surveys_sprd` and `gather()` it, so that each row is a unique `plot_id` by `year` combination.

```{r, echo = TRUE}
surveys_sprd %>% gather(key = year, value=nb_genera, -plot_id)
```

> End of Exercise 13





## **NAs and dplyr**

Keep only those complete cases (no NAs):

```{r, echo = TRUE}
surveys # A tibble: 34,786 x 13
summary(is.na(surveys))

surveys %>% na.omit # A tibble: 30,676 x 13
surveys %>% filter(complete.cases(.)) # A tibble: 30,676 x 13
library(tidyr)
surveys %>% drop_na # A tibble: 30,676 x 13
surveys %>% filter(!is.na(sex)) # If you want to filter based on one variable's missingness
                                # A tibble: 33,038 x 13
```

## **Export your df into a csv**

```{r, echo = TRUE}
write_csv(edges_abvmean, path = "new_edges_abvmean.csv")
```

## **Quitting R**

* Save your script (although you should really be doing it constantly while coding).
* When quitting R and saving workspace image - if desired! => Saved as `.RData` file.
* I only do it if I have been running heavy models that took hours to run.


## **SUMMARY of this workshop**

* Choose column: `select()`
* Choose row: `filter()`
* Link the output of one dplyr function to the input of another function with the 'pipe' operator `%>%`
* Add columns: `mutate()` 
* `group_by()` takes as arguments the column names that contain the categorical variables for which you want to calculate the summary statistic
* `summarize()` collapses each group into a single-row summary of that group
* Print specific number of rows: use the `print()` function at the end of your chain with the argument `n`= specifying the number of rows to display
* `count()`: Number of observations found for each factor or combination of factors
* `spread()` makes wide data (from long). Takes three principal arguments:
      1. the data
      2. the key column variable whose values will become new column names.
      3. the value column variable whose values will fill the new column variables.

* `gather()` makes long format (form wide). Takes four principal arguments
      1. the data
      2. the key column variable we wish to create from column names.
      3. the value column variable we wish to create and fill with values associated with the key.
      4. the names of the columns we use to fill the key variable (or to drop).