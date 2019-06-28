---
date: "2018-09-09T00:00:00Z"
draft: false
lastmod: "2018-09-09T00:00:00Z"
linktitle: R and SNA
menu:
  example:
    name: Overview
    weight: 1
summary: Short R tutorial to manipulate data and to create social network analysis. Presential course, adapted to become an online tutorial.
title: Overview
toc: true
type: docs
weight: 1
---

## Audience

I created this workshop to capacitate the Healthcare-Associated Infections team at the California Department of Public Health. The main aim was to leave some skills behind on R and Social Network Analysis. The team was proficient in SAS, some were familiar with R and some were not. I put the course together week after week and created `code`, `slides` and `video` material. Unfortunately, our video software failed a couple of times. If you follow the code and the slides you should be OK, though. 

In the video material we go through some extra details, q/a, live troubleshooting and everything you can think could go wrong on an live tutorial. Videos are slow, so feel free to increase the speed and remember to watch in HQ (check youtube options).

## Credit

I borrowed plenty of material from several sources. Online references to those are cited at the end of each power point. The datasets we are using for practice is simulated data that my colleagues at [CADMS](https://cadms.vetmed.ucdavis.edu/), UC Davis, and I developed for a workshop tought at the [ISVEE](http://isvee.net/) conference, back in 2018.

## Overall learning outcomes

* Basic R language usage (basic R and Tidyverse): data manipulation, cleaning and visualization.
*	Basic terminology of graph theory 
*	Understand key concepts of SNA: Network properties and centrality measures
*	Calculate and understand SNA statistics
*	Import and adapt data to construct networks on R studio
*	Visualize and map networks
*	Appropriately and critically interpret results of network analysis 

## Structure of the course

* **1.Basics**
 Intro to workshop, R and R studio environment. Objects, data types.
* **2.dplyr** 
 Working directory. Load data from csv. What is a network?
 Packages and libraries: Tidyverse and dplyr. Verbes: select, filter, “pipes”, mutate, * * arrange , split-and-apply, wide and long data.
* **3.Map with ggplot**
 Components of a ggplot object. 
 Plotting networks.
* **4.Network theory with igraph**
 Data needed to create a network
 Network terminology. Important network metrics.


## Update the docs menu

If you use the *docs* layout, note that the name of the menu in the front matter should be in the form `[menu.X]` where `X` is the folder name. Hence, if you rename the `courses/example/` folder, you should also rename the menu definitions in the front matter of files within `courses/example/` from `[menu.example]` to `[menu.<NewFolderName>]`.
