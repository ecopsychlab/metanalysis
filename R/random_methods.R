#' @title Randomly generate a macro_study and corresponding folders.
#' @description
#' Mostly for instructive and debugging purposes.
#' @export
#' @param n `Numeric scalar` number of studies to generate
#' @inheritParams create_study_forest
#' @examples
#' x <- random_macro_study(n = 100)
#' x
#'
random_macro_study <- function(n, dataset_name = tempfile()) {


    s <- paste0( "study_", formatC(seq_len(n), width = nchar(n), flag = "0") )
    dir.create(dataset_name, showWarnings = FALSE)
    invisible(
        lapply(file.path(dataset_name, s), dir.create, showWarnings = FALSE)
    )
    for(i in s) {
        arrow::write_parquet(
            .random_table(), paste0(file.path(dataset_name, i, i), ".parquet")
        )
    }
    new_macro_study(dataset_name)
}

#' Helper to make random tables
#' @noRd
#' @importFrom stats rnorm
.random_table <- function() `colnames<-`(as.data.frame(
    replicate( length(LETTERS), stats::rnorm(100L), simplify = FALSE )),
    paste0( "sample_", formatC(seq_len(26L), width = 2L, flag = "0"))
)

