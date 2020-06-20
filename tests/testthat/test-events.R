test_that("get_events works", {
    skip_if_offline()
    expect_error(get_events("llrs/blogR", 1), NA)
})
