
#' Retrieve timeline events
#'
#' @inheritParams get_issues
#' @return A `data.frame` when finalized.
#' @export
#' @examples
#' get_timelines("Bioconductor/Contributions", 400)
get_timelines <- function(repository, issue = NULL) {

    if (is.null(issue)) {
        timelines <- gh("/repos/:repo/issues", repo = repository, .limit = Inf,
                     state = "all",  .accept = accept[4],
                     .send_headers = header)
    } else {
        timelines <- gh("/repos/:repo/issues/:issue/timeline", repo = repository,
                     .limit = Inf, issue = issue,
                     state = "all",  .accept = accept[4],
                     .send_headers = header)
    }
    df <- simplify(timelines, issue)
    if (is.null(df)) {
        return(df)
    }
    unlist_vec <- c("state", "id", "n_comments", "text", "title",
                    "association", "locked", "created", "updated")
    df <- simplify_df(df, unlist_vec)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df
}
