---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: Chunk 2
# linktitle: 
summary:
date: 2019-07-14T18:28:21-04:00
lastmod: 2019-07-14T18:28:21-04:00
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
    name: Chunk 2
    parent: 1. Basics 
    # parent: YourParentID
    weight: 4
---


In [this video](https://youtu.be/l7jsiDXV4yI) I go along this `1.2` subsection of `1. Basic`.
Remember to follow with the power point corresponding to this `1. Basic` section!

To "concatenate" two vectors (aka, to put them together) we use `c()`:
```{r, echo = TRUE}
both_weights<-c(weight_kg, half_weight_kg)
both_weights
```

Another example:
```{r, echo = TRUE}
mum <- "Claire"
dad<- "Pablo"
parents <- c(mum, dad)
```

**Exercise 2**: Create a vector called "daughter" with a female's name and another one called "dog" with a dog's name.

```{r, echo = TRUE}
daughter <- "Anita"
dog <- "Poppy"
```

Create a new vector called "family" with the names of all family members (use this order mum, dad, daugther, dog). 
> With R, we usually can get to the same outcome coding in different ways. My solution is usually one of many.

```{r, echo = TRUE}
family <- c(parents, daughter, dog)
family
class(family)
c(mum, dad, daughter, dog)

family_char <- c("Claire", "Pablo" , "Anita",  "Poppy")
class(family_char)
```
> End Exercise 2

## a.Vectors
```{r, echo = TRUE}
a <- c(1,2,5.3,6,-2,4) # numeric vector
b <- c("one","two","three") # character vector
ce <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector
```

### Indexing a `vector`
```{r, echo = TRUE}
ce[2] # Extract second element of `ce`
a[3] # Extract third element of a
a[1:3] # Extrat all elements between the first and the third elements, of `a`
b[c(1,3)] # Extract first and third element of `b`
```

> Note that I did not use the letter `c` to name my vector: I used `ce` instead. The choice of c as the name of a vector is a pretty bad one, as there is a command/function called `c()`! See `?c` or `help(c)`

**Exercise 3**: Extract the first element of the vector family: the `mum`.
```{r, echo = TRUE}
family[1]
```

Extract the forth element of the vector family: the `dog`.
```{r, echo = TRUE}
family[4]
```

Extract both the name of the `dad` and the `daughter` (do it at the same time -using only one command-, if possible).
```{r, echo = TRUE}
family[c(2,3)]
```
> End of Exercise 3


## b.Data frames
```{r, echo = TRUE}
Identification <- c(1,2,3,4)
Colors <- c("red", "white", "red", NA) # Note NA
Succeeded <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(Identification, Colors, Succeeded) # Join those vectors together to create a `data.frame`
mydata
names(mydata) <- c("ID","Color","Passed") # Change the variable/column names
```

### Indexing a `data.frame`
```{r, echo = TRUE}
mydata[ ,c(1:2)] # columns 1 and 2 of `mydata` data frame. All rows
```

Other ways to identify observations in a `data.frame`.
```{r, echo = TRUE}
mydata[,c("ID","Color")] # columns ID and Color from `mydata`
mydata$Passed # variable ID in the data frame
```
> The $ operator is used constantly. It retrieves/extracts a variable in a dataset.

**Exercise 4**: Create a data frame called `family_df` with two columns: `name` and `age`. For column `name`, use the previous `family` vector. For column `age`, make up ages for our family
```{r, echo = TRUE}
family
age <- c(45, 48, 10, 7)
family_df <- data.frame(family, age)
family_df
names(family_df) <- c("name","age") # variable names 
family_df
```
> End of Exercise 4

## c.Matrices
```{r, echo = TRUE}
nb_matrix<-matrix(data = 1:20, nrow=5,ncol=4) # The function `matrix()` generates 5 x 4 numeric matrix called `nb_matrix`
nb_matrix

help(matrix) # look for help of the function `matrix()`
?matrix
??matrix
?graph_from_data_frame
??graph_from_data_frame
```

Another example
```{r, echo = TRUE}
cells <- c(1,26,24,68)
mymatrix <- matrix(data = cells, nrow=2, ncol=2, byrow=TRUE)
mymatrix
```

### Indexing a `matrix` (as we did with `data.frames`)
```{r, echo = TRUE}
nb_matrix[,4] # 4th column of nb_matrix
```

**Exercise 5**: Extract the 3rd row of `nb_matrix` 
```{r, echo = TRUE}
nb_matrix[3,]
```

Extract rows 2,3,4 of columns 1,2,3 of `nb_matrix` 
```{r, echo = TRUE}
nb_matrix[2:4,1:3]
nb_matrix[c(2,3,4), c(1,2,3)]
```
> End of Exercise 5
