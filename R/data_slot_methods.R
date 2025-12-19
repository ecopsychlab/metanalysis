# # S7::`method<-`(show, data_slot) <- function(object) print(object)
# #
# # S7::`method<-`(print, data_slot) <- function(x) {
# #
# # }
#
#
#
# l <- function(self) eval_tidy(x@data_slots$auto@load)
# f <- function(.loaded_data) eval_tidy(x@data_slots$auto@filt)
# f(l(x))
#
# filter(l(x), am > 5)
#
# f(l(x), data_type = "auto")
#
#
# codetools::findGlobals(print.data.frame)
# codetools::collectUsage(print)
# codetools::checkUsage(f)
#
# f <- function(x, y) a + b
