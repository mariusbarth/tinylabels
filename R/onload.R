.onLoad <- function(...) {

  if(requireNamespace("vctrs", quietly = TRUE)) {
    s3_register("vctrs::vec_ptype2", "tiny_labelled.tiny_labelled")

    s3_register("vctrs::vec_ptype2", "tiny_labelled.logical")
    s3_register("vctrs::vec_ptype2", "tiny_labelled.integer")
    s3_register("vctrs::vec_ptype2", "tiny_labelled.double")
    s3_register("vctrs::vec_ptype2", "tiny_labelled.complex")
    s3_register("vctrs::vec_ptype2", "tiny_labelled.raw")
    s3_register("vctrs::vec_ptype2", "tiny_labelled.character")
    s3_register("vctrs::vec_ptype2", "tiny_labelled.factor")
    s3_register("vctrs::vec_ptype2", "tiny_labelled.ordered")


    s3_register("vctrs::vec_ptype2", "logical.tiny_labelled")
    s3_register("vctrs::vec_ptype2", "integer.tiny_labelled")
    s3_register("vctrs::vec_ptype2", "double.tiny_labelled")
    s3_register("vctrs::vec_ptype2", "complex.tiny_labelled")
    s3_register("vctrs::vec_ptype2", "raw.tiny_labelled")
    s3_register("vctrs::vec_ptype2", "character.tiny_labelled")
    s3_register("vctrs::vec_ptype2", "factor.tiny_labelled")
    s3_register("vctrs::vec_ptype2", "ordered.tiny_labelled")

    s3_register("vctrs::vec_cast", "tiny_labelled.tiny_labelled")

    s3_register("vctrs::vec_cast", "tiny_labelled.logical")
    s3_register("vctrs::vec_cast", "tiny_labelled.integer")
    s3_register("vctrs::vec_cast", "tiny_labelled.double")
    s3_register("vctrs::vec_cast", "tiny_labelled.complex")
    s3_register("vctrs::vec_cast", "tiny_labelled.raw")
    s3_register("vctrs::vec_cast", "tiny_labelled.character")
    s3_register("vctrs::vec_cast", "tiny_labelled.factor")
    s3_register("vctrs::vec_cast", "tiny_labelled.ordered")

    s3_register("vctrs::vec_cast", "logical.tiny_labelled")
    s3_register("vctrs::vec_cast", "integer.tiny_labelled")
    s3_register("vctrs::vec_cast", "double.tiny_labelled")
    s3_register("vctrs::vec_cast", "complex.tiny_labelled")
    s3_register("vctrs::vec_cast", "raw.tiny_labelled")
    s3_register("vctrs::vec_cast", "character.tiny_labelled")
    s3_register("vctrs::vec_cast", "factor.tiny_labelled")
    s3_register("vctrs::vec_cast", "ordered.tiny_labelled")
  }

  if(requireNamespace("ggplot2", quietly = TRUE)) {
    s3_register("ggplot2::scale_type", "tiny_labelled")
  }

  invisible()
}


# This function is taken from the vctrs package,
# which is subject to the MIT license
#' @keywords internal

s3_register <- function(generic, class, method = NULL) {
  stopifnot(is.character(generic), length(generic) == 1)
  stopifnot(is.character(class), length(class) == 1)

  pieces <- strsplit(generic, "::")[[1]]
  stopifnot(length(pieces) == 2)
  package <- pieces[[1]]
  generic <- pieces[[2]]

  caller <- parent.frame()

  get_method_env <- function() {
    top <- topenv(caller)
    if (isNamespace(top)) {
      asNamespace(environmentName(top))
    } else {
      caller
    }
  }
  get_method <- function(method, env) {
    if (is.null(method)) {
      get(paste0(generic, ".", class), envir = get_method_env())
    } else {
      method
    }
  }

  method_fn <- get_method(method)
  stopifnot(is.function(method_fn))

  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(package, "onLoad"),
    function(...) {
      ns <- asNamespace(package)

      # Refresh the method, it might have been updated by `devtools::load_all()`
      method_fn <- get_method(method)

      registerS3method(generic, class, method_fn, envir = ns)
    }
  )

  # Avoid registration failures during loading (pkgload or regular)
  if (!isNamespaceLoaded(package)) {
    return(invisible())
  }

  envir <- asNamespace(package)

  # Only register if generic can be accessed
  if (exists(generic, envir)) {
    registerS3method(generic, class, method_fn, envir = envir)
  }

  invisible()
}
