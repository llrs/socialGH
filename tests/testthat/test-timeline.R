test_that("get_timelines works", {
    skip_if_offline()
    expect_error(gt <- get_timelines("llrs/blogR", 1), NA)
    expect_s3_class(gt, "data.frame")
})
