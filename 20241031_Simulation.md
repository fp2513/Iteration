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
    ## 1  2.26  4.16

mean is around 3 and sd is around 4 like the true population This is the
process that we are going to be more rigorous about

Suppose running this over and over again, what would the distribution of
the mean should look like?

(drawing from normal dis population, sample mean should be centered
around true mean and sd of sample mean is the population sd divided by
sample size); establish by statistics

## Let’s stimualte a lot

Not running same line of code over and over again, but doing it formally

Start with a for loop Need to have the output then have the for loop
itself

``` r
output = vector("list", length = 100)

for (i in 1:100) {
  
  output[[i]] = sim_mean_sd(samp_size = 30)
  
} #for each iteration from 1 to 100 i need to do something (run sim_mean_sdw with sample size 30)

#Then need to save the save the output of i

#more manageable if bind rows together 

bind_rows(output)
```

    ## # A tibble: 100 × 2
    ##     mean    sd
    ##    <dbl> <dbl>
    ##  1  1.65  4.18
    ##  2  2.35  4.23
    ##  3  3.41  4.24
    ##  4  3.32  4.51
    ##  5  2.93  3.54
    ##  6  4.11  4.05
    ##  7  2.39  3.87
    ##  8  4.04  3.86
    ##  9  3.48  3.41
    ## 10  2.03  4.66
    ## # ℹ 90 more rows

Looking at this: I have gone out 100 times, each time taking a sample of
30 from a population with a true mean of 3 and sd of 4 Given each sample
compute the mean and sd for each sample

## Let’s use a loop function

In the for loop previously there is an output loop, but there was no
input list.

In the case where we had an input this (for this input do this for this
input do this), we used map Each input in the input list applied to
function to get an output list

Here different, we just want to do the same thing over and over again
–\> rerun rerun(some number of times, some thing)

``` r
sim_results = 
  rerun(100, sim_mean_sd(samp_size = 30)) %>% 
  bind_rows()
```

    ## Warning: `rerun()` was deprecated in purrr 1.0.0.
    ## ℹ Please use `map()` instead.
    ##   # Previously
    ##   rerun(100, sim_mean_sd(samp_size = 30))
    ## 
    ##   # Now
    ##   map(1:100, ~ sim_mean_sd(samp_size = 30))
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

## Let’s take a look at the 100 sample mean and sd results that we got

wrote a function, use rerun, and binding rows

Can start to do data manipulation to this

``` r
sim_results %>% 
  ggplot(aes(x = mean)) + geom_density()
```

![](20241031_Simulation_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
sim_results %>% 
  summarise(
    avg_samp_mean = mean(mean),
    sd_samp_mean = sd(mean)
  )
```

    ## # A tibble: 1 × 2
    ##   avg_samp_mean sd_samp_mean
    ##           <dbl>        <dbl>
    ## 1          2.97        0.779

This shows the distribution of the sample mean across the 100
experiments (centered around 3 which makes sense as the true population
mean we set was 3)

And the sample sd should be able the population sd / sample size 30 ~
0.7

``` r
sim_results %>% 
  ggplot(aes(x = sd)) + geom_density()
```

![](20241031_Simulation_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

dis of sample sd is about 4 but unlike the dis of sample mean the dis is
not normally dis, there is a heavier tail Through simulation we can
learn more about this dis, about what the shape of the dis of sample sd
looks like in repeated sampling
