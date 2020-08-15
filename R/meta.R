
#' Check API
#'
#' Check if the API is available and how many calls can you can use.
#' @references [Help page](https://docs.github.com/en/rest/reference/rate-limit#understanding-your-rate-limit-status)
#' @export
#' @examples
#' check_api()
check_api <- function() {
    v <- gh("/rate_limit")
    s <- simplify2array(v$resources)
    s <- as.data.frame(s, stringsAsFactors = FALSE)
    s$rate <- rownames(s)
    rownames(s) <- NULL
    s[1:2, ]
}
