test_that("single issues works", {
    skip_if_offline()
    i2 <- get_issues("llrs/blogR", 2)
    expect_s3_class(i2, "data.frame")
    expect_equal(nrow(i2), 1)
    expect_equal(colnames(i2),
                 c("assignees", "assignee", "label", "state", "locked", "milestone",
                   "n_comments", "title", "created", "updated", "association", "text",
                   "id", "closer", "poster"))
})

test_that("incorrect repo", {
    skip_if_offline()
    expect_error(get_issues("llrs/blogRs", 2))
})

test_that("multiple issues works", {
    skip_if_offline()
    i <- get_issues("llrs/eigen")
    expect_null(i)
})

test_that("multiple issues work", {
    skip_if_offline()
    i2 <- get_issues("llrs/blogR")
    expect_s3_class(i2, "data.frame")
    expect_equal(colnames(i2),
                 c("assignees", "assignee", "label", "state", "locked", "milestone",
                   "n_comments", "title", "created", "updated", "association", "text",
                   "id", "closer", "poster"))
})
