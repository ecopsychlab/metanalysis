#' @export
#'
`as.character.metanalysis::forest_study` <- function(x, ...) x@path

#' @importFrom S7 method<- convert class_character
S7::method(convert, list(forest_study, S7::class_character)) <-
    function(from, to) `as.character.metanalysis::forest_study`(from)

#' @importFrom S7 method<-
S7::method(load_data_type, forest_study) <- function(x, data_type) {
    x@data_slots[[data_type]]@filter(
        x@data_slots[[data_type]]@loader()
    )
}
