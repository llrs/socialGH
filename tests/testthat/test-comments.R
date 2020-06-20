test_that("get_comments works", {
    skip_if_offline()
    expect_null(get_comments("llrs/eigen"))
    expect_s3_class(get_comments("llrs/blogR"), "data.frame")
})
