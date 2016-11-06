library(pwr)

get_power <- function(effect_size, sample_size, sig_level) {
  
  power <- pwr.2p.test(h = effect_size , n = sample_size , sig.level = sig_level)
  
  power$power
}