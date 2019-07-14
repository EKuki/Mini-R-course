---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: Chunk 1
linktitle: 
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
    name: Chunk 1
    parent: 1. Basics 
    # parent: YourParentID
    weight: 3
---


[This video](https://youtu.be/b7R8Q04jdrU) provides an intro to R and RStudio that that I am skiping here, so if you are really new to R/RStudio, I would recommend you to watch it. In it, I go along this `1.1` subsection of `1. Basic`.

## How to comment and run code

To write a comment, type `#` before the sentence you want to write.
Anything to the right of a `#` in a script will be ignored by R.

> To comment on a whole paragraph, select the lines you want to comment and press at the same time on your keyboard `Ctrl` + `Shift` + `c`.

> To run: Click anywhere on the line you want to run and either 1) Click `Ctr` + `Enter` or 2) Click on `run` bottom (up right corner of Source/Script)

> If you want to run several lines, highlight them all and do as explained above.

You can get output in the Console simply by typing math in the script and running it:
```{r, echo = TRUE}
3 + 5 # Result is 8
12/2 # Result is 6 
```

##  Assign values to objects
`<-` assigns values on the right to objects on the left.
> PC: Type `Alt` and `-` at the same time. 
> Mac: `Option` and `-`

```{r, echo = TRUE}
weight_kg <- 55    # doesn't print anything, but it has created an object. You can see it in the Environment window, in RStudio.
(weight_kg <- 55)  # Putting parenthesis around the call prints the value of `weight_kg`
weight_kg          # and so does typing (or "calling") the name of the object
```

> Note that R iS cAsE SeNsItIvE!! Try typing `weight_KG`. You will see an error like this one `Error: object 'weight_KG' not found`. Note the capitalizatio of `_KG`.

You can override an object. Be careful!
```{r, echo = TRUE}
weight_kg <- 60 
weight_kg # If you call wight_kg you see that its value is now 60. You can also see this change in the Environment window.
```

**Exercise 1**: Create an object (a vector) that is half the value of weight_kg (use weight_kg <- 60) called "half_weight_kg"

```{r, echo = TRUE}
half_weight_kg <- weight_kg / 2
half_weight_kg
```

You can give whichever name you want to an object, but it is a good idea to choose something that makes sense. For example:

```{r, echo = TRUE}
beautiful_day <- weight_kg / 2
beautiful_day # A bit nonesense...
half_weight_kg
```
> End of Exercise 1
