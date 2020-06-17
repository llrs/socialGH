#' Retrieve events of an issue
#'
#'
#' @param repository A character of repository "owner/repo".
#' @param issue The number of the issue
#' @seealso [get_issue()]
#' @export
#' @examples
#' get_events("llrs/blogR", 2)
#' get_events("llrs/blogR")
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
    df$date <- convert_dates(df$date)
    df$admin <- as.logical(df$admin)
    if (!is.null(issue)) {
        df$id <- as.numeric(issue)
    }
    df
}
