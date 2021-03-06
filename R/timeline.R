
#' Retrieve timeline events for each  issue
#'
#' The API returns the same output for events of a repo as for an issue
#'
#' @inheritParams get_issues
#' @return A `data.frame` when finalized.
#' @export
#' @examples
#' (gt <- get_timelines("Bioconductor/Contributions", 400))
get_timelines <- function(repository, issue = NULL) {
    if (is.null(issue)) {
        # https://docs.github.com/en/rest/reference/issues#events
        timelines <- gh("/repos/:repo/issues/events",
                         repo = repository, .limit = Inf, .accept = accept[1],
                         .send_headers = header)
    } else {
        warning("This is under preview and may fail.", call. = FALSE)
        # https://docs.github.com/en/rest/reference/issues#timeline
        timelines <- gh("/repos/:repo/issues/:issue/timeline", repo = repository,
                     .limit = Inf, issue = issue,  .accept = accept[4],
                     .send_headers = header)
    }

    df <- simplify(timelines, timeline)
    if (is.null(df)) {
        return(df)
    }
    unlist_vec <- c("state", "id", "text", "title", "association", "locked",
                    "created", "updated")
    df <- simplify_df(df, unlist_vec)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    if (!is.null(issue)) {
        df$id <- issue
    }
    df
}
