#' Assign or Extract Variable Labels
#'
#' Assign or extract variable labels of a `vector` *or*
#' the columns (i.e., vectors) of a `data.frame`.
#'
#' @param x Either a vector or a `data.frame`.
#' @param value Character. The variable label(s) to be assigned. If `variable_label()` is applied to a single vector,
#' this should be a length-one argument. If applied to a `data.frame`, `value` is required to be a *named* vector
#' or a *named* list.
#' Check the examples for details.
#' @param ... Further arguments that may be passed to methods.
#' @return
#'   For vectors, `variable_label` returns NULL or the variable label (typically of length one).
#'   For data frames, `variable_label` returns a named list where each column corresponds to a column of the data frame.
#'
#'   The assignment methods `variable_label<-` return the labelled object.
#'
#' @examples
#'   # label a single vector
#'   variable_label(letters) <- "The alphabet" # Assign
#'   variable_label(letters)                   # Extract
#'
#'   # label some columns of a data frame
#'   variable_labels(npk) <- list(             # Assign
#'     N = "Nitrogen"
#'     , P = "Phosphate"
#'     , K = expression(italic(K))
#'   )
#'   variable_labels(npk)                      # Extract
#' @seealso See [label_variable()] for an alternative that is compatible with the tidyverse's pipe operator.
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


#' Label Variables Using Pipes
#'
#' `label_variable()` can be used to assign variable labels within a workflow
#' using the tidyverse's pipe operator.
#'
#' @param ... Variable label(s) to be assigned. For data frames, these have to be name-value pairs,
#'   see example.
#' @inheritParams variable_label
#' @examples
#'   library(dplyr)
#'   test <- npk %>%
#'     label_variable(N = "Test", P = "Phosphate")
#'   variable_label(test)
#' @export

label_variable <- function(x, ...){
  assign_label(x, value = list(...))
}

# ------------------------------------------------------------------------------
# alias generics

#' @rdname variable_label
#' @export

"variable_labels" <- variable_label

#' @rdname variable_label
#' @export

`variable_labels<-` <- `variable_label<-`

#' @rdname label_variable
#' @export

"label_variables" <- label_variable
