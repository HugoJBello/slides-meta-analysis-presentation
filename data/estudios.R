data <- read.csv("./estudios.csv",  header=TRUE, sep=";")

install.packages("meta")
install.packages("metafor")
install.packages("tidyverse")
# sudo apt-get install libnlopt-dev


library("meta")
library("metafor")
library("tidyverse")

# FIXED EFFECTS

m.dl <- meta::metacont(n_exp,
                       media_exp,
                       sd_exp,
                       n_control,
                       media_control,
                       sd_control,
                       data=data,
                       studlab=paste(estudio),
                       fixed = TRUE,
                       random = FALSE,
                       method.tau = "SJ",
                       hakn = TRUE,
                       prediction = TRUE,
                       sm = "SMD")

m.dl
forest(m.dl)

# RANDOM EFFECTS

m.dl <- meta::metacont(n_exp,
                       media_exp,
                       sd_exp,
                       n_control,
                       media_control,
                       sd_control,
                       data=data,
                       studlab=paste(estudio),
                       fixed = FALSE,
                       random = TRUE,
                       method.tau = "SJ",
                       hakn = TRUE,
                       prediction = TRUE,
                       sm = "SMD")

m.dl
forest(m.dl)

