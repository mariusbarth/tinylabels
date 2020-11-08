


#' @keywords internal

assign_label <- function(x, value, ...){
  UseMethod("assign_label")
}



#' @keywords internal

assign_label.default <- function(x, value){

  # First remove all nesting structures
  value <- unname(unlist(value, recursive = TRUE, use.names = FALSE))

  if(missing(value) || is.null(value)) stop("Variable labels must not be NULL. To entirely remove variable labels, use unlabel().", call. = FALSE)

  # Labels may have length 0 or 1
  if(length(value) > 1L) stop(
    "Trying to set a variable label of length greater than one: "
    , paste(encodeString(value, quote = "'"), collapse = ", ")
  )

  # Faster than calling structure()
  attr(x, "label") <- value
  class(x) <- unique.default(c("tiny_labelled", class(x)))
  x
}



#' @keywords internal

assign_label.data.frame <- function(x, value, ...){

  # R allows data frames to have duplicate column names.
  # The following code is optimized to work even in this horrible case.
  # This is especially important for default_label and apa_table (e.g., in
  # a frequency table, you frequently have repeating column names):

  if(is.null(names(value))){
    stop(
      "The assigned variable label(s) must be passed as a named vector or a named list."
      , call. = FALSE
    )
  }

  if(!all(names(value) %in% colnames(x))){
    stop(
      "While trying to set variable labels, some requested columns could not be found in data.frame:\n"
      , paste(encodeString(setdiff(names(value), colnames(x)), quote = "'"), collapse = ", ")
      , call. = FALSE
    )
  }

  colx <- colnames(x)
  for(i in seq_along(colx)) {
    if(any(colx[i] == names(value))) {
      v <- value[[colx[i]]]
      if(!is.null(v)) x[[i]] <- assign_label(x[[i]], v)
    }
  }
  x
}
