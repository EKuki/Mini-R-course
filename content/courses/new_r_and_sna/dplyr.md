---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: 2. dplyr
#linktitle: "Basics"
summary:
date: 2019-07-14T18:54:37-04:00
lastmod: 2019-07-14T18:54:37-04:00
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
    name: 2. dplyr
    # parent: YourParentID
    weight: 6
---

Follow along with the [power point presentation](https://github.com/EKuki/website/blob/master/content/courses/new_r_and_sna/2.Dplyr_SNA%20using%20R_25March19.pptx) corresponding to this `2. dplyr` section.

You also have the recordings for this section [here](https://www.youtube.com/watch?v=qa9NeUidSZQ), [here](https://www.youtube.com/watch?v=aGQrVnHVVpc) and [here](https://www.youtube.com/watch?v=sFp3VmvS-vA).
*Reminder: Unfortunately, our video software failed a couple of times. If you follow the code and the slides you should be OK, though. In the video material we go through some extra details, q/a, live troubleshooting and everything you can think could go wrong on a live tutorial. Videos are slow, so feel free to increase the speed and remember to watch in HQ (check youtube options).*

**Learning objectives:**

* What is and how to use your working directory
* What is a network
* Load external data from a `.csv` file into a data frame
* Packages and libraries
* Get familiar with `tidyverse` and `dplyr`:
  * `select()`
  * `filter()`
  * Pipe `%>%`
  * `mutate()`
  * `arrange()`
  * Split-and-apply: 
      * `summarize ()`
      * `group_by()`
      * `count()`
  * Wide and long data
      * `spread()`
      * `gather()`
* Export a data frame to a `.csv` file
