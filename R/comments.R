
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
get_comments <- function(repository, issue) {
    comments <- gh("/repos/:repo/issues/:issue/comments",
                   repo = repository, issue = issue, .limit = Inf)
    df <- apply_class(comments, "comment")
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df$admin <- as.logical(df$admin)
    df
}


#' @describeIn get_comments The same but for all comments of a repository.
get_all_comments <- function(repository) {
    comments <- gh("/repos/:repo/issues/comments", .limit = Inf, repo = repository)
    df <- apply_class(comments, "comment")
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df$admin <- as.logical(df$admin)
    df
}
