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

I created this workshop to capacitate the Healthcare-Associated Infections team at the California Department of Public Health. The main aim was to leave some skills behind on R and Social Network Analysis. The team was proficient in SAS, some were familiar with R and some were not. I put the course together week after week and created `code`, `slides` and `video` material. Unfortunately, our video software failed a couple of times; following the code and the slides should do, though. 
In the video material we go through some extra details, q/a, live troubleshooting and everything you can think could go wrong on an live tutorial. Videos are slow, so feel free to increase the speed and remember to watch in HQ (check youtube options).

## Credit

I borrowed plenty of material from several sources. Online references to those are cited at the end of each power point. The datasets we are using for practice is simulated data that me and my colleagues at [CADMS](https://cadms.vetmed.ucdavis.edu/), UC Davis, developed for a workshop tought at the [ISVEE](http://isvee.net/) conference, back in 2018.

## Overall learning outcomes

* Basic R language usage (basic R and Tidyverse): data manipulation, cleaning and visualization.
*	Basic terminology of graph theory 
*	Understand key concepts of SNA: Network properties and centrality measures
*	Calculate and understand SNA statistics
*	Import and adapt data to construct networks on R studio
*	Visualize and map networks
*	Appropriately and critically interpret results of network analysis 
*	Going beyond: Community algorithms and regression (one by one)
*	Going beyond-er: Dynamic networks, Shiny App (if time allows)


## Structure of the course

* **1.Basics**
 Intro to workshop, R and R studio environment.Objects, data types.
* **2.dplyr** 
 Working directory. Load data from csv. What is a network?
 Packages and libraries: Tidyverse and dplyr. Verbes: select, filter, “pipes”, mutate, * * arrange , split-and-apply, wide and long data.
* **3.Map with ggplot**
 Components of a ggplot object. 
 Plotting networks
* **4.Network theory with igraph**
 Data needed to create a network
 Network terminology. Important network metrics.

The `courses` folder may be renamed. For example, we can rename it to `docs` for software/project documentation or `tutorials` for creating an online course.

## Delete tutorials

**To remove these pages, delete the `courses` folder and see below to delete the associated menu link.**

## Update site menu

After renaming or deleting the `courses` folder, you may wish to update any `[[main]]` menu links to it by editing your menu configuration at `config/_default/menus.toml`.

For example, if you delete this folder, you can remove the following from your menu configuration:

```toml
[[main]]
  name = "Courses"
  url = "courses/"
  weight = 50
```

Or, if you are creating a software documentation site, you can rename the `courses` folder to `docs` and update the associated *Courses* menu configuration to:

```toml
[[main]]
  name = "Docs"
  url = "docs/"
  weight = 50
```

## Update the docs menu

If you use the *docs* layout, note that the name of the menu in the front matter should be in the form `[menu.X]` where `X` is the folder name. Hence, if you rename the `courses/example/` folder, you should also rename the menu definitions in the front matter of files within `courses/example/` from `[menu.example]` to `[menu.<NewFolderName>]`.
