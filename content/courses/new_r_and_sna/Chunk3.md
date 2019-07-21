---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: Chunk 3
#linktitle: "Chunk3"
summary:
date: 2019-07-21T13:05:20-04:00
lastmod: 2019-07-21T13:05:20-04:00
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
    name: Chunk 3
    parent: 1. Basics 
    # parent: YourParentID
    weight: 5
---


In [this video](https://youtu.be/bxCB1xXBYcA) I go along this `Chunck 3` of `1. Basics`.
Remember to follow with the power point corresponding to this `1. Basics` section!

## **d. Lists**
This is an example of a list with 4 components: a string, a numeric vector, a matrix, and a scalar :
```{r, echo = TRUE}
mylist <- list(name=c("Fred", "Lola"), mynumbers=a, mymatrix=nb_matrix, age=6.8)
mylist
```

### Indexing a list
```{r, echo = TRUE}
mylist[[2]] # 2nd component of the list
mylist[[2]][3] # Extract the third element of the 2nd component of the list
```

Other ways to identify observations in a list
```{r, echo = TRUE}
mylist[["mynumbers"]] # component named mynumbers in mylist
mylist[["mynumbers"]][3]
```

## **e. Factors**:
R treats factors as INTEGER vectors, where each integer corresponds to a category, or a level.
As an example, let's create the variable gender with 20 "male" entries and 30 "female" entries:
```{r, echo = TRUE}
gender <- c(rep("male",20), rep("female", 30)) 
gender
class(gender) # `class()` is a function. It tells us what type of data we are dealing with
class(mylist)
```

```{r, echo = TRUE}
gender <- factor(gender) 
gender
class(gender)
levels(gender) # R sorts levels alphabetically
```

We can change the order of the levels of a factor by:
```{r, echo = TRUE}
gender2 <- factor(gender, levels = c("male", "female"))
levels(gender2)
```
 
We can also change the levels names by renaming the factor labels:
```{r, echo = TRUE}
gender3 <-factor(gender, labels = c("red", "yellow"))
levels(gender3)
```

>Note that it is very important to maintain the same order as the order of the factor levels! To avoid confusion, you can change the order of the levels AND the names of the labels at the same time:

```{r, echo = TRUE}
gender4 <- factor(gender,
                  levels = c("male", "female"), # make male the first level
                  labels = c("hombre", "mujer")) # change label male by label hombre

str(gender) # STRUCTURE. original
str(gender2) # we changed the order of the levels
str(gender3) # we changed the label of the levels
str(gender4) # we changed both the order and the labels of the levels
# R now treats gender as a nominal variable 
summary(gender)
```

If we want an ordinal variable, we need to add the argument `ordered = TRUE`:
```{r, echo = TRUE}
quality_product <- c("G", "B", "Avg", "Avg", "Avg", "G", "B", "G", "G", "G") # G = good, Avg = average, B = bad
quality_product_f <- factor(quality_product, ordered = TRUE,
                            levels = c("B", "Avg", "G")) # Tell R that this is an ordered vector
quality_product_f # Note that B < Avg < G
str(quality_product_f)
```

## **f. Functions**

```{r, echo = TRUE}
family_df
str(family_df) # structure
      # Wait a second... Why is family a Factor?!
      # ?data.frame
```

Now, run and think a bit about these lines of code:
```{r, echo = TRUE}
head(family_df, 2) # First 2 rows, all columns
head(family_df) # By default, head() gives you the first 6 rows, all columns. Our dataset only has 4 rows!
summary(family_df)
dim(family_df) # dimensions. Rows and columns
```

Try running `mean(family_df)`. It doesn't work! I need to specify a column to display!
```{r, echo = TRUE}
mean(family_df$age)
sum(family_df$age)
```

Why _does_ this one work?
```{r, echo = TRUE}
mean(age)
```

Some more functions:
```{r, echo = TRUE}
heights <- c(2, 4, 4, NA, 6)
str(heights)
summary(heights)
```

```{r, echo = TRUE}
mean(heights) # ??
max(heights) # ??
mean(heights, na.rm = TRUE) # Remove NA for this arithmetic operation
max(heights, na.rm = TRUE)
```

### Do we have missing values?
```{r, echo = TRUE}
is.na(heights)
summary(is.na(heights))
```

Identify location of NAs in vector
```{r, echo = TRUE}
which(is.na(heights)) # Index, or location, 4 has an NA
```

Identify count of NAs in data frame
```{r, echo = TRUE}
sum(is.na(heights)) # We only have one NA
```

Extract those elements which are not missing values.
```{r, echo = TRUE}
!is.na(heights)  # The operator `!` in R means NO. Thus, !is.na = those that are NOT missing values. Returns logical vector
heights[!is.na(heights)] # Extract all values from heights that are not missing values
heights[c(1,2,3,5)]
```

Extract those elements which are complete cases (case=row). 
```{r, echo = TRUE}
complete.cases(heights) # returns a logical vector indicating which cases are complete. 
heights[complete.cases(heights)]

!complete.cases(heights) # You can also subset with the `!` operator to get incomplete cases.
heights[!complete.cases(heights)]
```

**Exercise 6**: 

Create another column for family_df called profession where you give a profession to each family member, except to the dog. 

> Tip: *assign* a new *column*

```{r, echo = TRUE}
family_df$profession <- c("researcher", "IT", "student", NA)
```

Retrieve all cases in family_df that don't have NAs.
```{r, echo = TRUE}
family_df[complete.cases(family_df), ]
```
> End of Exercise 6

Now, run and think a bit about these lines of code:
```{r, echo = TRUE}
is.na(family_df)
is.na(family_df$name)
is.na(family_df$profession)
colSums(is.na(family_df)) # Compute the total missing values in each colum
```

Another example. Recode missing values with the mean:
```{r, echo = TRUE}
        x <- c(1:4, NA, 6:7, NA) # vector with missing data
        x
        is.na(x) # Does x have NAs? Yes
        which(is.na(x)) # NAs are in positions 5 and 8
        mean(x) # It doesn't work, why?
        mean(x, na.rm = TRUE) # Mean of x, without the NAs
        x[is.na(x)] # Extract positions 5 and 8 (the TRUE ones) of x
        x[is.na(x)] <- mean(x, na.rm = TRUE) # *assign* `<-` the mean of x to the cells where we have NA values in x
        round(x, 1) # Round the values of x and give me only 1 decimal point
        x # x still has a lot of decimal points. Why?
```
> Note that some people code NA as 99. If you feed these type of data to R, R won't know those are NAs.

Example of a data frame that codes missing values as 99
```{r, echo = TRUE}
df <- data.frame(col1 = c(1:3, 99), col2 = c(2.5, 4.2, 99, 3.2))
df
```

Change 99s to NAs
```{r, echo = TRUE}
df[df == 99] <- NA # in the locations that df== 99, insert an NA
df
```

**Exercise 7**: 

Create another column for family_df called salary where you give a salary to each family member, except to the dog.
```{r, echo = TRUE}
family_df$salary <- c(1500, 1350, 23, NA)
```

This family loves their dog and they dedicate 1% of their overall mean salary to him. Recode the salary missing value of the dog with 0.01 of the mean of the family's salary.
```{r, echo = TRUE}
family_df$salary[is.na(family_df$salary)] <- mean(family_df$salary, na.rm = TRUE) * 0.01
family_df
```

Get incomplete cases with the `!` operator
```{r, echo = TRUE}
family_df[!complete.cases(family_df),]
```
> End of Exercise 7

There are some other ocasions when R will return NA (or error, or warning):
Run these and see what happens
`var (8)`                                 # Variance of one number
`as.numeric (c("1", "2", "three", "4"))`   # Illegal conversion
`c(1, 2, 3)[4]`                           # Vector subscript out of range                   
`NA - 1`                                   # Most operations on NAs produce NAs
`a <- data.frame (a = 1:3, b = 2:4)`
`a[4,]`                                    # Data frame row subscript out of range. # The first NA in the output is the row number
`a[,4]`                                    # Specifying a non-existent column just produces an error

