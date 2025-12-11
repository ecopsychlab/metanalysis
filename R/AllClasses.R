#' @importFrom S7 new_class new_S3_class new_object
#' @export
#' @usage
#'
#' meta_study("demo_folder")
#'
meta_study <- S7::new_class(
    name = "meta_study",
    package = "metanalysis",
    properties = list(
        folder_name = S7::class_character,
        study_names = S7::new_property(
            getter = function(self) list.files( self@folder_name )
        ),
        study_data = S7::new_property(
            getter = function(self) data.frame(
                folder_name = self@folder_name,
                study_name  = self@study_names,
                study_data  = list.files(
                    file.path(self@folder_name, self@study_names),
                    full.names = FALSE
                    )
            )
        )
    ),
    constructor = function(x) {
        if( !file.exists(x) ) {
            stop(paste0("object '", x , "' not found. "))
            }
        S7::new_object(
            .parent = S7::S7_object(),
            folder_name = x
        )
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
