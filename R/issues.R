#' Retrieve issues
#'
#' Download all the opening issues of a repository or a single issue by id.
#'
#' [get_issues()] does not retrieve comments, or actions done on the issues.
#' Just the current state of issues.
#'
#' @param repository A character of form "user/repo" pointing to an existing
#' repository.
#' @return A `data.frame` with the information available about the issue. Some
#' columns are lists, including those referring to users.
#' @seealso [get_comments()]
#' @export
#' @examples
#' issues <- get_issues("llrs/blogR")
#' get_issues("llrs/blogR", 11)
#' @importFrom gh gh
get_issues <- function(repository, issue = NULL) {

    if (is.null(issue)) {
        issues <- gh("/repos/:repo/issues", repo = repository, .limit = Inf,
                     state = "all", .accept = accept[2],
                     .send_headers = header)
    } else {
        issues <- gh("/repos/:repo/issues/:issue", repo = repository,
                     .limit = Inf, issue = issue, .accept = accept[2],
                     state = "all",
                     .send_headers = header)
    }

    df <- simplify(issues, issue)
    if (is.null(df)) {
        return(df)
    }
    unlist_vec <- c("state", "id", "n_comments", "text", "title",
                    "association", "locked", "created", "updated")
    df <- simplify_df(df, unlist_vec)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df
}


get_full_repo <- function(repository, issue = NULL) {
    events <- get_events(repository, issue)
    get_comments(repository, events$id)
}
