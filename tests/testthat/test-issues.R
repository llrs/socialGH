test_that("issues works", {
    testthat::skip_if_offline()
    expect_equal(2 * 2, 4)
})
