
<!-- README.md is generated from README.Rmd. Please edit that file -->

# socialGH

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/llrs/socialGH/branch/master/graph/badge.svg)](https://codecov.io/gh/llrs/socialGH?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-CMD-check](https://github.com/llrs/socialGH/workflows/R-CMD-check/badge.svg)](https://github.com/llrs/socialGH/actions)
<!-- badges: end -->

The goal of socialGH is to help extracting information from social
relations on repositories on GitHub.

## Installation

You can install the released version of socialGH from GitHub with:

``` r
remotes::install_github("llrs/socialGH")
```

## Example

This is a basic example which shows you how to retrieve the issues at
the current state::

``` r
library(socialGH)
```

You can download issues (does not include comments made on them), pull
requests (PR), events, and comments on issues and PR.

``` r
get_issues("llrs/socialGH")
#>                   assignees          assignee                 label  state
#> 1                        NA                NA                       closed
#> 2 NA, NA, llrs, User, FALSE llrs, User, FALSE todo :spiral_notepad: closed
#> 3 NA, NA, llrs, User, FALSE llrs, User, FALSE todo :spiral_notepad: closed
#>   locked milestone n_comments                                     title
#> 1  FALSE                    0             Extract who closes the issues
#> 2  FALSE                    0                     spiral_notepad:  open
#> 3  FALSE                    1 Replace NULL to NA when returning results
#>               created             updated association
#> 1 2020-08-01 07:53:02 2020-08-03 08:27:26       OWNER
#> 2 2020-07-12 09:07:21 2021-04-22 08:56:00        NONE
#> 3 2020-07-11 12:21:51 2020-08-01 07:40:22       OWNER
#>                                                                                                                                                                                                                                                                                                                     text
#> 1                                                                                                                                                                                                                                           Currently when the event of closed is tidied, it doesn't record who did it. 
#> 2 https://github.com/llrs/socialGH/blob/a5e48edf27313b50ec607020dfe2f16dfe14ff6d/README.md#L39-L44\n\n---\n\n###### This issue was generated by [todo](https://todo.jasonet.co) based on a `todo` comment in a5e48edf27313b50ec607020dfe2f16dfe14ff6d. It&#x27;s been assigned to @llrs because they committed the code.
#> 3                                                                                                                                                                  Change the default that it is returning to make it easier to filter, mutate, etc\r\nCurrently it is difficult as it need to be unpacked each time... 
#>   id closer                poster
#> 1  3     NA     llrs, User, FALSE
#> 2  2     NA todo[bot], Bot, FALSE
#> 3  1     NA     llrs, User, FALSE
```
