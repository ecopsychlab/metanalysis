#' @title Create a data set from a list of objects.
#' @description
#' Meant to be seamlessly compatible with `arrow::read_parquet()`.
#' @param x `Named list` of objects to create an arrow-compatible dataset from
#' @param dataset_name `Character scalar`. Name of the database folder that
#'     should be created.
#' @param engine `function` The function that will write out the content of `x`.
#'     (Default: `arrow::write_parquet`)
#' @param ... Additional arguments to function specified with 'engine' argument.
#' @param .file_suffix,file_ext `Character scalar`. Specify file suffix and
#'     file extension, respectively. (Default: `NULL`)
#' @export
#' @importFrom arrow write_parquet
#'
create_dataset <- function(
        x, dataset_name, engine = arrow::write_parquet, ...,
        .file_suffix = NULL, .file_ext = NULL
        ) {
    # check input
    stopifnot("'x' must be a named list. " = is.list(x) && length(names) > 0L)

    # Guess file extension from writing engine
    if(is.null(.file_ext)) {
        .file_ext <- .engine2extension(substitute(engine))
    }

    dir.create(dataset_name)

    for( n in names(x) ) {
       dir.create(file.path(dataset_name, n))
    }

    out_paths <- paste0(
        file.path(dataset_name, names(x), paste0(names(x), .file_suffix)),
        .file_ext
        )

    if( length(dargs <- list(...)) < 1L ) {
        mapply( FUN = engine, x, out_paths, SIMPLIFY = FALSE )
    } else {
        mapply( FUN = engine, x, out_paths, MoreArgs = dargs, SIMPLIFY = FALSE )
    }

    invisible(NULL)
}

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



