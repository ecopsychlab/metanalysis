#' @title Disassemble a SummarizedExperiment into component tables and save them
#' @param x `SummarizedExperiment`
#' @param path `Character scalar` path to write to.
#' @export
#' @importFrom SummarizedExperiment assays colData rowData
#'
disassemble_SE <- function(x, path = "flatSE") {
    se_path <- file.path(path)
    .prep_SE_dir(se_path)

    # assays
    .write_list_from_slot(assays(x), file.path(se_path, ".assays"))

    # colData
    arrow::write_dataset(
        as.data.frame(colData(x)), file.path(se_path, ".colData")
        )
    # colData
    arrow::write_dataset(
        as.data.frame(rowData(x)), file.path(se_path, ".rowData")
    )

}

#' @title Assemble a SummarizedExperiment from structured component files.
#' @param x `Character scalar` path to the file.
#' @importClassesFrom SummarizedExperiment SummarizedExperiment
#' @importFrom dplyr collect select any_of
#' @importFrom arrow open_dataset
#' @export
#'
assemble_SE <- function(x) {
    if(!file.exists(x)) stop("File 'x' does not exist. Is path correct?")
    p <- c("group", "group_name")

    # read assays
    all_assays <- tibble::column_to_rownames(
        dplyr::collect(
            arrow::open_dataset(file.path(x, ".assays"), partitioning = p)
        )
    )
    assay_names_df <- unique(all_assays[,p])
    assay_names <- assay_names_df[["group_name"]][assay_names_df[["group"]]]

    assay_input <- split(
        dplyr::select(all_assays, !dplyr::any_of(p)), all_assays[["group_name"]]
        )

    # colData
    coldata_input <- dplyr::collect(
        arrow::open_dataset(file.path(x, ".colData"))
        )

    # rowData
    rowdata_input <- dplyr::collect(
        arrow::open_dataset(file.path(x, ".rowData"))
    )

    SummarizedExperiment::SummarizedExperiment(
        assays = assay_input,
        colData = coldata_input,
        rowData = rowdata_input,
            )
}

.prep_SE_dir <- function(path) {

    dir.create(path, showWarnings = FALSE)

    for( s in file.path(path, c(".assays", ".colData", ".rowData")) ) {
        dir.create( s, showWarnings = FALSE )
    }
    invisible()
}

.write_list_from_slot <- function(x, path) {
    arrow::write_dataset(
        tibble::rownames_to_column(as.data.frame(x)),
        path, partitioning = c("group", "group_name")
        )
}

.num_prefix <- function(x) {
    formatC(seq_len(x), width = nchar(x), flag = "0")
}
