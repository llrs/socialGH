
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
#>                   assignees          assignee                 label state
#> 1 NA, NA, llrs, User, FALSE llrs, User, FALSE todo :spiral_notepad:  open
#>   locked milestone n_comments                                     title
#> 1  FALSE                    0 Replace NULL to NA when returning results
#>               created             updated association
#> 1 2020-07-11 12:21:51 2020-07-11 12:21:51       OWNER
#>                                                                                                                                                    text
#> 1 Change the default that it is returning to make it easier to filter, mutate, etc\r\nCurrently it is difficult as it need to be unpacked each time... 
#>   id closer            poster
#> 1  1     NA llrs, User, FALSE
```
