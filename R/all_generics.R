#' #' @title Create a dataset
#' #' @export
#' #' @param x an R object.
#' #' @examples
#' #' create_study_forest
#' create_study_forest <- S7::new_generic("create_study_forest", "x")

load_data_type <- S7::new_generic(
    "load_data_type", "x", function(x, data_type, ...) S7::S7_dispatch()
)

get_filter <- S7::new_generic(
    "get_filter", "x"
)

set_filter <- S7::new_generic(
    "set_filter", "x", function(x, ..., value) S7::S7_dispatch()
)

get_loader <- S7::new_generic(
    "get_loader", "x"
)

set_loader <- S7::new_generic(
    "set_loader", "x", function(x, ..., value) S7::S7_dispatch()
)
