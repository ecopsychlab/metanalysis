#' @export
#'
`as.character.metanalysis::macro_study` <- function(x, ...) x@path

#' @importFrom S7 method<- convert class_character
S7::method(convert, list(macro_study, S7::class_character)) <-
    function(from, to) `as.character.metanalysis::macro_study`(from)

#' @importFrom rlang eval_tidy
S7::method(load_data_type, macro_study) <- function(x, data_type) {
    x@data_slots[[data_type]]@filter(
        x@data_slots[[data_type]]@loader()
    )
}


# f <- function(x) eval_tidy(dslot@filt)
#
# f()
