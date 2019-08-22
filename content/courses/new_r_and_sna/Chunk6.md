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

With `dplyr`, the first argument you will use is the data you want to work with (in our case, `surveys`):

## **1 - Selecting columns and filtering rows**

```{r, echo = TRUE}
select(surveys, plot_id, species_id, weight)
select(surveys, -record_id, -species_id)# remove columns
select(surveys, plot_id,-record_id)
filter(surveys, year == 1995) # same as old (base-R): surveys[which(surveys$year == 1995),]
```

**Exercise 1**: 

Read the `nodes_data_final.csv` file using the tidiverse function `read_csv()` from the `readr` package

```{r, echo = TRUE}
nodes<-read_csv("nodes_data_final.csv") # This file must be inside your working directory!
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
