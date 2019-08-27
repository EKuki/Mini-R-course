
# 3.Map SNA ggplot - With solutions

# Libraries ----
# You will have to install these packages in Rstudio before calling the library
library(tidyverse)
library(raster) # pointDistance()
library(igraph)
library(rgdal) # getData() - This package provides bindings to the Geospatial Data Abstraction Library (GDAL) 
               # for reading, writing and converting between spatial formats.
library(graphics) # text()
library(maps) # map.scale()

# Chunk 1 - ggplot essentials ================

# Set working directory and load files
#setwd("H:/R training/R and SNA Training CDPH/3.Map SNA ggplot")
setwd("G:/HAI/Kukielka, Esther/R and SNA Training CDPH/3.Map SNA ggplot")

## >> C1.1. Exercise  ----
# Load the file nodes_data_final.csv into an object called nodes_base and explore its values. Use read_csv()
# Make sure premise_type, scale, and area are factors. Use read_csv()
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
## FIN Exercise

## >> C1.2. Exercise  ----
# Load the file edges_data_final.csv into an object called edges and explore its values. Use read_csv()
# Make sure origin, dest, month, origin_type and dest_type are factors. Use read_csv()

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

## FIN Exercise

# Add a vector of distance (in m) between origin and destination farms, in the edges object:
dist<-pointDistance(cbind(edges$longitude_orig, edges$latitude_orig), cbind(edges$longitude_dest, edges$latitude_dest), lonlat=TRUE)
distkm<-dist/1000
edges$distkm<-distkm
head(edges)


# Explore transactions with ggplot
# Simply plot the layout of our plot: plot = data + aes
ggplot(data= edges, aes(x=month, y=nb_pigs))

# Add data as points:  plot = data + aes + geom_
ggplot(data= edges, aes(x=month, y=nb_pigs)) + 
   geom_point() 
   # same as:
   edges %>% 
     ggplot(aes(x=month, y=nb_pigs)) + # add data as points
     geom_point() 

# Add colour
ggplot(data= edges, aes(x=month, y=nb_pigs, color = origin_type)) + # Note: the aes() that we apply in this first row are 
                                                              # going to be applied in the subsequent rows of code 
   geom_point() 

# Jitter those points
ggplot(data=edges, aes(x=month, y=nb_pigs, color = origin_type)) + 
   geom_jitter(width = 0.2)

# Do a boxplot instead
ggplot(edges, aes(x=month, y=nb_pigs, color = origin_type)) +
   geom_boxplot()

## >> C1.3. Exercise  ----
# Create a boxplot of nb_pigs per month, without stratifying by origin_type 
# TIP: do not specify color

ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot()

## FIN Exercise

## >> C1.4. Exercise  ----
# Use that new boxplot you created and superpose the data as points
# TIP: follow the tidy logic: plot the boxplot first, and then plot the points
# EXTRA: what happens if you create the points first and then you create the boxplots?

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

## FIN Exercise


# Color per month (use fill= within the aes() argument)
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot(fill = month)+
   geom_point() # does not work!

ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_boxplot(aes(x=month, y=nb_pigs, fill = month))+
   geom_point()

# Why is that code above the same as:  ???
ggplot(edges, aes(x=month, y=nb_pigs, fill = month)) +
   geom_boxplot()+
   geom_point()

# Do a barchart instead
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") # geom_bar() => count the nb of pigs per month 

# order those month levels!
levels(edges$month)
edges$month <- factor(edges$month, levels=c("January","February","March","April", "May","June",
                                            "July","August","September","October","November","December"))
levels(edges$month)

# try again
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity")

# Flip the coordinates (make the bar horizontal)
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity")+
   coord_flip() 


# Try a different coord_() function
ggplot(edges, aes(x=month, y=nb_pigs)) +
  geom_bar(stat="identity")+
  coord_polar(theta="x")
  # Add some color
  ggplot(edges, aes(x=month, y=nb_pigs, fill = month)) +
     geom_bar(stat="identity")+
    coord_polar(theta="x")


# Add tittle
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments") # Nb of shipments\n: \n acts as "enter"

ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments\nper month")


# Remove redundant axis lables:
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments") +
   labs(x=NULL, y= NULL)

# Remove background color
ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity") +
   ggtitle("Nb of shipments") +
   labs(x=NULL, y= NULL) +
   theme(
   panel.background = element_blank())

# Do a bunch of other stuff
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

# Create a ggplot object
plot1 <- ggplot(edges, aes(x=month, y=nb_pigs)) +
   geom_bar(stat="identity")
class(plot1)
plot1

# add stuff to the ggplot object you just created
plot1 +
  ggtitle("Nb of shipments")
# note how that is equivalent to:
# ggplot(edges, aes(x=month, y=nb_pigs)) +
#    geom_bar(stat="identity") +
#    ggtitle("Nb of shipments") 

## >> C1.5. Exercise  ----
# Use edges df to create a ggplot object called plot2 that depicts:
# A boxplot of the destination farm type (dest_type) and the distance in km (distkm).
# The data *points* for nb_pigs in different colours according to the origin farm type (origin_type)
# Jitter those data points so we can see better what is happening
# TIP: we want the data points to be stratified by origin_type, not the boxplots.

plot2<- ggplot(edges, aes(x= dest_type, y= distkm))+
  geom_boxplot()+
  geom_jitter(aes(x= dest_type, y= distkm, color = origin_type), width = 0.2)
plot2

ggplot(edges, aes(x= dest_type, y= distkm, color = origin_type))+
  geom_boxplot()+
  geom_jitter(width = 0.2) # # not what we want!

## FIN Exercise




# Chunk 2 - Plotting networks with ggplot ================
#download map and name it thailand from your computer's location and choose the map layer#

thailand<-readOGR(dsn="H:/R training/R and SNA Training CDPH/3.Map SNA ggplot/THA_adm",layer="THA_adm1")
thailand2 <- fortify(thailand) # convert into dataframe

# Create your base map :)
base_map <- ggplot() + 
            geom_polygon(data = thailand2,aes(x = long, y = lat, group = group),
               color="gray",
               fill="white") +
            coord_map("albers",  lat0 = 20, lat1 = 102)
base_map


# Add the nodes
base_map + 
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), 
             size = 3, 
             show.legend=FALSE)


# Add a legend tittle for the nodes
base_map + 
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), 
             size = 3)+
  scale_colour_discrete(name = "Scale type")


# Add the edges. Place edges before the nodes, so their image does not overlap.
base_map + 
  geom_segment(data=edges, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
               color= "grey",
               alpha = 0.5)+
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), 
             size = 3)+
  scale_colour_discrete(name = "Scale type")


# Add the weight of the edges.
base_map + 
  geom_segment(data=edges, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
               color= "grey",
               alpha = 0.5,
               size = edges$nb_pigs/200)+
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale),
             size = 3)+
  scale_colour_discrete( name = "Scale type")


# Change size of nodes according to indegree => I need a network to calculate indegree!
# Create a quick network  (we'll go in more detail on how to do this in another workshop)
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



# What can we do? Follow step by step of these exercises:
## >> C2.1. Exercise  ----
# Identify which is the huge node. 
# TIP: which observation (row/participant) has the highest indegree? You can:
# a) use the function max() coupled with which(), and work with indeces 
which(nodes$indeg == max(nodes$indeg))
nodes[which(nodes$indeg == max(nodes$indeg)),]
# b) you can use dplyr
nodes %>% 
  filter(indeg == max(indeg)) # using dplyr
## FIN Exercise

## >> C2.2. Exercise  ----
# Remove that huge node (slaugtherhouse) [...and make a note when you present the map!!]
# To do that, you can create and work with two df:
# 1. Create 'nodes_nosla' df (nosla = no_slaughterhouse) and remove the observation of the slaugtherhouse. You can
# do this by using the dplyr tools you've learnt: pipes and filtering => Filter nodes df by indegree, 
# and be sure that you remove the maximum value of indegree. 
# TIP: remmeber the != operator.
          nodes_nosla <- nodes %>% 
            filter(indeg != max(indeg))

# 2. Create 'edges_nosla' df and remove (filter out) the value of "slaugtherhouse" in variable dest_type (note that, as 
# we are working with the slaugtherhouse, there are no "slaugtherhouse" values in origin_type - all animals go to the 
# slaugther house to be slaugthered; animals do not leave the slaugtherhouse alive).
          edges_nosla <- edges %>% 
            filter(dest_type != "slaughterhouse")
## FIN Exercise
          
## >> C2.3. Exercise  ----
# Load your base_map  and plot geom_segment(), geom_point() and scale_colour_discrete() as we did before, but this time,
          # use your new dfs: nodes_nosla and edges_nosla
                    
          base_map + 
            geom_segment(data=edges_nosla, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
                         color= "grey",
                         alpha = 0.5)+
            geom_point(data = nodes_nosla, aes(x = latitude, y = longitude, color = nodes_nosla$scale), 
                       size = nodes_nosla$indeg/2)+
            scale_colour_discrete(name = "Scale type")
 
          
## FIN Exercise
# WELL DONE!! :)          
          

                   
          # Another option to deal with that huge indegree could be to leave that huge node (slaugtherhouse), 
          # but artificially decrease its value, just for plotting purposes (and remember to make a note about it!)
          nodes_25<- nodes %>% 
            mutate(indeg2 = ifelse(indeg>25, 25, indeg)) # if the indegree value is > 25, force it to become 25.
          
          base_map + 
            geom_segment(data=edges, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
                         color= "grey",
                         alpha = 0.5)+
            geom_point(data = nodes_25, aes(x = latitude, y = longitude, color = nodes_25$scale), 
                       size = nodes_25$indeg2/1.5)+
            scale_colour_discrete(name = "Scale type")







# Plot only those contacts between backyard farms:
# Choose those nodes that are backyard
nodes_bky <- nodes %>% 
  filter(scale == "backyard")
dim(nodes_bky) #11 rows => 11 nodes

# Choose those origins and destinations that are backyard
edges_bky_0 <- semi_join(edges, nodes_bky, by = c( "origin" = "part_names")) 
edges_bky <-  semi_join(edges_bky_0, nodes_bky, by = c( "dest"= "part_names"))

base_map + 
  geom_segment(data=edges_bky, aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
               color= "grey",
               alpha = 0.5)+
  geom_point(data = nodes_bky, aes(x = latitude, y = longitude, color = nodes_bky$scale), 
             size = 3)+
  scale_colour_discrete(name = "Scale type")




# Plot only those contacts TO the slaughterhouse, and add the wights of the edges:
edges_dest_sla <- edges[which(edges$dest_type=="slaughterhouse"),] # df containing only those transfers TO the slaughterhouse

base_map + 
  geom_segment(data=edges_dest_sla , aes(x=longitude_orig, y=latitude_orig, xend=longitude_dest, yend=latitude_dest), 
               color= "grey",
               alpha = 0.5,
               size = edges_dest_sla$nb_pigs/200)+
  geom_point(data = nodes, aes(x = latitude, y = longitude, color = nodes$scale), size = 3)+
  scale_colour_discrete( name = "Scale type")


 
# Alternatively, you can choose those transfers where the market was involved - from and to the market (bd= both directions)
# the operator '|' means OR
edges_market_bd <- edges[which(edges$dest_type=="market"|edges$origin_type=="market"),]

# ADVANCED read this piece of code once we have seen a bit more theory on networks.
# You can also plot the edges from a simplified network, by transforming your network into a df and then using that df
# nets2 <-igraph::simplify(net, remove.loops = TRUE,
#                          remove.multiple = TRUE, 
#                          edge.attr.comb = list(
#                            month = "ignore", nb_pigs = "sum", longitude_orig = "first",
#                            latitude_orig = "first", longitude_dest = "first", latitude_dest = "first",
#                            origin_type = "first", dest_type = "first", distkm = "first", weight = "sum"))
# nets2 # Note DNW- 40 202
# edges_sim <- as_long_data_frame(nets2)

