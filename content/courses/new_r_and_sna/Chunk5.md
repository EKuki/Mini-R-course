---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Chunk 5"
summary:
date: 2019-08-20T16:53:01-04:00
lastmod: 2019-08-20T16:53:01-04:00
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
    name: Chunk 5
    parent: 2. dplyr
    weight: 9
---

## **Packages and Libraries**

A **package** is a compilation of functions, data and documentation. They only need to be installed *once* (although you will have to reinstall everytime you update R/RStudio). You will need to have internet connection to download packages, as R downloads its packages from the web.

A **library** is a directory where packages are stored. Libraries need to be "called" (typed in the script or console) at each R session (before using the functions it contains).

R comes with a standard set of packages which libraries don’t need to be called (base R).

I see packages as toolboxes. You buy the toolbox in the store (you download it (for free!) from the web), and then you keep it on a self at home. When you want to use its tools (funtions), you need to grab that toolbox and open it (aka, you need to "call"" the library).

In summary, first time you want to use a package, you'll need to install it, and then call the library. Next time you open Rstudio, you will only need to call the library, as you already installed the package (you won't need to download it again).


## **Tydiverse**

We are going to be working a lot with **tydiverse**. Tydiverse is a group of packages, of which we will be mainly using **dplyr** and **ggplot2** (although there are many more!).

Tydiverse uses what we call *tidy data*, where:

* Each column is a variable
* Each row is an observation
* Each cell is a value

Tydiverse takes *one step at a time* and connects simple steps through pipes (faster to write and to read). The language used by tydiverse to refer to data frames is *tibble* (but in essence, they are very similar. More about this below).

Let's practice a bit.

## **Install a package**

Remember that you only need to install a package ONCE in all your R/Rstudio life (unless you update).

```{r, echo = TRUE}
install.packages("tidyverse") # Use only once. This will take a while. tydiverse is huge!
library(tidyverse) # I usually put all the libraries I am goin got use during my R session at the beginning of the R script
```

If you run the lines above, you will realise that `dplyr` (a package within tydiverse) overwrites (*masks*) some functions of base R. If you want to use the base version of these functions after loading dplyr, you'll need to use their full names: `stats::filter()` and `stats::lag()`.

```{r, echo = TRUE}
tidyverse_conflicts() # lists all the conflicts between packages in the tidyverse and other packages that you have loaded.
```

If you want to get extra info about the package you can do:
```{r, echo = TRUE}
packageDescription("tidyverse")
help(package = "tidyverse")
```

Tidyverse has a different way of reading files. Earlier, we read our data using `read.csv()`;  tidyverse - specifically the package `readr` - uses a similar but different function: `read_csv()`. For example:

```{r, echo = TRUE}
surveys <- read_csv("combined.csv")
surveys
```

> Note that `readr` automatically guesses the class/type of each column, but it does not automatically convert strings to factors (as `read.csv()` does!). You can override the default guess through the `read_csv()` argument `col_types`: Copy-paste the parsed code, and then tweak it to fix the parsing problems as shown below:

```{r, echo = TRUE}
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
```      

Now, I want you to compare the differences between the two survey files (base-R and tidyverse):
```{r, echo = TRUE}
head(surveys_base) # base-R, read as read.csv()
head(surveys) # tidyverse,  read as read_csv()
```

Tibbles are similar to data frames, but are slightly tweaked to work better in the tidyverse. Check this out: https://www.tidyverse.org/articles/2018/12/readr-1-3-1/

```{r, echo = TRUE}
str(surveys_base)
str(surveys)

class(surveys_base)
class(surveys)
```
## **Data frames and tibbles** - *optional*

There are two main differences between data.frames and tibbles:

**1 - PRINTING**
```{r, echo = TRUE}
surveys_base # automatically prints it all (or the maximum specified in your Rstudio. See getOption("max.print") )
surveys # only prints the first 10 rows
View(surveys) # If you want to see it all
print(surveys, n = 15) # if you want to print 15 rows of a tibble
print(surveys, n = 15, width = Inf) # width = Inf indicates that we want all columns 
                                          # => Important if width of source is small!
      print(surveys, n = 15) # run this line with a narrow Console window to see what happens!
      head(surveys, 15) # same as head(surveys, n = 15)
```   
**2 - INDEXING (or Subsetting)**
Single-square brackets `[` and `$` are not much used to subset, instead, use `filter()` or `select()`, althogh you can still use:

```{r, echo = TRUE}
surveys %>% .$month # where %>% is a "pipe". It reads as "then...". More about this, below.
surveys %>% .[["month"]]
surveys$month 
```
Some older functions don't work with tibbles. The main reason for some functions not to run properly is the `[` function. We don't use `[` much in tidyverse because `dplyr::filter()` and `dplyr::select()` can do the same thing with clearer code.
      
With base-R data frames, `[` sometimes returns a data frame, and sometimes it returns a vector. This is not consistent!
With tibbles, `[` always returns another tibble.

> Example for two dimensional single-square brackets subsetting
         
```{r, echo = TRUE}
class(surveys[,"month"]) # returns a tibble
class(surveys[,c("month", "day")]) # returns a tibble

class(surveys_base[,"month"]) # returns a vector (integer vector)
class(surveys_base[,c("month", "day")]) # returns a data.frame
```
              
`$` always returns a vector (you may see that some people use `[[` as `$` (`$` is a shortcut for `[[` )).

```{r, echo = TRUE}
class(surveys$month) # returns a vector (numeric vector)
class(surveys_base$month) # returns a vector (integer vector)
```

If you encounter one of those functions that don't work with tibbles, use `as.data.frame()` to turn a tibble back to a data.frame.

```{r, echo = TRUE}
as.data.frame(surveys)        
```

If you want to transfrom a data frame to a tibble, use as_tibble()
```{r, echo = TRUE}
as_tibble(surveys_base)
```








