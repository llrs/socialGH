test_that("user works", {
  x <- list(login = "a", type = "b", site_admin = "c")
  expect_true(is.list(user(x)))
  o <- user(x)
  expect_named(o, c("user", "type", "admin"))
 x <- list(af = "a")
 expect_true(is.na(user(x)))
})
