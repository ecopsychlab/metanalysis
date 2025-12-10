#' @export
create_dataset <- function(
        x, dataset_name, engine = arrow::write_parquet, ..., .fileext = NULL
        ) {
    # check input
    stopifnot("'x' must be a named list. " = is.list(x) && length(names) > 0L)

    # Guess file extension from writing engine
    if(is.null(.fileext)) {
        .fileext <- .engine2extension(substitute(engine))
    }

    dir.create(dataset_name)
    for( n in names(x) ) {
       dir.create(file.path(dataset_name, n))
    }

    out_paths <- paste(file.path(dataset_name, names(x)), .fileext, sep = ".")

    if( length( dotargs <- list(...) ) < 1L ) {
        mapply(
            FUN = engine, x, out_paths, SIMPLIFY = FALSE
        )
    } else {
        mapply(
            FUN = engine, x, out_paths, MoreArgs = dotargs, SIMPLIFY = FALSE
        )
    }
    invisible(NULL)
}

.engine2extension <- function(x) {
    ext <- vapply(
        c("parquet", "arrow", "ipc", "feather", "csv", "tsv", "txt", "json"),
        FUN = grepl,
        as.character(x)[[length(x)]],
        FUN.VALUE = FALSE
        )
    stopifnot(
        "Was not able to determine file extensions from engine" = sum(ext) == 1L
        )
    return(names(which(ext)))
}



