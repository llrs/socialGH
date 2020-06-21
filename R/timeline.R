
#' Retrieve timeline events
#'
#' @inheritParams get_issues
#' @return A `data.frame` when finalized.
#' @export
#' @examples
#' get_timelines("Bioconductor/Contributions", 400)
get_timelines <- function(repository, issue = NULL) {

    if (is.null(issue)) {
        timeline <- gh("/repos/:repo/issues", repo = repository, .limit = Inf,
                     state = "all",  .accept = accept[4],
                     .send_headers = header)
    } else {
        timeline <- gh("/repos/:repo/issues/:issue/timeline", repo = repository,
                     .limit = Inf, issue = issue,
                     state = "all",  .accept = accept[4],
                     .send_headers = header)
    }
    timeline
}
