#' @param forest from `create_forest_study()` call
#' @param trees a character vector `names(x)`
#' @noRd
#'
.create_forest_study_dirs <- function(forest, trees) {
    dir.create( forest, showWarnings = FALSE )

    lapply(
        file.path( forest, c("data_sets", "processed", "global_data") ),
        dir.create,  showWarnings = FALSE
    )

    for( tr in trees ) {
        lapply(
            file.path(
                forest, c("data_sets", "processed", file.path("data_sets", tr))
            ), dir.create,  showWarnings = FALSE
        )
    }
    invisible(NULL)
}

.add_data_slot_dirs_to_trees <- function(forest, data_slot, trees = NULL) {
    if( is.null(trees) ) {
        trees <- list.dirs(
            file.path(forest, "data_sets"),
            recursive = FALSE, full.names = FALSE
        )
    }
    lapply(
        file.path(forest, "data_sets", trees, data_slot), dir.create,  showWarnings = FALSE
    )
    invisible(NULL)
}

