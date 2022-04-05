# пакеты для установки командой install.packages(base.packages)
base.packages <<- c(
  # general stuff
  "tidyverse", "magrittr", "glue", "scales", "purrr", "furrr", "profvis", 
  
  # package installation and management
  "curl","devtools","remotes", 
  
  # data handling
  "lubridate", "reshape","reshape2", "scales", 
  
  # file import
  "openxlsx", "tidyxl", "gsheet", "readr","readxl", "rio", 
  
  # models
  "investr", "lme4","lmtest","mice","missForest","modelr",
  "mvtnorm","naniar", "multcomp","drc", "nlme","caret", 
  "sandwich", "broom","car","caret", "randomForest",
  
  # web 
  "httr","jsonlite", "rvest", 'htmltools', 'jquerylib', 
  
  # reports
  "rmarkdown", "knitr","prettydoc","repr","reprex", "shiny", 
  
  # plots
  "ggpubr","ggrepel","ggridges","ggstance","ggthemes",
  "corrplot","cowplot","plotly", "rvg", "ggalt","ggExtra", 
  "officer", "ggmosaic", "esquisse", "GGally","ggforce", 
  "ggprism", "ggsci",
  
  # misc
  "Amelia","boot","gdtools","gridExtra","gtools","hexbin","kableExtra",
  "selectr", "sinaplot","sjPlot","RColorBrewer","ipred","effsize","dunn.test",
  "remedy", "jtools",  "vcd",  'xfun' 
)

# пакеты для установки командой remotes::install_github(base.packages)
github.packages <<- c(
  "patchwork"="thomasp85/patchwork", # combine images
  "crayon"="r-lib/crayon",           # colored text in terminal
  "rstatix"="kassambara/rstatix",    # tidy stats
  "export"="tomwenseleers/export"    # plots -> pptx
  )
