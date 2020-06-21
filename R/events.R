#' Retrieve events
#'
#' Retrieve events from a repository or issue.
#' @param repository A character of repository "owner/repo".
#' @param issue The number of the issue
#' @return A `data.frame` with the information available for the event and the
#' issue it is linked.
#' @seealso [get_issues()]
#' @references [GitHub API](https://developer.github.com/v3/issues/events/#list-issue-events)
#' @export
#' @examples
#' get_events("llrs/blogR", 2)
#' ge <- get_events("llrs/blogR")
#' ge[1:10, c("event", "date", "id", "assignee", "assignees")]
get_events <- function(repository, issue = NULL) {

    if (is.null(issue)) {
        events <- gh("/repos/:repo/issues/events",
                     repo = repository, .limit = Inf,
                     .send_headers = header,
                     .accept = accept)
    } else {
        events <- gh("/repos/:repo/issues/:issue/events",
                     repo = repository, issue = issue, .limit = Inf,
                     .send_headers = header,
                     .accept = accept)
    }

    df <- simplify(events, event)
    unlist_vec <- c("state", "id", "n_comments", "text", "title",
                    "association", "locked", "created", "updated")
    df <- simplify_df(df, unlist_vec)
    df$date <- convert_dates(df$date)
    if (!is.null(issue)) {
        df$id <- as.numeric(issue)
    }
    df
}
