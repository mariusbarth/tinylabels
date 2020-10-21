#' Assign or Extract Variable Labels
#'
#' Assign or extract variable labels of a \code{vector} \emph{or}
#' the columns (i.e., vectors) of a \code{data.frame}.
#'
#' @param x Either a vector or a \code{data.frame}.
#' @param value Character. The variable label(s) to be assigned. If \code{variable_label} is applied to a single vector,
#' this should be a length-one argument. If applied to a \code{data.frame}, \code{value} is required to be a \emph{named} vector
#' (or a named list).
#' Check the examples for details.
#' @param ... Further arguments that may be passed to methods.
#' @rdname variable_label
#' @export

"variable_label" <- function(x, ...){
  UseMethod("variable_label")
}



#' @rdname variable_label
#' @export

variable_label.default <- function(x, ...){
  # use `exact = TRUE` so that only variable labels, and not value labels from
  # haven are extracted
  attr(x, "label", exact = TRUE)
}



#' @rdname variable_label
#' @export

variable_label.data.frame <- function(x, ...){
  mapply(FUN = variable_label, x, SIMPLIFY = FALSE, USE.NAMES = TRUE)
}



# ------------------------------------------------------------------------------
# Replacement methods

#' @rdname variable_label
#' @export

`variable_label<-` <- function(x, value){
  UseMethod("variable_label<-")
}



#' @rdname variable_label
#' @export

`variable_label<-.default` <- function(x, value){
  assign_label.default(x, value)
}



#' @rdname variable_label
#' @export

`variable_label<-.data.frame` <- function(x, value){
  assign_label.data.frame(x, value)
}


# A pipable alternative --------------------------------------------------------

#' @rdname variable_label
#' @export

label_variable <- function(x, ...){
  ellipsis <- unlist(list(...))
  assign_label.data.frame(x, value = ellipsis)
}

# ------------------------------------------------------------------------------
# alias generics

#' @rdname variable_label
#' @export

"variable_labels" <- variable_label

#' @rdname variable_label
#' @export

`variable_labels<-` <- `variable_label<-`

#' @rdname variable_label
#' @export

"label_variables" <- label_variable
