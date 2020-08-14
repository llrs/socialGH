test_that("get_timelines works", {
    skip_if_offline()
    expect_warning(gt <- get_timelines("llrs/blogR", 1), "under preview")
    expect_s3_class(gt, "data.frame")
})
