test_that("multiple get_comments works", {
    skip_if_offline()
    expect_null(get_comments("llrs/eigen"))
    expect_s3_class(get_comments("llrs/blogR"), "data.frame")
})

test_that("get_comments works", {
    skip_if_offline()
    expect_error(get_comments("llrs/eigen", 1))
    expect_error(gc <- get_comments("llrs/BioCor", 1), NA)
    expect_equal(colnames(gc),
                 c("text", "created", "updated", "association", "id", "commenter"))

})
