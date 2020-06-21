test_that("get_pr works", {
    p <- get_pullrequests("llrs/BioCor")
    expect_equal(ncol(p), 23L)
    expect_equal(colnames(p),
                 c("assignees", "assignee", "label", "state", "locked", "milestone",
                   "title", "created", "updated", "closed", "merged", "requested_reviewer",
                   "draft", "association", "merger", "maintainer_can_modify", "n_commits",
                   "additions", "deletions", "changed_files", "text", "id", "submitter"
                 ))
})
test_that("get_pr works", {
    p <- get_pullrequests("llrs/BioCor", 27)
    expect_equal(ncol(p), 23)
    expect_equal(nrow(p), 1L)
    expect_equal(colnames(p),
                 c("assignees", "assignee", "label", "state", "locked", "milestone",
                   "title", "created", "updated", "closed", "merged", "requested_reviewer",
                   "draft", "association", "merger", "maintainer_can_modify", "n_commits",
                   "additions", "deletions", "changed_files", "text", "id", "submitter"
                 ))
})

test_that("get_pr works", {
    expect_null(get_pullrequests("llrs/eigen"))
})
