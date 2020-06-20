test_that("get_pr works", {
    p <- get_pr("llrs/BioCor")
    expect_equal(ncol(p), 17L)
    expect_equal(colnames(p),
                  c("assignees", "assignee", "label", "state", "locked", "milestone",
                    "title", "created", "updated", "closed", "merged", "requested_reviewer",
                    "draft", "association", "text", "id", "submitter"))
})
test_that("get_pr works", {
    p <- get_pr("llrs/BioCor", 27)
    expect_equal(ncol(p), 17L)
    expect_equal(nrow(p), 1L)
    expect_equal(colnames(p),
                  c("assignees", "assignee", "label", "state", "locked", "milestone",
                    "title", "created", "updated", "closed", "merged", "requested_reviewer",
                    "draft", "association", "text", "id", "submitter"))
})

test_that("get_pr works", {
    expect_null(get_pr("llrs/eigen"))
})
