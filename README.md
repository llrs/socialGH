
<!-- README.md is generated from README.Rmd. Please edit that file -->

# socialGH

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/llrs/socialGH/branch/master/graph/badge.svg)](https://codecov.io/gh/llrs/socialGH?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of socialGH is to help extracting information from social
relations on repositories on GitHub.

## Installation

You can install the released version of socialGH from GitHub with:

``` r
remotes::install_github("llrs/socialGH")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(socialGH)
```

You can download issues (does not include comments made on them), pull
requests (PR), events, and comments on issues and PR.

``` r
get_issues("llrs/socialGH")
#> $created
#> POSIXct of length 0
#> 
#> $updated
#> POSIXct of length 0
```
