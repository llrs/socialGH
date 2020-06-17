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

}
