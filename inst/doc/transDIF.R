## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

## -----------------------------------------------------------------------------
library(transDIF)
sim <- td_simulate(n_ref = 2000, n_focal = 150, n_items = 40, seed = 5)
colSums(sim$features[-1])

## -----------------------------------------------------------------------------
cal <- td_calibrate(sim$responses, sim$group)
dif <- td_dif(cal)
dif

## -----------------------------------------------------------------------------
c(true = -sim$truth$focal_mean, robust = dif$link[["c"]], all_items = dif$c_mean)

## -----------------------------------------------------------------------------
td_impact(dif, cut = 24, n_draws = 100, seed = 1)

## -----------------------------------------------------------------------------
td_features(dif, sim$features)

## -----------------------------------------------------------------------------
cat(td_report(dif, languages = c("English", "French")))

