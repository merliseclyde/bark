test_that("Confirm .Call getDesignCall Agrees with Old", {
  n = 100; d=2
  p = n
  train = sim_circle(n, d)
  better = createDesignCall(train$x, center=train$x,
                            L = rep(.5, d),
                            intercept=rep(1L,p))
  good =  createDesign(train$x, train$x,
                       L = rep(.5, d),
                       intercept = rep(1L,p),
                       n=100, p=100, d=2)
  expect_equal(dim(good), dim(better))
  expect_equal(good, better)
})

## github issue #1 for type checking
test_that("Using .Call getDesignCall Check Types", {
  n = 100; d=2
  p = n
  train = sim_circle(n, d) #
  expect_no_error(createDesignCall(train$x,
                                   center=train$x,
                                   L = rep(.5, d),
                                   intercept=rep(1,p)))
                  
  expect_no_error(createDesignCall(train$x,
                                   center=train$x,
                                   L = rep(1L, d),
                                   intercept=rep(1L,p)))
  
  expect_true(is.matrix(createDesignCall(train$x,
                                         center=train$x,
                                         L = rep(.5, d),
                                         intercept=rep(1L,p))))

})

test_that("Using .Call getDesignCall Check dimensions", {
  n = 100; d=2
  p = n
  train = sim_circle(n, d) #
  expect_error(createDesignCall(train$x,
                                center=train$x[5,1],
                                L = rep(.5, p),
                                intercept=rep(1,d)))
  expect_no_error(createDesignCall(train$x,
                                center=train$x,
                                L = rep(.5, d),
                                intercept=rep(1,p)))
})

test_that(".Call and .C", {
  n = 100; d=2
  p = n
  train = sim_circle(n, d) #
  expect_equivalent(createDesignCall(train$x,
                                     center=train$x,
                                     L = rep(.5, d),
                                     intercept=rep(1L,p)),
                    createDesign(train$x,
                                 center=train$x,
                                 L = rep(.5, d),
                                 intercept=rep(1L,p),
                                 n,
                                 p,
                                 d))
  
})