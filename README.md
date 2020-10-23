
# Lightweight Variable Labels with tinylabels

<!-- badges: start -->
[![R build status](https://github.com/mariusbarth/tinylabels/workflows/R-CMD-check/badge.svg)](https://github.com/mariusbarth/tinylabels/actions)
<!-- badges: end -->

Variable labels are useful in many data-analysis contexts, but R does not provide
variable labels in its base distribution. Several R packages introduced (sometimes conflicting)
implementations (e.g., **Hmisc**, **haven**, **sjLabelled**), but these packages come with extensive
dependencies.
Following the philosophy of a *tiny* dependency graph (the [tinyverse](http://www.tinyverse.org) philosophy),
**tinylabels** set out to provide functionality for variable labels without depending
on any non-base R packages, while also being as compatible as possible with other implementations.
Another deliberate choice is that **tinylabels** only implements *variable* labels, not *value* labels.

With a tiny dependency graph and a small code base, we hope that **tinylabels** may become an
excellent choice for package developers, as well as for data analysts who care about dependencies.

Function overview:

- Assign variable label: `variable_label()<-`
- Extract variable label: `variable_label()`
- Remove labels and `tiny_labelled` class: `unlabel()`
- Assign labels in a piped workflow: `label_variables()`
