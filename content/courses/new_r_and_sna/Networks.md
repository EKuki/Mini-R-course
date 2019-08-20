---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Networks"

summary:
date: 2019-08-20T16:34:00-04:00
lastmod: 2019-08-20T16:34:00-04:00
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
    name: Networks
    parent: 2. dplyr
    weight: 8
---

## **What is a network?**
We could talk about many things when we refer to networks, in our case, I'm going to refer to network as a set or relationships (contacts, somehow) between actors (people, buildings, villages). 

We refer to those actors as *nodes* and to their relationships as *edges*.

Networks are some times called *graphs*.

A network can have a **directionality**, if the edges between the nodes have a direction (for example, if villages are nodes, and transfers of pigs are edges, knowing that Village_A sends pigs to Village_B will tell us that our network is *directed*. On the other side, if we know that Village_A and Village_B are connected by pig transfer but we don't know who sends to whom, we would say that our network is undirected). We usually represent a directed network with arrows (showing directionality) and undirected networks by simple lines (without arrow heads).

Nodes and edges have **attributes** (or characteristics). In our example, node attributes could be the size of the village (how many people live there), its geolocation, its county, the number of hospitals in that village, etc. Edges attributes would be characteristics related to the pig transfer, for example, origin and destination of the transfer, the date the transfer occured, the number of pigs transfered, the breed of those pigs, etc.

Nodes and edges attributes usually are stored as a *node attribute table* (or csv) and an *edge attribute table*, respectively.

## **What are social networks useful for?**
* Identification of hubs (i.e., important facilities regarding transfers), so we can avoid: 
    * Disease spread > Control strategies
    * Disease introduction > Prevention strategies

    > These will help produce *targeted* and *cost-effective* interventions 

* Risk factor analysis (i.e. regression)
* Outbreak investigation (i.e., traceability)
