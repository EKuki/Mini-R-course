---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Chunk 7"
summary:
date: 2019-08-26T14:08:00-04:00
lastmod: 2019-08-26T14:08:00-04:00
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
    name: Chunk 7
    parent: 3. ggplot2
    weight: 12
---

## **Install packages and call libraries**

We are going to be working with new packages and new libraries.
You will need to install the corresponding packages in Rstudio before calling their libraries (step not shown here, but you have done this before with a different package (`tydiverse`), so I trust you can do it!). Once you have those packages installed, call the libraries:

* `library(tidyverse)`
* `library(raster)` # we will use the function `pointDistance()`
* `library(igraph)`
* `library(rgdal)` # we will use the function `getData()` - This package provides bindings to the Geospatial Data Abstraction Library (GDAL) used for reading, writing and converting between spatial formats.
* `library(graphics)` # we will use the function `text()`
* `library(maps)` # we will use the function `map.scale()`

## **Loading data**

You have done this before, so I'll jump directly to an exercise.

**Exercise 1**

Set your *working directory* and  load the file `nodes_data_final.csv` into an object called `nodes_base` and explore its values. Use `read_csv()`. Make sure `premise_type`, `scale`, and `area` are factors.

```{r, echo = TRUE}
nodes<-read_csv("nodes_data_final.csv", col_types = cols(
                  premise_type = col_factor(),
                  scale = col_factor(),  
                  area = col_factor())
                )# This file must be inside your working directory!
str(nodes)
head(nodes)
summary(nodes)
dim(nodes) # 40 7
summary(is.na(nodes))
```

> End of Exercise 1

**Exercise 2**

Load the file `edges_data_final.csv` into an object called `edges` and explore its values. Use `read_csv()`. Make sure `origin`, `dest`, `month`, `origin_type` and `dest_type` are factors.

```{r, echo = TRUE}
edges<-read_csv("edges_data_final.csv", col_types = cols(
                    origin = col_factor(),
                    dest = col_factor(),
                    month = col_factor(),
                    origin_type = col_factor(),
                    dest_type = col_factor())
                )# This file must be inside your working directory!

str(edges)
head(edges)
summary(edges)
dim(edges) # 295 10
summary(is.na(edges))
```
> End of Exercise 2

To be able to work with distances in our future steps, we are going to add a vector of distance (in m and km) between origin and destination farms, in the `edges` object:

```{r, echo = TRUE}
dist<-pointDistance(cbind(edges$longitude_orig, edges$latitude_orig), cbind(edges$longitude_dest, edges$latitude_dest), lonlat=TRUE)
distkm<-dist/1000
edges$distkm<-distkm
head(edges)
```

## **Principal components of every plot**

You can find some more info [here](http://www.sthda.com/english/wiki/ggplot2-essentials).

* Data (**data**) is a data frame. 
* Aesthetics (**aes**) is used to indicate `x` and `y` variables, as well as to control the color, the size or the shape of points, the height of bars, etc.
* Geometry (**geom_**) defines the type of graphics (histogram, box plot, line plot, density plot, dot plot, …). Visual marks that represent data points.
* Coordinates (**coord_**) determines how the `x` and `y` aesthetics combine to position elements in the plot.

The way you will code this will usually look something like this: 

plot <- ggplot (`data` , `aes()`) + `geom_xxx()` + `coord_xxx()`

There are two major functions in `ggplot2` package: `qplot()` and `ggplot()` functions:

* `qplot()` stands for quick plot, which can be used to produce easily simple plots.
* `ggplot()` function is more flexible than qplot for building a plot piece by piece. This is the one I usually use.

## **Explore transactions with ggplot2**

Let's start working with it. Simply plot the layout of our plot: *plot = `data` + `aes()`*:

```{r, echo = TRUE}
ggplot(data= edges, aes(x=month, y=nb_pigs))
```

Now, add data as points:  *plot = `data` + `aes()` + `geom_()`*

```{r, echo = TRUE}
ggplot(data= edges, aes(x=month, y=nb_pigs)) + 
   geom_point() 
# same as:
edges %>% 
     ggplot(aes(x=month, y=nb_pigs)) + # add data as points
     geom_point() 
```

Add colour:

```{r, echo = TRUE}
ggplot(data= edges, aes(x=month, y=nb_pigs, color = origin_type)) + # Note: the aes() that we apply in this first row are going to be applied in the subsequent rows of code 
   geom_point() 
```

Jitter those points, so we can see what's happening better:

```{r, echo = TRUE}
ggplot(data=edges, aes(x=month, y=nb_pigs, color = origin_type)) + 
   geom_jitter(width = 0.2)
```
Do a boxplot instead:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs, color = origin_type)) +
   geom_boxplot()
```
**Exercise 3**

Create a boxplot of `nb_pigs` per month, without stratifying by `origin_type`.

> TIP: do not specify color

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot()
```

> End of Exercise 3

**Exercise 4**

Use that new boxplot you created and superpose the data as points.

> TIP: follow the tidy logic: plot the boxplot first, and then plot the points

> EXTRA: what happens if you create the points first and then you create the boxplots?

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot()+
   geom_point()
# Same as above:
init_boxp <- ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot()
init_boxp +
  geom_point()

ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_point()+
   geom_boxplot()  # Note how the boxplots are above the points. This is not what we wanted.
```

> End of Exercise 4

Color per `month` (use fill= within the `aes()` argument):

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot(fill = month)+
   geom_point() # does not work!

ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot(aes(x=month, y=nb_pigs, fill = month))+
   geom_point()
```

Why is that code above the same as this?:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs, fill = month)) +
   geom_boxplot()+
   geom_point()
```

Do a barchart instead:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") # geom_bar() => count the nb of pigs per month 

# order those month levels!
levels(edges$month)
edges$month <- factor(edges$month, levels=c("January","February","March","April", "May","June", "July","August", "September","October","November","December"))
levels(edges$month)

# try again
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity")
```

Flip the coordinates (make the bar horizontal):

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity")+
   coord_flip() 
```

Try a different `coord_()` function:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
  geom_bar(stat="identity")+
  coord_polar(theta="x")
 
# Add some color
ggplot(edges, aes(x=month, y=nb_pigs, fill = month)) +
  geom_bar(stat="identity")+
  coord_polar(theta="x")
```

Add tittle:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments") # Nb of shipments\n: \n acts as "enter"

ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments\nper month")
```

Remove redundant axis lables:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments") +
   labs(x=NULL, y= NULL)
```

Remove background color:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments") +
   labs(x=NULL, y= NULL) +
   theme(
   panel.background = element_blank())
```

Do a bunch of other stuff:

```{r, echo = TRUE}
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments\n") +
   labs(x=NULL, y= NULL) +
   theme(
   panel.background = element_blank(),
     axis.text.y = element_text(size=12, colour="gray33"),
     axis.text.x = element_text(size=12, angle = 45, vjust=0.6),
     axis.ticks.length = unit(.2, "cm"),
     axis.ticks.y = element_blank(),
     plot.title = element_text(hjust = 0.5, vjust= -2, size = 18,colour="gray33"))
```

Create a ggplot object (an object called `plot1`):

```{r, echo = TRUE}
plot1 <- ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity")
class(plot1)
plot1
```

Add stuff to the ggplot object you just created:

```{r, echo = TRUE}
plot1 +
  ggtitle("Nb of shipments")
# note how that is equivalent to:
# ggplot(edges, aes(x=month, y=nb_pigs)) +
#    geom_bar(stat="identity") +
#    ggtitle("Nb of shipments") 
```

**Exercise 5**

Use `edges` df to create a ggplot object called `plot2` that depicts:

* A boxplot of the destination farm type (`dest_type`) and the distance in km (`distkm`)
* The data points for `nb_pigs` in different colours according to the origin farm type (`origin_type`)
* Jitter those data points so we can see better what is happening

>TIP: we want the data points to be stratified by origin_type, not the boxplots.

```{r, echo = TRUE}
plot2<- ggplot(edges, aes(x= dest_type, y= distkm))+
  geom_boxplot()+
  geom_jitter(aes(x= dest_type, y= distkm, color = origin_type), width = 0.2)
plot2

ggplot(edges, aes(x= dest_type, y= distkm, color = origin_type))+
  geom_boxplot()+
  geom_jitter(width = 0.2) # # not what we want!
```

> End of exercise 5

## **Plotting networks**

We will need a map (a shapefile) that we can upload into R. [Diva-gis](https://www.diva-gis.org/) has many shapefiles that you can download for free. That is what I did to obtain my Thailand map. 

You can find yours through [diva's website](https://www.diva-gis.org/gdata) or [here](https://github.com/EKuki/website/tree/master/content/courses/new_r_and_sna/THA_adm). Remmeber to save the *THA_adm folder* in your working directory.

Read the map:

```{r, echo = TRUE}
thailand <- readOGR(dsn="**WRITE YOUR WORKING DIRECTORY HERE**/THA_adm",layer="THA_adm1")
thailand2 <- fortify(thailand) # convert into dataframe
```

Create your base map :) :
```{r, echo = TRUE}
base_map <- ggplot() + 
            geom_polygon(data = thailand2,aes(x = long, y = lat, group = group),
               color="gray",
               fill="white") +
            coord_map("albers",  lat0 = 20, lat1 = 102)
base_map
```

Add the `nodes` (those are just points, so use `geom_point`):

```{r, echo = TRUE}
base_map + 
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), 
             size = 3, 
             show.legend=FALSE)
```{r, echo = TRUE}

Add a legend tittle for the nodes:

```{r, echo = TRUE}
base_map + 
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), 
             size = 3)+
  scale_colour_discrete(name = "Scale type")
```

Add the `edges`. Place edges before the nodes, so their image does not overlap:

```{r, echo = TRUE}
base_map + 
  geom_segment(data=edges, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
               color= "grey",
               alpha = 0.5)+
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), 
             size = 3)+
  scale_colour_discrete(name = "Scale type")
```

Add the weight of the edges:

```{r, echo = TRUE}
base_map + 
  geom_segment(data=edges, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
               color= "grey",
               alpha = 0.5,
               size = edges$nb_pigs/200)+
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale),
             size = 3)+
  scale_colour_discrete( name = "Scale type")
```

Change the size of the `nodes` according to `indegree` => I need a network to calculate indegree! Let's create a quick network  (we'll go in more detail on how to do this in another workshop)

```{r, echo = TRUE}
net <- graph_from_data_frame(d=edges, vertices=nodes, directed=TRUE) # Create network
indeg <-degree(net, v=V(net), mode="in",loops=FALSE) # Calculate indegree
nodes$indeg <- indeg # attach indegree column to the nodes df

base_map + 
  geom_segment(data=edges, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
               color= "grey",
               alpha = 0.5)+
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), 
             size = nodes$indeg)+
  scale_colour_discrete(name = "Scale type")
```

What can we do? Follow step by step of these exercises:

**Exercise 6**


Identify which is the huge node. 

> TIP: which observation (row/participant) has the highest indegree? You can:

a) Use the function `max()` coupled with `which()`, and work with indices:

```{r, echo = TRUE}
which(nodes$indeg == max(nodes$indeg))
nodes[which(nodes$indeg == max(nodes$indeg)),]
```

b) you can use `dplyr`

```{r, echo = TRUE}
nodes %>% 
  filter(indeg == max(indeg)) # using dplyr
```

> End of Exercise 6

**Exercise 7**

Remove that huge node (slaugtherhouse) [...and make a note when you present the map!!]. To do that, you can create and work with two df:

1. Create `nodes_nosla` df (nosla = no_slaughterhouse) and remove the observation of the slaugtherhouse. You can do this by using the `dplyr` tools you've learnt: pipes and filtering => Filter nodes df by `indegree`, and be sure that you remove the maximum value of indegree. 

> TIP: remmeber the != operator.
  
```{r, echo = TRUE}  
nodes_nosla <- nodes %>% 
    filter(indeg != max(indeg))
```

2. Create `edges_nosla` df and remove (filter out) the value of "slaugtherhouse" in variable `dest_type` (note that, as we are working with the slaugtherhouse, there are no "slaugtherhouse" values in origin_type - all animals go to the slaugther house to be slaugthered; animals do not leave the slaugtherhouse alive).

```{r, echo = TRUE}
edges_nosla <- edges %>% 
    filter(dest_type != "slaughterhouse")
```

> End of Exercise 7
          
**Exercise 8**

Load your `base_map`  and plot `geom_segment()`, `geom_point()` and `scale_colour_discrete()` as we did before, but this time, use your new dfs: `nodes_nosla` and `edges_nosla`:
  
```{r, echo = TRUE}                    
          base_map + 
            geom_segment(data=edges_nosla, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
                         color= "grey",
                         alpha = 0.5)+
            geom_point(data = nodes_nosla, aes(x = latitude, y = longitude, color = nodes_nosla$scale), 
                       size = nodes_nosla$indeg/2)+
            scale_colour_discrete(name = "Scale type")
 ```
          
> End of Exercise 8

WELL DONE!! :)        