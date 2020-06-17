#' Get issues from a repository
#'
#' Download all the opening issues of a repository
#'
#' @param repository A character of form "user/repo" pointing to an existing
#' repository.
#' @return A data.frame with the information available about the issue.
#' @seealso [get_comments()]
#' @export
#' @examples
#' issues <- get_issues("llrs/blogR")
#' @importFrom gh gh
get_issues <- function(repository) {
    issues <- gh("/repos/:repo/issues", repo = repository, .limit = Inf,
                 state = "all",
                 .send_headers = header)
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

get_issue <- function(repository, issue) {
    issues <- gh("/repos/:repo/issues/:issue", repo = repository,
                 .limit = Inf, issue = issue,
                 state = "all",
                 .send_headers = header)
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

get_full_issues <- function(repository, issue) {
    browser()
    issue <- get_issue(repository, issue)
    comments <- get_comments(repository, issue)
    comments$type <- "comment"
    events <- get_events(repository, issue)
    events$type <- "event"

}
