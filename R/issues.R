#' Get issues from a repository
#'
#' Download all the opening issues of a repository.
#'
#' [get_issues()] does not retrieve comments, or actions done on the issues.
#' Just the current state of it
#'
#' @param repository A character of form "user/repo" pointing to an existing
#' repository.
#' @return A data.frame with the information available about the issue.
#' @seealso [get_comments()]
#' @export
#' @examples
#' issues <- get_issues("llrs/blogR")
#' get_issues("llrs/blogR", 11)
#' @importFrom gh gh
get_issues <- function(repository, issue = NULL) {

    if (is.null(issue)) {
        issues <- gh("/repos/:repo/issues", repo = repository, .limit = Inf,
                     state = "all",
                     .send_headers = header)
    } else {
        issues <- gh("/repos/:repo/issues/:issue", repo = repository,
                     .limit = Inf, issue = issue,
                     state = "all",
                     .send_headers = header)
    }

    df <- simplify(issues, issue)
    unlist_vec <- c("state", "id", "n_comments", "text", "title",
                    "association", "locked", "created", "updated", "poster",
                    "type", "admin")
    df[unlist_vec] <- lapply(df[unlist_vec], unlist,
                                 use.names = FALSE, recursive = FALSE)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df
}


get_full_repo <- function(repository, issue = NULL) {
    events <- get_events(repository, issue)
    get_comments(repository, events$id)
}
