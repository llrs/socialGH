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
    if (is.named(x)) {
        class(x) <- c(class, class(x))
        l <- tidy(x)
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


simplify <- function(x, FUN) {
    if (is.null(x) | length(x) == 0) {
        return(NULL)
    }
    FUN <- match.fun(FUN = FUN)
    if (is.named(x)) {
        l <- FUN(x)
    } else{
        l <- lapply(x, FUN = FUN)
    }
    m <- simplify2array(l, higher = FALSE)
    as.data.frame(t(m), fix.empty.names = FALSE,
                  stringsAsFactors = FALSE, optional = FALSE)
}

is.named <- function(x) {
    !is.null(names(x))
}

simplify_df <- function(df, columns) {
    keep <- !check_null(df[columns])
    df[columns][keep] <- lapply(df[columns][keep], unlist,
                          recursive = FALSE, use.names = FALSE)
    df
}

check_null <- function(df) {
    vapply(df, function(x){is.null(x[[1]])}, logical(1))
}
