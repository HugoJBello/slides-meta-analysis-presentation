data <- read.csv("./estudios.csv",  header=TRUE, sep=";")

install.packages("meta")
install.packages("metafor")
install.packages("tidyverse")

library("meta")
library("metafor")
library("tidyverse")

m.dl <- meta::metacont(n_exp,
                       media_exp,
                       sd_exp,
                       n_control,
                       media_control,
                       sd_control,
                       data=data,
                       studlab=paste(id),
                       comb.fixed = FALSE,
                       comb.random = TRUE,
                       method.tau = "SJ",
                       hakn = TRUE,
                       prediction = TRUE,
                       sm = "SMD")
# Random effects model -0.0587 [-0.6938; 0.5765] -0.21  0.8367
# !!!!
m.dl
forest(m.dl)