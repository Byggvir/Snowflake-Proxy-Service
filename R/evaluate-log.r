#!/usr/bin/env Rscript

library(tidyverse)
library(grid)
library(gridExtra)
library(gtable)
library(lubridate)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(scales)
library(ragg)

# Set Working directory to git root

if (rstudioapi::isAvailable()){
    
    # When executed in RStudio
    SD <- unlist(str_split(dirname(rstudioapi::getSourceEditorContext()$path),'/'))
    
} else {
    
    #  When executi on command line 
    SD = (function() return( if(length(sys.parents())==1) getwd() else dirname(sys.frame(1)$ofile) ))()
    SD <- unlist(str_split(SD,'/'))
    
}

WD <- paste(SD[1:(length(SD)-1)],collapse='/')

setwd(WD)
require(data.table)

source("R/lib/sql.r")

options(scipen=10)

today <- Sys.Date()
heute <- format(today, "%d %b %Y")
citation <- paste("© 2022 by Thomas Arend\nStand:", heute )

SQL <- 'select * from log;'
snowlog <- RunSQL (SQL)

snowlog %>% ggplot(
    aes( x = Jahr ) ) +
    geom_line(aes( y = Connections )) +
    scale_y_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE)) +
    theme_ipsum() +
    labs(  title = "Snowflake connections"
           , subtitle= paste("Stand:", heute)
           , x = "Jahr"
           , y = "Anzahl"
           , caption = citation ) -> pp1

ggsave("png/Connections.png"
       , plot = pp1
       , device = "png"
       , bg = "white"
       , width = 1920
       , height = 1080
       , units = "px"
       , dpi = 144
)