20241031_Simulation
================
2024-11-04

Why simulations? Central limit theorem, drawing independent samples and
samples from a population eventually will average of the sample mean
will look closer to population mean repeated sampling (statistical
analysis) does not happen in reality (data expensive to collect) but it
can happen on a computer (can see what really happens under repeated
sampling)

Gives us a way to check whether statistical approach does the thing that
it claims to do

Simulations are natural in the context of iterations

Write a function that - defines data generating mechanisms - draw a
sample - analyse the sample - repeated object of interest (mean,
regression etc)

use loop to repeat

can inspect and understand properties of statistical analysis what
happens when change sample size, what happens when change something in
study design

## Let’s simulate something

sample size has default true mean 3 and true sd 4

``` r
sim_mean_sd = function(samp_size, mu = 3, sigma = 4) {
  
  sim_data = 
    tibble(
      x = rnorm(n = samp_size, mean = mu, sd = sigma) #generates data from a normal dis with this sample size and this mean
    )
  
  sim_data %>% #then taking that data sample, we know the truth of the population
    summarise(
      mean = mean(x),
      sd = sd(x)
    ) #returns sample mean and sd
}
```

Repeating this run (go out into the population, draw sample size of 30,
then give me sample mean and sample sd)

I have a function and i can simulate by running this line

``` r
sim_mean_sd(30)
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  2.35  4.10

mean is around 3 and sd is around 4 like the true population This is the
process that we are going to be more rigorous about

Suppose running this over and over again, what would the distribution of
the mean should look like?

(drawing from normal dis population, sample mean should be centered
around true mean and sd of sample mean is the population sd divided by
sample size); establish by statistics
