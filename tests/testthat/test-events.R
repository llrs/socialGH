test_that("get_events works", {
    skip_if_offline()
    expect_error(get_events("llrs/blogR", 1), NA)
})

test_that("multiple get_events works", {
    skip_if_offline()
    expect_error(ge <- get_events("llrs/blogR"), NA)
    expect_equal(ncol(ge), 18)
    expect_equal(colnames(ge),
                 c("assignees", "assignee", "label", "state", "locked", "milestone",
                   "n_comments", "title", "created", "updated", "association", "text",
                   "id", "closer", "poster", "event", "date", "triggerer", "action"))
})
