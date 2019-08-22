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

**1 - Selecting columns and filtering rows**

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
      