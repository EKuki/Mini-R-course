---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Chunk 8"
summary:
date: 2019-08-27T08:59:41-04:00
lastmod: 2019-08-27T08:59:41-04:00
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
    name: Chunk 8
    parent: 3. ggplot2
    weight: 13
---

## **Plotting networks**

There are a several ways to plot networks in R. We are going to be using ggplot2 at its simplest, however, feel free to explore others:

* `ggplot2` package
* `GGally` package::ggnet2() 
* `geomnet` package::geom_net(): Wraps all network structures, including vertices, edges, and vertex labels into a single geom
* `ggnetwork` package: provides a way to build network plots with `ggplot2` using `geom_nodes()` and `geom_edges()`: Implements each of the network structures in an independent `geom_` and layers them one by one

## **Getting the map**

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

## **Adding the nodes**

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
## **Adding the edges**

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
## **Embelishing it**

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

**Exercise 1**


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

> End of Exercise 1

**Exercise 2**

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

> End of Exercise 2
          
**Exercise 3**

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
          
> End of Exercise 3

WELL DONE!! :)        