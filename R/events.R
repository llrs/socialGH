#' Retrieve events of an issue
#'
#'
#' @param repository A character of repository "owner/repo".
#' @param issue The number of the issue
#' @seealso [get_issue()]
#' @examples
#' get_events("llrs/blogR", 2)
get_events <- function(repository, issue) {
    events <- gh("/repos/:repo/issues/:issue/events",
                 repo = repository, issue = issue, .limit = Inf, per_page = 100)
    df <- apply_class(events, "events")
    df$date <- convert_dates(df$date)
    df$admin <- as.logical(df$admin)
    df
}
