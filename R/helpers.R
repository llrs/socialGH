header <- c("https://github.com/r-lib/gh", "https://github.com/llrs/socialGH")

accept <- c("application/vnd.github.v3+json", # default one
            "application/vnd.github.starfox-preview+json",  #issue-events
            "application/vnd.github.sailor-v-preview+json" # locked events, PR
            )
convert_dates <- function(x) {
    as.POSIXct(strptime(x, "%Y-%m-%dT%H:%M:%SZ"))
}

apply_class <- function(x, class) {
    if (is.null(x) | length(x) == 0) {
        return(NULL)
    }
    if (length(x) == 1) {
        class(x[[1]]) <- c(class, class(x[[1]]))
        l <- tidy(x[[1]])
    } else{
        l <- lapply(x, function(x) {
            class(x) <- c(class, class(x))
            tidy(x)
        })
    }
    m <- simplify2array(l, higher = FALSE)
    as.data.frame(t(m), fix.empty.names = FALSE,
                        stringsAsFactors = FALSE, optional = FALSE)
}

is.named <- function(x) {
    !is.null(names(x))
}
