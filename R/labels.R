#' Retrieve labels
#'
#' Download all the labels of a repository or a single issue by id.
#'
#' @inheritParams get_issues
#' @return A `data.frame` with the information available about the issue.
#' @seealso [get_comments()]
#' @export
#' @examples
#' issues <- get_labels("llrs/blogR")
#' get_labels("llrs/blogR", 11)
get_labels <- function(repository, issue = NULL) {

    if (is.null(issue)) {
        labels <- gh("/repos/:repo/labels", repo = repository, .limit = Inf,
                     state = "all", .accept = accept[4],
                     .send_headers = header)
    } else {
        labels <- gh("/repos/:repo/issues/:issue/labels", repo = repository,
                     .limit = Inf, issue = issue,
                     state = "all", .accept = accept[4],
                     .send_headers = header)
    }
    # browser()
    label <- labels(labels)
    if (is.null(label)) {
        return(label)
    }
    if (!is.null(issue)) {
        return(data.frame(label = label, id = rep(issue, length(label))))
    }
    data.frame(label = label)
}
