# TODO Add data_sets slot to class.
# Find way to read all trees and take all objects as slots. biocM


#' @title An S7 object to organise a meta-analysis
#' @importFrom S7 new_class class_character new_property prop_names
#' @export
#'
macro_study <- S7::new_class(
    name = "macro_study",
    package = "metanalysis",
    abstract = TRUE,
    properties = list(
        path   = S7::class_character,
        slotNames = S7::new_property(
            getter = function(self) setdiff(
                S7::prop_names(self), c("path", "slotNames")
                )
            ),
        study_trees = S7::class_character
    )
)

#' @rdname macro_study
#' @importFrom S7 new_class new_object S7_object
#' @param x `Character scalar` pointing to the relevant folder.
#' @export
#'
new_macro_study <- function(x) {
    study_instance <- S7::new_class(
        name = "study_instance",
        parent = macro_study,
        package = "metanalysis",
        properties = .make_data_properties(x),
        constructor = function(x) {
            if(!file.exists(x)) { stop(paste0("object '", x , "' not found.")) }
            S7::new_object(.parent = S7::S7_object(), path = normalizePath(x) )
        }
    )
    study_instance(x)
}



.make_data_properties <- function(x) {
    prp <- list.files(file.path(x, "data_sets"), all.files = TRUE, no.. = TRUE)
    lapply(prp, function(x) S7::new_property(name = x))
    }


#
# feature_table <- S7::new_class(
#     name = "feature_table",
#     package = "metanalysis",
#     parent = banded
# )
#
# feature_metadata <- S7::new_class(
#     name = "feature_metadata",
#     package = "metanalysis",
#     parent = banded
# )
#
# sample_metadata <- S7::new_class(
#     name = "sample_metadata",
#     package = "metanalysis",
#     parent = banded
# )
