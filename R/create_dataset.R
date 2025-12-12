meta_add <- function(x, type) {
    NULL
}

#' @title Create a data set from a list of objects.
#' @description
#' Meant to be seamlessly compatible with `arrow::read_parquet()`.
#' @param x `Named list` of objects to create an arrow-compatible dataset from
#' @param dataset_name `Character scalar`. Name of the database folder that
#'     should be created.
#' @param engine `function` The function that will write out the content of `x`.
#'     (Default: `arrow::write_parquet`)
#' @param engine_args `list` of other arguments to `engine` function argument.
#'     (Default: NULL)
#' @param .file_suffix,.file_ext `Character scalar`. Specify file suffix and
#'     file extension, respectively. (Default: `NULL`)
#' @export
#' @importFrom arrow write_parquet
#'
create_dataset <- function(
        x, dataset_name, engine = arrow::write_parquet, engine_args = NULL,
        .file_suffix = NULL, .file_ext = NULL
        ) {
    # check input
    stopifnot(
        "'x' must be a character vector or a named list." =
            inherits(x, c("list", "character"))
        )
    # Simple case first
    if( is.character(x) ) {
        .build_dataset_folders(x, dataset_name)
        return(invisible())
        }
    if( is.null(x_names <- names(x)) ) {
        stop("'x' must be a character vector or a named list.")
    }
    .build_dataset_folders(x_names, dataset_name)

    # Guess file extension from writing engine
    if(is.null(.file_ext)) {
        .file_ext <- .engine2extension(substitute(engine))
    }

    out_paths <- paste0(
        file.path(dataset_name, x_names, paste0(x_names, .file_suffix)),
        .file_ext
        )

    .add_dataset_files(x, out_paths, engine, engine_args)

    invisible(NULL)
}

#' @param x a character `vector names(x)``
#' @param dataset_name from `create_dataset()` call
#' @noRd
#'
.build_dataset_folders <- function(x, dataset_name) {
    dir.create(dataset_name)

    for( n in x ) {dir.create( file.path(dataset_name, n) )}

    invisible(NULL)
}

#' @param x a list of files to write
#' @param out_paths character vector of out paths
#' @param engine which function to use for this.
#' @noRd
#'
.add_dataset_files <- function(x, out_paths, engine, engine_args) .mapply(
    engine, dots = list(x, out_paths), MoreArgs = engine_args
    )


.engine2extension <- function(x) {
    # Compare engine to string of extensions
    ext <- vapply(
        c("parquet", "arrow", "ipc", "feather", "csv", "tsv", "txt", "json"),
        FUN = grepl,
        as.character(x)[[length(x)]],
        FUN.VALUE = FALSE
        )
    # Check if single hit was found
    stopifnot(
        "Was not able to determine file extensions from engine" = sum(ext) == 1L
        )
    # Prepare output
    ext <- paste0(".", names(which(ext)))
    return(ext)
}



