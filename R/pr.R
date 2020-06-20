#' Title
#'
#' @inheritParams get_issues
#'
#' @return
#' @export
#'
#' @examples
#' get_pr("llrs/BioCor")
get_pr <- function(repository) {

    pr <- gh("/repos/:repo/pulls", repo = repository,
             .accept = accept, .send_headers = header,
             state = "all")
    pull_requests <- simplify(pr, pull_request)
    if (is.null(pull_requests)) {
        return(pull_requests)
    }

    unlist_vec <- c("state", "id", "text", "title",
                    "association", "locked", "created", "updated", "closed",
                    "merged", "draft")
    df <- simplify_df(pull_requests, unlist_vec)
    df$created <- convert_dates(df$created)
    df$updated <- convert_dates(df$updated)
    df$closed <- convert_dates(df$closed)
    df$merged <- convert_dates(df$merged)
    df
}
