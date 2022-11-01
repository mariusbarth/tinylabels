
# These methods are dynamically registered (code in file onload.R) if the
# ggplot2 package is available.

scale_type.tiny_labelled <- function(x) {
  ggplot2::scale_type(unlabel(x))
}
