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
sens <- td_sensitivity(dif, cut = 24, B = 100, n_draws = 50, seed = 1)
sens

## -----------------------------------------------------------------------------
sens$linkings
sens$bootstrap
sens$items[sens$items$linking_sensitive, ]

## -----------------------------------------------------------------------------
big <- td_simulate(n_ref = 1000, n_focal = 400, n_items = 40, seed = 1)
dif_big <- td_dif(td_calibrate(big$responses, big$group))
td_sensitivity(dif_big, cut = 24, B = 100, n_draws = 50, seed = 1)

## -----------------------------------------------------------------------------
heavy <- c(idiom = 0.18, cultural = 0.18, units = 0.10, vocabulary = 0.2)
short <- td_simulate(n_ref = 1000, n_focal = 80, n_items = 16,
                     feature_prev = heavy, seed = 5)
dif_short <- suppressWarnings(td_dif(td_calibrate(short$responses, short$group)))
td_sensitivity(dif_short, cut = 10, B = 100, n_draws = 50, seed = 1)

## -----------------------------------------------------------------------------
td_features(dif, sim$features)

## -----------------------------------------------------------------------------
cat(td_report(dif, languages = c("English", "French")))

