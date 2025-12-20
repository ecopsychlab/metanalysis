# TODO Add data_sets slot to class.
# Find way to read all trees and take all objects as slots. biocM


#' @title An S7 object to organise a meta-analysis
#' @importFrom S7 new_class class_character new_property new_object
#' @param x `Character scalar` pointing to the relevant folder.
#' @export
#'
macro_study <- S7::new_class(
    name = "macro_study",
    package = "metanalysis",
    properties = list(
        path = S7::class_character,
        data_slots = S7::class_list, macro_view = S7::new_property(
            getter = function(self) {
                x <- list.files(
                    file.path(self@path, "data_sets"), recursive = TRUE
                )
                do.call(
                    base::rbind,
                    strsplit(x, split = .Platform[["file.sep"]], fixed = TRUE)
                )
            }
        )
    ),
    constructor = function(x) {
        if(!file.exists(x)) { stop(paste0("Object '", x , "' not found.")) }
        slots <- .make_data_slots(x)
        S7::new_object(
            S7::S7_object(), path = normalizePath(x), data_slots = slots
        )
    }
)


data_slot <- S7::new_class(
    "data_slot",
    package = "metanalysis",
    properties = list(
        path = S7::class_character,
        name = S7::class_character,
        loader = S7::class_function,
        filter = S7::class_function
    ),
    constructor = function(x, data_type) {
        S7::new_object(
            S7::S7_object(),
            path = x,
            name = data_type,
            loader = .default_loader(x),
            filter = .default_filter(data_type)
        )
    }
)

#' @noRd
#' @importFrom rlang expr new_function
#' @importFrom arrow open_dataset
.default_loader <- function(path) rlang::new_function(
    args = NULL,
    body = rlang::expr({
        data_path <- file.path( !!path, "data_sets" )
        arrow::open_dataset(
            data_path, partitioning = c("study", "type")
        )
    })
)


#' @noRd
#' @importFrom rlang pairlist2 expr new_function
#' @importFrom dplyr filter %>% collect
.default_filter <- function(data_type = "auto") rlang::new_function(
    args = rlang::pairlist2(.loaded_data = ),
    body = rlang::expr(
        .loaded_data %>%
            dplyr::filter(type == !!data_type) %>%
            dplyr::collect()
    )
)

.check_micro_name <- function(path, name) {

    if(missing(name)) {
        stop(
            "The 'name' argument is required. Valid options are:\n'",
            paste0(list.dirs(path, recursive = FALSE, full.names = FALSE),
                   collapse = "', '"), "'."
        )
    }
    if(! name %in% list.dirs(path, recursive = FALSE, full.names = FALSE)) {
        stop(
            "No folder named '", name, "' found at location '",
            path, "'. Valid options are:\n'",
            paste0(list.dirs(path, recursive = FALSE, full.names = FALSE),
                   collapse = "', '"), "'."
        )
    }
}

#' @importFrom dplyr collect filter
#' @importFrom arrow open_dataset
#' @importFrom S7 new_property
#' @noRd
#'
.make_data_slots <- function(x) {
    prp <- list.files(list.dirs(file.path(x, "data_sets"), recursive = FALSE))

    data_slots <- lapply( unique(prp), data_slot, x = x )
    `names<-`(data_slots, unique(prp))
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
