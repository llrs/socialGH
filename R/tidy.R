available <- function(x){
  if (is.null(x)) {
    NA
  } else {
    x
  }
}

user <- function(x, name = "user") {
  if (is.null(x$login) || is.null(x)) {
    return(NA)
  }
  l <- list(user = x$login, type = x$type, admin = x$site_admin)
  names(l)[1] <- name
  l
}

comment <- function(x) {
  l <- list(text = x$body,
            created = x$created_at,
            updated = x$updated_at,
            association = x$author_association,
            id = url2id(x$issue_url),
            commenter = user(x$user))
  lapply(l, available)
}

labels <- function(y) {
  s <- vapply(y, getElement, name = "name", character(1L))
  available(s)
}

url2id <- function(x) {
  strsplit(x, "/", fixed = TRUE)[[1]][8]
}

milestones <- function(x) {
  s <- vapply(x, getElement, name = "milestone", character(1L))
  available(s)
}

assignees <- function(x) {
  l <- list(n_comments = x$comments, assigned = x$created_at)
  u <- user(x, "assigner")
  l2 <- c(l, u)
  lapply(l2, available)
}

issue <- function(x) {

  l <- list(assignees = simplify(x$assignees, assignees),
            assignee = simplify(x$assignee, user),
            label = labels(x$labels),
            state = x$state,
            locked = x$locked,
            milestone = milestones(x$milestone),
            n_comments = x$comments,
            title = x$title,
            created = x$created_at,
            updated = x$updated_at,
            association = x$author_association,
            text = x$body,
            id = x$number,
            closer = user(x$closed_by),
            poster = user(x$user))
  lapply(l, available)
}

timeline <- function(x) {

  title <- NA
  label <- NA
  if (x$event == "renamed") {
    title <- x$rename$to
  } else if (x$event == "labeled") {
    label <- x$label$name
  } else if (x$event == "unlabeled") {
    label <- x$label$name
  }
  l <- list(assignees = simplify(x$assignees, assignees),
            assignee = simplify(x$assignee, user),
            label = label,
            state = x$state,
            locked = x$locked,
            milestone = milestones(x$milestone),
            event = x$event,
            actor = user(x$actor),
            title = title,
            created = x$created_at,
            updated = x$updated_at,
            association = x$author_association,
            text = x$body,
            id = x$number,
            closer = user(x$closed_by))
  lapply(l, available)
}

event <- function(x) {
  i <- issue(x$issue)
  l <- list(event = x$event, date = x$created_at, triggerer =  user(x$actor),
            action = ifelse(exists("rename", x), list(x$rename), list()))
  l2 <- c(i, l)
  lapply(l2, available)
}

pull_request <- function(x) {

  l <- list(assignees = simplify(x$assignees, assignees),
            assignee = simplify(x$assignee, user),
            label = labels(x$labels),
            state = x$state,
            locked = x$locked,
            milestone = milestones(x$milestone),
            title = x$title,
            created = x$created_at,
            updated = x$updated_at,
            closed = x$closed_at,
            merged = x$merged_at,
            requested_reviewer = simplify(x$requested_reviewer, user),
            draft = x$draft,
            association = x$author_association,
            merger = user(x$merged_by),
            maintainer_can_modify = x$maintainer_can_modify,
            n_commits = x$commits,
            additions = x$additions,
            deletions = x$deletions,
            changed_files = x$changed_files,
            text = x$body,
            id = x$number,
            submitter = user(x$user))
  lapply(l, available)
}
