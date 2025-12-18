#' #' @title Create a dataset
#' #' @export
#' #' @param x an R object.
#' #' @examples
#' #' create_study_forest
#' create_study_forest <- S7::new_generic("create_study_forest", "x")

load_data_type <- S7::new_generic(
    "load_data_type", "x", function(x, data_type, ...) S7::S7_dispatch()
    )
