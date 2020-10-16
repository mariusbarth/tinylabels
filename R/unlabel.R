#' Remove Labels from Objects
#'
#' Remove [variable_labels] from a labelled vector of from the columns of a data frame.
#'
#' @param x An \R object.
#' @return Object as `x` but without variable labels.
#' @export

unlabel <- function(x) {
  UseMethod("unlabel")
}

#' @export

unlabel.default <- function(x) {
  attr(x, "label") <- NULL
  attr(x, "unit") <- NULL
  class(x) <- setdiff(class(x), "papaja_labelled")
  if(is.atomic(x) && !is.factor(x)) x <- unclass(x)
  x
}

#' @method unlabel data.frame
#' @export

unlabel.data.frame <- function(x) {
  for (i in seq_len(ncol(x))) {
    x[[i]] <- unlabel(x[[i]])
  }
  x
}
