#' @title An S7 object to organise a meta-analysis
#' @importFrom S7 new_class class_character new_property new_object S7_object
#' @param x `Character scalar` pointing to the relevant folder.
#' @export
#' @examples
#'
#' meta_study
#'
meta_study <- S7::new_class(
    name = "meta_study",
    package = "metanalysis",
    properties = list(
        abs_path = S7::class_character,
        folder_name = S7::new_property(
            getter = function(self) basename(self@abs_path)
        ),
        folder_location = S7::new_property(
            getter = function(self) dirname(self@abs_path)
        ),
        study_names = S7::new_property(
            getter = function(self) list.files( self@abs_path )
        ),
        study_data = S7::new_property(
            getter = function(self) data.frame(
                folder_name = self@folder_name,
                study_name  = self@study_names            )
        )
    ),
    constructor = function(x) {
        if(inherits(x, "metanalysis::meta_study")) return(x)

        # if x is a character, open up a dataset: make arrow FileSystemDataset
        if( inherits(x, "character") ) {
            if( !file.exists(x) ) {stop(paste0("object '", x , "' not found."))}

            S7::new_object( S7::S7_object(), abs_path = normalizePath(x) )
        }
    }
)


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
