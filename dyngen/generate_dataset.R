# Script created with the help of Robrecht Cannoodt
library(tidyverse)
library(dyngen)

# I start off with few TFs, few targets, and 
# no housekeeping genes
num_cells <- 1000
num_tfs <- 25
num_targets <- 100
num_hks <- 15

# sample multiple cells from one simulation
num_simulations <- 100

# generate backbone
backbone_name <- "linear"
backbone <- list_backbones()[[backbone_name]]()

# determine the simulator warm-up time
# converging and disconnected backbones need
# a longer burn in time
burn_time <-
  case_when(
    backbone_name == "converging" ~ 5,
    backbone_name == "disconnected" ~ 6,
    TRUE ~ 2
  )

# determine final time. 
# the backbone$expression_patterns contains an estimation of about
# how long it takes for a cell to traverse through a certain branch
# I use this to determine the maximum simulation time, since
# there is no point in letting the simulation run when a cell has reached
# the end state
exp_pat <- backbone$expression_patterns
sim_time_sum <- exp_pat %>% filter(start) %>% pull(from) %>% set_names(rep(0, length(.)), .)
for (i in seq_len(nrow(exp_pat))) {
  sim_time_sum[[exp_pat$to[[i]]]] <- sim_time_sum[[exp_pat$from[[i]]]] + exp_pat$time[[i]]
}
total_time <- max(sim_time_sum * 1.2)

# generate model parameters
model <-
  initialise_model(
    num_cells = num_cells,
    num_tfs = num_tfs,
    num_targets = num_targets,
    num_hks = num_hks,
    backbone = backbone,
    tf_network_params = tf_network_default(
      min_tfs_per_module = 2
    ),
    feature_network_params = feature_network_default(
      target_resampling = 5000, 
      damping = 1 # I increase the default damping to make the network less centralised towards the TFs
    ),
    simulation_params = simulation_default(
      num_simulations = num_simulations,
      census_interval = .025,
      burn_time = burn_time,
      total_time = total_time
    ),
    verbose = TRUE,
    download_cache_dir = "~/.cache/dyngen", # cache for downloaded files
    num_cores = 4 # increase / decrease this depending on your machine
  )

# generate gene network and its kinetics
model <- model %>%
  generate_tf_network() %>%
  generate_feature_network() %>%
  generate_kinetics()

plot_feature_network(model, show_targets = FALSE)
plot_feature_network(model, show_targets = TRUE)

# generate gold standard trajectory
# (This is created by disabling certain parts of the
# gene regulatory network such that a cell is certain to 
# follow a certain branch. 
# This is defined by backbone$expression_patterns.)
model <- model %>%
  generate_gold_standard() 

plot_gold_simulations(model) + scale_colour_brewer(palette = "Dark2")
#plot_gold_simulations_proj(model) + scale_colour_brewer(palette = "Dark2")
plot_gold_expression(model, "x") # view premrna expression for each of the segments in the trajectory

# simulate individual cells and sample 10 cells per simulation (num_cells / num_simulations)
model <- model %>%
  generate_cells() %>%
  generate_experiment()

# compare how each part of the simulation maps to the gold standard
plot_gold_mappings(model, do_facet = FALSE) + scale_colour_brewer(palette = "Dark2")
patchwork::wrap_plots(
  plot_simulations(model) + coord_equal(),
  plot_gold_simulations(model) + scale_colour_brewer(palette = "Dark2") + coord_equal(),
  nrow = 1
)
# visualise expression of TFs over time, for different simulations
plot_simulation_expression(model, 1)
plot_simulation_expression(model, 2)
plot_simulation_expression(model, 3)
plot_simulation_expression(model, 5)

# wrap output objects
traj <-
  model %>%
  wrap_dataset()

traj$feature_network <- model$feature_network

# write to file
write_rds(traj, derived_file("dataset.rds"), compress = "gz")

# you can save 'model' as well, if you like, but the individual simulations
# can take up a lot of space.
