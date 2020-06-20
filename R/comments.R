
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
        comments <- gh("/repos/:repo/issues/comments", .limit = Inf,
                       repo = repository,
                       .send_headers = header)
    } else {
        comments <- gh("/repos/:repo/issues/:issue/comments",
                       repo = repository, issue = issue, .limit = Inf,
                       .send_headers = header)
    }

    # No issues
    if (length(comments) == 0) {
        return(NULL)
    }

    df <- simplify(comments, comment)
    unlist_vec <- c("text", "association")
    df[unlist_vec] <- lapply(df[unlist_vec], unlist,
                             use.names = FALSE, recursive = FALSE)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df$id <- as.numeric(df$id)
    df
}

