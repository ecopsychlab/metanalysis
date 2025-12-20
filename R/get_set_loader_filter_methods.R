S7::method(get_filter, data_slot) <- function(x) {
    x@filter
}

S7::method(set_filter, data_slot) <- function(x, value) {
    x@filter <- value
    x
}


S7::method(set_loader, data_slot) <- function(x, value) {
    x@loader <- value
    x
}

S7::method(get_filter, data_slot) <- function(x) {
    x@filter
}
