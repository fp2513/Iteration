20241029_Iteration_and_Listcols
================
2024-10-29

We write a function because we would do the same basic code over and
over again. Process doing over and over is iterations. Take advantage of
the formal structure

Loop functions (avoid keeping track input / output list), easier to read

Map rather than a for loop (not looking inside a for loop to look for
index, instead here is the function that i have and here is input /
output)

Process: 1. start with single working example 2. change into a function
3. re-write into a map statement (do not immediately start try writing a
mapping statement)

Listcols –\> lists are just collections of things not a dataframe
(completely arbitary into a list) Dataframes are a fancy / specific list
Lists can also contain lists (there are lots of stuff to keep track of,
if can keep organised into datafram it would be really helpful, also
sub-elements (there are 1000 weather station, where each weather station
has its own collection of analyses), works well for this kind of
iterative analysis)

# Here’s some lists

Can do something inside the list (define a vector) Different sorts of
objects that can all exist in a single list

``` r
l = list(
  vec_numeric = 1:4, #1 - 4
  unif_sample = runif(100), #100 numbers 
  mat = matrix(1:8, nrow = 2, ncol = 4, byrow = TRUE),
  summary = summary(rnorm(1000))
)

l$mat
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    5    6    7    8

notation l\$mat can pull out from list (not the most ideal with \$ but
can) or can l\[\[“mat”\]\] with two square brackets

``` r
l[["mat"]]
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    5    6    7    8

``` r
l[["mat"]][1, 3] #in mat list find either 
```

    ## [1] 3

``` r
l[[1]] #pull the first object from list
```

    ## [1] 1 2 3 4

``` r
list_norm = 
  list(
    a = rnorm(20, 0, 5),
    b = rnorm(20, 4, 5),
    c = rnorm(20, 0, 10),
    d = rnorm(20, 4, 10)
  )

list_norm[["b"]] #can pull specific one
```

    ##  [1] -1.2472309  5.6160839 -1.3609458  1.9932520  9.2503477  1.0694113
    ##  [7]  9.9964587 13.9266245  2.8852251  3.5249967  1.9103458 -0.5667241
    ## [13]  3.5582847  3.5187538  3.3407785  8.1158514  8.6586680 -3.1334859
    ## [19]  2.3021194  4.6775031

``` r
#list of 4 samples from 4 differnet normal dis
```

Now have thees 4 samples and want to compute the mean and sd of each of
the norm dis (write a function for mean and standard dev)

``` r
mean_and_sd = function(x) {
  
  mean_x = mean(x)
  sd_x = sd(x)
  
  out_df = 
    tibble(
      mean = mean_x, 
      sd = sd_x
    )
  
  return(out_df)
}
```

We can use this function to make mean and sd of all samples

``` r
mean_and_sd(list_norm[["a"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  1.06  5.01

``` r
mean_and_sd(list_norm[["b"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  3.90  4.32

``` r
mean_and_sd(list_norm[["c"]])
```

    ## # A tibble: 1 × 2
    ##     mean    sd
    ##    <dbl> <dbl>
    ## 1 -0.848  7.50

``` r
mean_and_sd(list_norm[["d"]])
```

    ## # A tibble: 1 × 2
    ##    mean    sd
    ##   <dbl> <dbl>
    ## 1  3.71  10.1

To write 4 rows at once can click shift option then highlight the rows
that i want to type on

But imagine there are more than 4 samples, what if had 10000s of samples
then would be very difficult. Can create a for loop for this

## Use a for loop

Create an output list, and run a for loop

``` r
#we are creating an output with 4 spots in it 

output = vector("list", length = 4)

for (i in 1:4) {
  
  output[[i]] = mean_and_sd(list_norm[[i]])
  
}
```

Got a list of normals, there are 4 lists and for any one of those i want
to apply mean and sd. and now i am creating an output list to catch each
of the outputs separately

if list_norm had 1000 entries to it can still work (rather than keeping
track of each index myself and typing it all out)
