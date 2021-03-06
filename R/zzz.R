


#' Last Modified late
#'
#' Returns the latest date for when a file was touched in a project
#' @param path Path to project folder
#'
last_modification_date <- function(path = ".") {
  dir_list <- fs::dir_info(path)
  # Remove Readme.md and readme.rmd from the search because my 
  # rationale is that users will modify these files far more often
  # and more frequently than the code.
  pos <- grep("readme",
            dir_list$path,
            ignore.case = TRUE)
  if(length(pos) > 0 ) {
dir_list <- dir_list[-pos, ]
}
  sorted_dir_list <-
    dir_list[order(dir_list$modification_time, decreasing = TRUE), ]
  last_mod <- sorted_dir_list[1, ]$modification_time
  as.Date(last_mod)
}

#' @noRd
r_version_lookup <- function(date = NULL) {
  if (!is.null(date)) {
    date <- as.Date(date)
    # df <- holepunch:::r_version_table # This works
    df <- r_version_table

    if (date < df[1, 2]) {
      stop("Canot find R version for this date", call. = FALSE)
    }

    # This below is ugly and makes me unhappy
    # Don't want to use dplyr in this package so the ugly apply it is for now. Sadnesss.
    df$dt <- date
    df$status <-
      apply(df, 1, function(x) {
        (x[["dt"]] >= x[["start"]] & x[["dt"]] < x[["end"]])
      })
    ver <- df[which(df$status == TRUE), ]$version
    ver
  } else {
    "latest"
  }
}

#' @noRd
# nocov start
`%:::%` <- function(pkg, fun)
  get(fun,
    envir = asNamespace(pkg),
    inherits = FALSE
  )
# nocov end

#' @noRd
sanitize_path <- function(path) {
  sub("/+$", "", path)
}

#' @noRd
has_a_git_remote <- function() {
  is_a_git_repo <- TRUE
  base::tryCatch({
    result <- usethis::git_remotes()
  },
  error = function(e) {
    is_a_git_repo <<- FALSE
  }
  )
  print(is_a_git_repo)
}



#' @noRd
is_clean <- function(repo) {
  sum(vapply(git2r::status(repo), length, numeric(1))) == 0
}
