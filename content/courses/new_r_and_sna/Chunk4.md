---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: Chunk 4
summary:
date: 2019-08-20T15:04:05-04:00
lastmod: 2019-08-20T15:04:05-04:00
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
    name: Chunk 4
    parent: 2. dplyr
    weight: 7
---


## **General R**
* Object names must start with a letter, and can only contain letters, numbers, underscore `_` and dots `.`.
* If you get `+` in the console, after running some code, R is telling you that it's waiting for more input; it doesn't think you're done yet. To get rid of that `+` sign, finish your line of code, or press `Esc`.
* Consider that `numeric`, `integer` and `double` are the same


## **Working directory**

The working directory (wd) is the place where the file(s) you want to call into R live (kind of like the folder where you have your csv). It must be set up in every R session (whenever you want to use data that is somewhere in your computer), so R knows where to look in your computer to find your files.

You could set it up in several ways. The way I do it (in a PC) is:

  1. Open `My documents` and navigate where your files are.
  2. Copy the path (see [power point](https://github.com/EKuki/website/blob/master/content/courses/new_r_and_sna/2.Dplyr_SNA%20using%20R_25March19.pptx) for visual help).
  3. Paste that path in your script and change every back slash `\` to normal slash `/`.
  4. Insert that path into: `setwd(" *insert_path_here* ")`. For example, if your path is `H:/R training/R and SNA Training CDPH/2.dplyr`, you would do: 

```{r, echo = TRUE}
setwd("H:/R training/R and SNA Training CDPH/2.dplyr")
```

There are a couple of other ways to set up your wd:

  a) Use RStudio's `Files` pane to navigate to a directory and then set it as working directory from the menu: `Session` -> `Set Working Directory` -> `To Files Pane Location` (You'll see even more options there)
  
  b)Within the `Files` pane, choose `More` and `Set As Working Directory`.


If you don't remember where you set up your wd (aka, where R is looking for your files in your computer), try this line of code to get the wd:
```{r, echo = TRUE}
getwd()
```

To list files contained in your wd:
```{r, echo = TRUE}
list.files()
```
To only list those files that end with the word "csv"
```{r, echo = TRUE}
list.files (pattern = "csv$")
```
If you want to move one folder up in your wd:
```{r, echo = TRUE}
setwd('..')
```
Don't forget to check if it worked out well:
```{r, echo = TRUE}
getwd() # check where you are now
```

## **Read a csv file**\

Start by downloading combined data from [here](https://figshare.com/articles/Portal_Project_Teaching_Database/1314459) or [here](https://github.com/EKuki/website/blob/master/content/courses/new_r_and_sna/combined.csv)

Set your wd. Mine is this one. Yours will be different: 
```{r, echo = TRUE}
setwd("H:/R training/R and SNA Training CDPH/2.dplyr")
```

Use the `read.csv()` function to read a csv:
```{r, echo = TRUE}
surveys_base <- read.csv("combined.csv") # The file you want to read must be inside your working directory! For example, combined.csv is inside my wd.
```
> Did it work? Check the environment

## Explore your dataset
Check its size:
```{r, echo = TRUE}
dim(surveys_base) # returns a vector with the number of rows in the first element, and the number of columns as the second element (the dimensions of the object)
nrow(surveys_base) # returns the number of rows
ncol(surveys_base) # returns the number of columns
```
Its content:
```{r, echo = TRUE}
head(surveys_base) # shows the first 6 rows 
tail(surveys_base) # shows the last 6 rows
```

Its names:
```{r, echo = TRUE}
names(surveys_base) # returns the column names (synonym of colnames() for data.frame objects)
rownames(surveys_base) # returns the row names
```

Do a summary:
```{r, echo = TRUE}
str(surveys_base) # structure of the object and information about the class, length and content of each column
summary(surveys_base) # summary statistics for each column
```
View entire df:
```{r, echo = TRUE}
View(surveys_base) # a new tab will open
```


**Exercise 1**: 

Based on the output of `str(surveys)`, can you answer the following questions?

What is the class of the object surveys? 

> 'data.frame'

How many rows and how many columns are in this object? 

> 34786 rows and 13 columns

How many species have been recorded during these surveys? 

> 40

Note the empty values in variable sex. Why may this be happening? 

> TIP: Exploring the output of `str()` should make you think on using `levels()`

```{r, echo = TRUE}
str(surveys_base)
levels(surveys_base$sex) # R doesn't read the "empty" values in sex as NA. R thinks there is a level that is ""
```

> End of Exercise 1 

**Exercise 2**:

Create a data.frame (df) called `surveys_200` containing only the data in row 200 of the surveys df.
```{r, echo = TRUE}
surveys_200 <- surveys_base[200,]
surveys_200
surveys_base[200,]
```

Create a df called `surveys_last` containing only the data in the last row of the surveys df using two different commands. 

>TIP: You can use nrow() and tail().

```{r, echo = TRUE}
# Option one
nrow(surveys_base)
surveys_base[34786,] # using the row number
surveys_base[nrow(surveys_base),] # using indexing of a df combined with nrow(). This is better! Only one line of code :)

#Option two:
tail(surveys_base,1) # Starting from the bottom tail (from the end of the df), extract the first element of surveys df
tail(surveys_base,1) == surveys_base[nrow(surveys_base),] # Are my results equivalent? 
```

Choose any of those methods to create surveys_last:
```{r, echo = TRUE}
surveys_last <- tail(surveys_base,1)
```

> End of Exercise 2



**Exercise 3**:

Download the file [nodes_data_final.csv](https://github.com/EKuki/website/blob/master/content/courses/new_r_and_sna/nodes_data_final.csv). 
Load `nodes_data_final.csv` into R by creating an object called `nodes_base` and explore its values

```{r, echo = TRUE}
nodes_base<-read.csv("nodes_data_final.csv") # This file must be inside your working directory!
str(nodes_base)
head(nodes_base)
summary(nodes_base)
```
What type of premises do we have?
```{r, echo = TRUE}
summary(nodes_base)
summary(nodes_base$premise_type)
levels(nodes_base$premise_type)
```

> End of Exercise 

