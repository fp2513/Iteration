20241024_Writing_Functions
================
2024-10-24

rvest to do some data importing

Functions to use when using the same basic code more than two times
(iteration) Functions like mapping in maths (have an input then have a
described operation and have an output)

Scoping: if in function there is some variable that you haven’t defined
then the function will scope your entire R environment to see whether
you had previously defined this variable (but generally this is
something that you do not want) want to make sure that everything that
you need for the function to work is defined inside the function (since
work environemnt can change) Function should be self contained and is
everything that this function needs defined in the function

Writing a function that is clear is really important

## Writing my first function

Standardising is frequent in statistic (subtract mean divide standard
deviation)

As an example, here is a z-score computation

``` r
x_vec = rnorm(n = 25, mean = 10, sd = 3.5)

(x_vec - mean(x_vec)) / sd(x_vec)
```

    ##  [1]  0.48509470  0.77597350 -0.58783285  1.61114726 -0.48353809 -0.76793176
    ##  [7]  1.04748210 -0.83966173 -1.90178585 -1.44393724 -0.64131069 -0.94749256
    ## [13] -1.02311939  0.62272323 -0.14968276 -0.61496463  1.12425543  0.33489579
    ## [19] -0.79348416  1.87840005 -0.10636853 -0.06462347  1.70043719  0.38704180
    ## [25]  0.39828266

Next write a function that calculates the z-score

``` r
z_scores = function(x) {
  
  z = (x - mean(x)) / sd(x)
  
  return(z)
}

z_scores(x = x_vec)
```

    ##  [1]  0.48509470  0.77597350 -0.58783285  1.61114726 -0.48353809 -0.76793176
    ##  [7]  1.04748210 -0.83966173 -1.90178585 -1.44393724 -0.64131069 -0.94749256
    ## [13] -1.02311939  0.62272323 -0.14968276 -0.61496463  1.12425543  0.33489579
    ## [19] -0.79348416  1.87840005 -0.10636853 -0.06462347  1.70043719  0.38704180
    ## [25]  0.39828266

parenthesizes () is where define argument, {} to define the operation
Can see () defining what my inout is and {} what my output should be

Inside the function not re-using the x-vector Inside function i have the
argument x and then outside the function i have defined that the x
argument is the x-vector Can change the argument into something else and
the function will operate the same

Can create a new x vector

Kinds of things that want to double check Does this always work

``` r
z_scores(x = 3)
```

    ## [1] NA

Cannot work since there is no sd if there is only one value

``` r
z_scores("my name is jeff")
```

    ## Warning in mean.default(x): argument is not numeric or logical: returning NA

    ## Error in x - mean(x): non-numeric argument to binary operator

Cannot work since trying to take the mean of words not numbers

So these are checks and we can put this into the function Conditional
execution checks

``` r
z_scores = function(x) {
  
  if(!is.numeric(x)) {
    stop("x needs to be numeric")
  }
  
  if(length(x) < 5) {
    stop("you need at least 5 numbers to compute the z score")
  }
  
  z = (x - mean(x)) / sd(x)
  
  return(z)
}

z_scores(x = x_vec)
```

    ##  [1]  0.48509470  0.77597350 -0.58783285  1.61114726 -0.48353809 -0.76793176
    ##  [7]  1.04748210 -0.83966173 -1.90178585 -1.44393724 -0.64131069 -0.94749256
    ## [13] -1.02311939  0.62272323 -0.14968276 -0.61496463  1.12425543  0.33489579
    ## [19] -0.79348416  1.87840005 -0.10636853 -0.06462347  1.70043719  0.38704180
    ## [25]  0.39828266

``` r
z_scores(x = 3)
```

    ## Error in z_scores(x = 3): you need at least 5 numbers to compute the z score

``` r
z_scores("my name is jeff")
```

    ## Error in z_scores("my name is jeff"): x needs to be numeric

Now these can work

Helpful that conditional execution exists If the input is a character
vector i want this to happen but if it is numeric i want this to happen
(compute a plot or a table based on data input)

This is relatively simple (one input one output)
