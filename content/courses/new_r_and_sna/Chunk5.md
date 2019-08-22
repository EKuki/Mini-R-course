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

## Packages and Libraries

A **package** is a compilation of functions, data and documentation. They only need to be installed *once* (although you will have to reinstall everytime you update R/RStudio). You will need to have internet connection to download packages, as R downloads its packages from the web.

R comes with a standard set of packages which libraries don’t need to be called (base R).

A **library** is a directory where packages are stored. Libraries need to be "called" (typed in the script or console) at each R session (before using the functions it contains).

I see packages as toolboxes. You buy it in the store (you download it (for free!) from the web), and then you keep it on a self at home. When you want to use its tools (funtions), you need to grab that toolbox and open it (aka, you need to "call"" the library).

In summary, first time you want to use a package, you'll need to install it, and then call the library. Next time you open Rstudio, you will only need to call the library, as you already installed the package (you won't need to download it again).


## **Tydiverse**

We are going to be working a lot with **tydiverse**. Tydiverse is a group of packages, of which we will be mainly using **dplyr** and **ggplot2** (although there are many more!).

Tydiverse uses what we call *tidy data*, where:

* Each column is a variable
* Each row is an observation
* Each cell is a value

Tydiverse takes *one step at a time* and connects simple steps through pipes (faster to write and to read). The language used by tydiverse to refer to data frames is *tibble* (but in essence, they are the same).

Let's practice a bit

## **Install a package**

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









