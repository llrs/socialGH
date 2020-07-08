#' Retrieve only pull requests.
#'
#' Retrieve only pull requests from a repository.
#' @inheritParams get_issues
#' @return A `data.frame` with the information of the pr
#' @seealso [get_comments()] As they are also listed there.
#' @export
#' @examples
#' get_pullrequests("llrs/BioCor", 27)
#' get_pullrequests("llrs/BioCor")
get_pullrequests <- function(repository, issue = NULL) {
    if (is.null(issue)) {
        # https://docs.github.com/en/rest/reference/pulls#list-pull-requests
        pr <- gh("/repos/:repo/pulls", repo = repository,
                 .accept = accept[3], .send_headers = header,
                 state = "all")}
    else {
        # https://docs.github.com/en/rest/reference/pulls#get-a-pull-request
        pr <- gh("/repos/:repo/pulls/:issue", repo = repository,
                 .accept = accept, .send_headers = header[3], issue = issue,
                 state = "all")
    }

    pull_requests <- simplify(pr, pull_request)
    if (is.null(pull_requests)) {
        return(pull_requests)
    }

    unlist_vec <- c("state", "id", "text", "title",
                    "association", "locked", "created", "updated", "closed",
                    "merged", "draft", "maintainer_can_modify", "n_commits",
                    "additions", "deletions", "changed_files")
    df <- simplify_df(pull_requests, unlist_vec)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df$closed <- convert_dates(df$closed)
    df$merged <- convert_dates(df$merged)
    df
}
