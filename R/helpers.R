header <- c("https://github.com/r-lib/gh", "https://github.com/llrs/socialGH")

accept <- c("application/vnd.github.v3+json", # default one
            "application/vnd.github.starfox-preview+json",  #issue-events
            "application/vnd.github.sailor-v-preview+json", # locked events, PR
            "application/vnd.github.mockingbird-preview+json"    # timeline
            )
convert_dates <- function(x) {
    as.POSIXct(strptime(x, "%Y-%m-%dT%H:%M:%SZ"))
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
    for (col in columns[keep]) {
        col_val <- df[[col]]
        df[[col]] <- NA
        df[[col]][lengths(col_val) != 0] <- unlist(col_val, FALSE, FALSE)
    }

    df
}

check_null <- function(df) {
    vapply(df, function(x){is.null(x[[1]])}, logical(1))
}
