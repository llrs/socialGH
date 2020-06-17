#' Get issues from a repository
#'
#' Download all the opening issues of a repository
#'
#' @param repository A character of form "user/repo" pointing to an existing
#' repository.
#' @return A data.frame with the information available about the issue.
#' @seealso [get_comments()]
#' @examples
#' issues <- get_issues("llrs/blogR")
#' @importFrom gh gh
get_issues <- function(repository) {
    issues <- gh("/repos/:repo/issues", repo = repository, .limit = Inf)
    issues <- apply_class(issues, "issue")
}
