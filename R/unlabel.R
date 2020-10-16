


#' @export

unlabel <- function(x) {
  UseMethod("unlabel")
}

#' @export

unlabel.default <- function(x) {
  attr(x, "label") <- NULL
  attr(x, "unit") <- NULL
  class(x) <- setdiff(class(x), "papaja_labelled")
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
