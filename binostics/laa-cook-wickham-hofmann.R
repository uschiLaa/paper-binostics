## ----setup, include=FALSE-------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      message = FALSE, 
                      warning = FALSE,
                      root.dir = here::here(), fig.path = here::here("figs/"), 
                      fig.align = 'center', 
                      tidy = TRUE)
library(tidyverse)
library(gridExtra)


## ----parkinsons-----------------------------------------------------
pk <- as.data.frame(read.csv("data/parkinsons.csv")[,-c(1,18)])
s <- binostics::scagnostics(pk)
tibble::glimpse(s)


## ----pairs, out.width="100%", fig.width=10, fig.height=10, fig.cap="Scatterplot matrix of scagnostics computed on the parkinsons data."----
# get SPLOM using GGally
GGally::ggpairs(s, columns=1:9,  upper = list(continuous = "blank"), switch = "both")

## ----plotly, eval=F-------------------------------------------------
## ## read variable columns to generate point labels
## ## these are only used in the interactive display
## s <-  dplyr::mutate(s, labs = paste0(var1,"-",var2))
## ## to generate a useful interactive plotly version we can
## ## pass in the labels as text text (note that this will cause warnings in ggpairs)
## GGally::ggpairs(s, aes(text = labs), columns=1:9) %>%
##   plotly::ggplotly()


## ----examples, echo=F, out.width="80%", fig.width=8, fig.height=8, fig.cap="Pairs of parkinsons data variables with high or unusual combinations of scagnostic values are shown. "----
p1 <- ggplot(pk, aes(MDVP.RAP, Jitter.DDP)) + geom_point() + theme(aspect.ratio = 1) + ggtitle("A High on Stringy, Monotonic ... ")
p2 <- ggplot(pk, aes(Shimmer.APQ5, HNR)) + geom_point() + theme(aspect.ratio = 1) + ggtitle("B High on Skewed")
p3 <- ggplot(pk, aes(MDVP.Fo.Hz., MDVP.Fhi.Hz.)) + geom_point() + theme(aspect.ratio = 1) + ggtitle("C Low on Convex and Monotonic")
p4 <- ggplot(pk, aes(MDVP.Jitter.Abs., Jitter.DDP)) + geom_point() + theme(aspect.ratio = 1) + ggtitle("D Unusual combination of several")
grid.arrange(p1, p2, p3, p4, nrow=2)

