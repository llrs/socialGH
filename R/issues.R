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
#' get_issue("llrs/blogR", 11)
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

    issues <- apply_class(issues, "issue")
    issues$state <- unlist(issues$state, FALSE, FALSE)
    issues$id <- unlist(issues$id, FALSE, FALSE)
    issues$n_comments <- unlist(issues$n_comments, FALSE, FALSE)
    issues$text <- unlist(issues$text, FALSE, FALSE)
    issues$title <- unlist(issues$title, FALSE, FALSE)
    issues$created <- convert_dates(unlist(issues$created, FALSE, FALSE))
    issues$updated <- convert_dates(unlist(issues$updated, FALSE, FALSE))
    issues
}


get_full_repo <- function(repository, issue = NULL) {
    events <- get_events(repository, issue)
    get_comments(repository, events$id)
}
