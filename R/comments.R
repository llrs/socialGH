
#' Retrieve comments
#'
#' Tidy comments of a repository
#' @inheritParams get_events
#'
#' @return A `data.frame`
#' @export
#'
#' @examples
#' get_comments("llrs/blogR", 10)
get_comments <- function(repository, issue = NULL) {
    if (is.null(issue)) {
        comments <- gh("/repos/:repo/issues/:issue/comments",
                       repo = repository, issue = issue, .limit = Inf,
                       .send_headers = header)}
    else {
        comments <- gh("/repos/:repo/issues/comments", .limit = Inf,
                       repo = repository,
                       .send_headers = header)
    }
    df <- simplify(comments, comment)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df$admin <- as.logical(df$admin)
    df$id <- as.numeric(df$id)
    df
}

