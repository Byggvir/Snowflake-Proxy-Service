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

SQL <- 'select * from Snowflake;'
snowlog <- RunSQL (SQL)

snowlog %>% ggplot(
    aes( x = Zeit ) ) +
    geom_line(aes( y = Connections , colour = Host) ) +
    geom_point(aes( y = Connections, colour = Host ) ) +
    scale_x_datetime() +
    scale_y_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE)) +

    theme_ipsum() +
    labs(  title = "Snowflake connections"
           , subtitle= paste("Stand:", heute)
           , x = "Zeit"
           , y = "Anzahl"
           , coulour = 'Proxy'
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

snowlog %>% ggplot(
  aes( x = Zeit ) ) +
  geom_line(aes( y = Download , colour = Host) ) +
  geom_point(aes( y = Download , colour = Host ) ) +
  scale_x_datetime() +
  scale_y_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE)) +
  theme_ipsum() +
  labs(  title = "Snowflake download"
         , subtitle= paste("Stand:", heute)
         , x = "Zeit"
         , y = "KB"
         , colour = 'Up-/Download'
         , caption = citation 
         ) -> pp2

ggsave("png/DownLoad.png"
       , plot = pp2
       , device = "png"
       , bg = "white"
       , width = 1920
       , height = 1080
       , units = "px"
       , dpi = 144
)

snowlog %>% ggplot(
  aes( x = Zeit ) ) +
  geom_line(aes( y = Upload , colour = Host) ) +
  geom_point(aes( y = Upload , colour = Host ) ) +
  scale_x_datetime() +
  scale_y_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE)) +
  theme_ipsum() +
  labs(  title = "Snowflake upload"
         , subtitle= paste("Stand:", heute)
         , x = "Zeit"
         , y = "KB"
         , colour = 'Up-/Download'
         , caption = citation 
  ) -> pp2


ggsave("png/Upload.png"
       , plot = pp2
       , device = "png"
       , bg = "white"
       , width = 1920
       , height = 1080
       , units = "px"
       , dpi = 144
)

snowlog %>% ggplot(
  aes( x = Upload, y = Download ) ) +
  geom_point( aes( colour = Host ) ) +
  geom_smooth( aes( colour = Host ) ) +
  scale_x_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE)) +
  scale_y_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark= ',', scientific = FALSE)) +
  theme_ipsum() +
  labs(  title = "Snowflake upload"
         , subtitle= paste("Stand:", heute)
         , x = "Upload [KB]"
         , y = "Download [KB]"
         , colour = 'Host'
         , caption = citation 
  ) -> pp4


ggsave("png/UpDown.png"
       , plot = pp4
       , device = "png"
       , bg = "white"
       , width = 1920
       , height = 1080
       , units = "px"
       , dpi = 144
)
