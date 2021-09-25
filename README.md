
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tinylabels

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![CRAN
status](https://www.r-pkg.org/badges/version/tinylabels)](https://cran.r-project.org/package=tinylabels)
[![R build
status](https://github.com/mariusbarth/tinylabels/workflows/R-CMD-CHECK/badge.svg)](https://github.com/mariusbarth/tinylabels/actions)
[![codecov](https://codecov.io/gh/mariusbarth/tinylabels/branch/main/graph/badge.svg?token=F8WZU5K3XY)](https://codecov.io/gh/mariusbarth/tinylabels)
<!-- badges: end -->

Variable labels are useful in many data-analysis contexts, but R does
not provide variable labels in its base distribution. Several R packages
introduced (sometimes conflicting) implementations (e.g., **Hmisc**,
**haven**, **sjlabelled**), but these packages come with extensive
dependencies. Following the philosophy of a *tiny* dependency graph (the
[tinyverse](http://www.tinyverse.org) philosophy), **tinylabels** set
out to provide functionality for variable labels without depending on
any non-base R packages, while also being as compatible as possible with
other implementations. Another deliberate choice is that **tinylabels**
only implements *variable* labels, not *value* labels.

With a tiny dependency graph and a small code base, we hope that
**tinylabels** may become an excellent choice for package developers, as
well as for data analysts who care about dependencies.

Function overview:

-   Assign variable label: `variable_label()<-`
-   Extract variable label: `variable_label()`
-   Remove labels and `tiny_labelled` class: `unlabel()`
-   Assign labels in a piped workflow: `label_variables()`

## Basic Usage

Assign a variable label to a vector:

``` r
library(tinylabels)

x <- rnorm(6)
variable_label(x) <- "Values randomly drawn from a standard-normal distribution"
x
#> Variable label     : Values randomly drawn from a standard-normal distribution
#> [1]  0.3401170 -2.3342288  0.4908760 -1.3450353 -0.4482711 -0.6235084
```

``` r
# Extract the variable label from a vector (e.g., a numeric vector)
variable_label(x)
#> [1] "Values randomly drawn from a standard-normal distribution"
```

It is also possible to assign variable labels to (all or a subset of)
the columns of a data frame. For instance, consider the built-in data
set `npk`:

``` r
# View original data set ----
str(npk)
#> 'data.frame':    24 obs. of  5 variables:
#>  $ block: Factor w/ 6 levels "1","2","3","4",..: 1 1 1 1 2 2 2 2 3 3 ...
#>  $ N    : Factor w/ 2 levels "0","1": 1 2 1 2 2 2 1 1 1 2 ...
#>  $ P    : Factor w/ 2 levels "0","1": 2 2 1 1 1 2 1 2 2 2 ...
#>  $ K    : Factor w/ 2 levels "0","1": 2 1 1 2 1 2 2 1 1 2 ...
#>  $ yield: num  49.5 62.8 46.8 57 59.8 58.5 55.5 56 62.8 55.8 ...
```

``` r
# Assign labels to the built-in data set 'npk' ----
variable_label(npk) <- c(
  N = "Nitrogen"
  , P = "Phosphate"
  , yield = "Pea yield"
)

# View the altered data set ----
str(npk)
#> 'data.frame':    24 obs. of  5 variables:
#>  $ block: Factor w/ 6 levels "1","2","3","4",..: 1 1 1 1 2 2 2 2 3 3 ...
#>  $ N    : Factor w/ 2 levels "0","1": 1 2 1 2 2 2 1 1 1 2 ...
#>   ..- attr(*, "label")= chr "Nitrogen"
#>  $ P    : Factor w/ 2 levels "0","1": 2 2 1 1 1 2 1 2 2 2 ...
#>   ..- attr(*, "label")= chr "Phosphate"
#>  $ K    : Factor w/ 2 levels "0","1": 2 1 1 2 1 2 2 1 1 2 ...
#>  $ yield: 'tiny_labelled' num  49.5 62.8 46.8 57 59.8 58.5 55.5 56 62.8 55.8 ...
#>   ..- attr(*, "label")= chr "Pea yield"
```

Each labelled column now has an attribute `label` that contains the
respective variable label, and is now of class `tiny_labelled` that
extends the simple vector classes (e.g., logical, integer, double, etc.)

You can access the variable labels by using

``` r
variable_labels(npk)
#> $block
#> NULL
#> 
#> $N
#> [1] "Nitrogen"
#> 
#> $P
#> [1] "Phosphate"
#> 
#> $K
#> NULL
#> 
#> $yield
#> [1] "Pea yield"
```

The return value of `variable_label()` applied to a data frame is a
named list, where each list element corresponds to a column of the data
frame. For columns that do not have a variable label, the corresponding
list element is NULL.

For data frames, the right-hand side of the assignment has to be a
**named** list or vector. When trying to set columns that are not
present in the data frame, a meaningful error message is thrown:

``` r
variable_label(npk) <- c(wrong_column_name = "A supposedly terrific label")
#> Error: While trying to set variable labels, some requested columns could not be found in data.frame:
#> 'wrong_column_name'
```

If you want to remove labels (and the corresponding S3 class) from a
vector *or all columns of a data frame*, you may use function `unlabel`:

``` r
# Return as a simple factor ----
unlabel(npk$N)
#>  [1] 0 1 0 1 1 1 0 0 0 1 1 0 1 1 0 0 1 0 1 0 1 1 0 0
#> Levels: 0 1
# Remove all labels (and class 'tiny_labelled') from all columns ----
npk <- unlabel(npk)
str(npk)
#> 'data.frame':    24 obs. of  5 variables:
#>  $ block: Factor w/ 6 levels "1","2","3","4",..: 1 1 1 1 2 2 2 2 3 3 ...
#>  $ N    : Factor w/ 2 levels "0","1": 1 2 1 2 2 2 1 1 1 2 ...
#>  $ P    : Factor w/ 2 levels "0","1": 2 2 1 1 1 2 1 2 2 2 ...
#>  $ K    : Factor w/ 2 levels "0","1": 2 1 1 2 1 2 2 1 1 2 ...
#>  $ yield: num  49.5 62.8 46.8 57 59.8 58.5 55.5 56 62.8 55.8 ...
```

## Supporting the *tidyverse*

Developing **tinylabels**, we aimed at supporting the *tidyverse* while
also keeping the package’s dependency graph as tiny as possible. For
this reason, *tidyverse* packages are not imported. However, if you have
already installed the **vctrs** package on your computer, **tinylabels**
will dynamically register methods for `vctrs::vec_ptype2()` and
`vctrs::vec_cast()` that are necessary to play well with the
*tidyverse*. With these methods, the *tidyverse*’s data manipulation
functions become rather explicit about how they handle labels.

For instance, If you try to combine two vectors that have different
labels, only the label of the first vector is retained – but in
addition, you will receive a meaningful warning message. Consider, for
instance, `dplyr::bind_rows()` applied to two data frames with
non-matching variable labels:

``` r
data_1 <- data_2 <- data.frame(
  x = rnorm(10)
  , y = rnorm(10)
)

variable_label(data_1) <- c(x = "Label for x", y = "Label for y")
variable_label(data_2) <- c(x = "Label for x", y = "Another label for y")
```

``` r
library(dplyr)
#> 
#> Attache Paket: 'dplyr'
#> Die folgenden Objekte sind maskiert von 'package:stats':
#> 
#>     filter, lag
#> Die folgenden Objekte sind maskiert von 'package:base':
#> 
#>     intersect, setdiff, setequal, union
combined_data <- bind_rows(data_1, data_2)
#> Warning in vec_ptype2.tiny_labelled.tiny_labelled(x = x, y = y, x_arg = x_arg, :
#> While combining two labelled vectors, variable label 'Another label for y' was
#> dropped and variable label 'Label for y' was retained.
variable_label(combined_data)
#> $x
#> [1] "Label for x"
#> 
#> $y
#> [1] "Label for y"
```

To further support *tidyverse*-ish code, we also wrote the function
`label_variables()` that is intended to be used in conjunction with the
*tidyverse*’s pipe operator:

``` r
test <- npk %>%
  group_by(N, P) %>%
  summarize(yield = mean(yield), .groups = "keep") %>%
  label_variables(N = "Nitrogen", P = "Phosphate", yield = "Average yield")

variable_labels(test)
#> $N
#> [1] "Nitrogen"
#> 
#> $P
#> [1] "Phosphate"
#> 
#> $yield
#> [1] "Average yield"
```
