library(renv)
library(shiny)
library(shinyWidgets)
library(rtweet)
library(twitteR)
library(DT)
library(dplyr)
library(lubridate)
library(graphTweets)
library(httr)
library(plotly)
library(networkD3)
library(ggplot2)
library(ggthemes)
library(stringr)
library(tm)
library(igraph)

library(bs4Dash)

source("mod/twitter.R")
source("mod/auth_twitter_mod.R")
source("mod/dash_mod.R")
source("mod/bs4elem.R")

###------------Global-----------------------#
pos.words <- scan('data/pos.wordsAr5.txt', sep = "\n", what='character',encoding = 'UTF-8')
neg.words <- scan('data/neg.wordsAr5.txt', sep = "\n", what='character',encoding = 'UTF-8')
stop.wordsAr <- scan('data/stop.wordsAr.txt', sep = "\n", what='character',encoding = 'UTF-8')


useCss<-function(file="style.css"){
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = file)
  )
}