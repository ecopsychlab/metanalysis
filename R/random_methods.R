#' @title Randomly generate a forest_study and corresponding folders.
#' @description
#' Mostly for instructive and debugging purposes.
#' @export
#' @param n_trees `Numeric scalar` number of studies to generate
#' @inheritParams create_forest_study
#' @examples
#' x <- random_forest_study(n_trees = 100)
#' x
#'
random_forest_study <- function(
        n_trees = 10, n_data_slots = 10, sparseness = 0.5,
        forest_name = tempfile()
) {

    s_tr <- paste0(
        "study_tree_",
        formatC(seq_len(n_trees), width = nchar(n_trees), flag = "0")
    )
    d_sl <- paste0(
        "data_slot_",
        formatC(seq_len(n_data_slots), width = nchar(n_data_slots), flag = "0")
    )

    .create_forest_study_dirs(forest_name, s_tr)

    for(s in s_tr) {
        s_ds <- sample(d_sl, round(length(d_sl) * 0.5), replace = FALSE)

        for(d in c(s_ds, "coldata")) {
            arrow::write_parquet(
                .random_table(),
                paste0(file.path(forest_name, "data_sets", s, d, d), ".parquet")
            )
        }
    }
    forest_study(forest_name)
}

#' Helper to make random tables
#' @noRd
#' @importFrom stats rnorm
.random_table <- function() `colnames<-`(as.data.frame(
    replicate( length(LETTERS), stats::rnorm(100L), simplify = FALSE )),
    paste0( "sample_", formatC(seq_len(26L), width = 2L, flag = "0"))
)

