
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bark: Bayesian Additive Regression Kernels

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/merliseclyde/bark.svg?branch=master)](https://travis-ci.com/merliseclyde/bark)
[![Codecov test
coverage](https://codecov.io/gh/merliseclyde/bark/branch/master/graph/badge.svg)](https://codecov.io/gh/merliseclyde/bark?branch=master)
<!-- badges: end -->

The bark package implements estimation for a Bayesian nonparametric
regression model represented as a sum of multivariate Gaussian kernels
as a flexible model to capture nonlinearities, interactions and feature
selection.

## Installation

You can install the released version of bark from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("bark")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("merliseclyde/bark")
```

## Example

``` r
library(bark)
traindata <- sim_Friedman2(200, sd=125)
testdata <- sim_Friedman2(1000, sd=0)
fit.bark.d <- bark(traindata$x, 
                   traindata$y, 
                   testdata$x, 
                   classification=FALSE, 
                   type="sd",
                   printevery = 10^10)
#> [1] "Starting BARK-sd for this regression problem"

mean((fit.bark.d$yhat.test.mean-testdata$y)^2)
#> [1] 2667.793
```

bark is similar to SVM, however it allows different kernel smoothing
parameters for every dimension of the inputs \(x\) as well as selection
of inputs by allowing the kernel smoothing parameters to be zero.

The plot below shows posterior draws of the \(\lambda\) for the
simulated data.

``` r
boxplot(as.data.frame(fit.bark.d$theta.lambda))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

The posterior distribution for \(\lambda_1\) and \(\lambda_4\) are
concentrated at zero, which leads to \(x_1\) and \(x_2\) dropping from
the mean function.
