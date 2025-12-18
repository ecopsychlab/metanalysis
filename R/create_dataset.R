#' @title Create a study forest.
#' @param x `Named list` of objects to create an arrow-compatible data set from.
#' @param dataset_name `Character scalar`. Name of the database folder that
#'     should be created.
#' @param engine `function` The function that will write out the content of `x`.
#'     (Default: `arrow::write_parquet`)
#' @param engine_args `list` of other arguments to `engine` function argument.
#'     (Default: NULL)
#' @param data_type,file_ext `Character scalar`. Specify file suffix and
#'     file extension, respectively. (Default: `NULL`)
#' @export
#'
create_study_forest <- function(
        x, dataset_name, data_type = "auto", engine = arrow::write_parquet,
        engine_args = NULL, file_ext = NULL
) {
    # check input
    stopifnot(
        "'x' must be a character vector or a named list." =
            inherits(x, c("list", "character"))
    )

    # Simple case first
    if( is.character(x) ) {
        .build_dataset_folders(x, dataset_name)
        # Finish simple case
        return( invisible() )
    }

    if( is.null(x_names <- names(x)) ) {
        stop("'x' must be a character vector or a named list.")
    }
    .build_dataset_folders(x_names, dataset_name)

    # Then, prepare a call to `add_forest_dataset()`
    add_args <- rlang::call_args(
        rlang::call_match( fn = add_forest_dataset, defaults = TRUE )
    )
    add_args[["dataset_name"]] <- dataset_name
    do.call(add_forest_dataset, add_args)

    # Finish
    return( invisible(NULL) )
}




#' @title Add a list of R objects to an existing macro_study object.
#' @param x `Named list` of objects to create an arrow-compatible data set from.
#' @param dataset_name `Character scalar`. Name of the database folder that
#'     should be created.
#' @param engine `function` The function that will write out the content of `x`.
#'     (Default: `arrow::write_parquet`)
#' @param engine_args `list` of other arguments to `engine` function argument.
#'     (Default: NULL)
#' @param data_type,file_ext `Character scalar`. Specify file suffix and
#'     file extension, respectively. (Default: `NULL`)
#' @importFrom rlang enquo
#' @export
#'
add_forest_dataset <- function(
        x, dataset_name, data_type = "auto", engine = arrow::write_parquet,
        engine_args = NULL, file_ext = NULL
        ) {

    # Guess file extension from writing engine
    if(is.null(file_ext)) {
        file_ext <- .engine2extension(substitute(engine))
    }
    x_names <- names(x)

    out_paths <- paste0(
        file.path(dataset_name, "data_sets", x_names, data_type, data_type),
        file_ext
    )
    .add_dataset_folders(dataset_name, data_type)
    .add_dataset_files(x, out_paths, engine, engine_args)

    invisible()
}


#' @param x a character `vector names(x)``
#' @param dataset_name from `create_study_forest()` call
#' @noRd
#'
.build_dataset_folders <- function(x, dataset_name) {
    dir.create( dataset_name, showWarnings = FALSE )
    lapply(
        file.path( dataset_name, c("data_sets", "processed") ),
        dir.create,  showWarnings = FALSE
    )
    for( n in x ) {
        dir.create( file.path(dataset_name, "data_sets", n), showWarnings = FALSE )
        }
    invisible(NULL)
}

.add_dataset_folders <- function(dataset_name, data_type) {
    lapply(
        file.path(
            list.dirs(file.path(dataset_name, "data_sets"), recursive = FALSE),
            data_type
        ),
        dir.create,  showWarnings = FALSE
    )
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

