# tinylabels 0.1.0.9000

- Added a `NEWS.md` file to track changes to the package.
- Input validation now ensures that variable labels are (1) atomic vectors (i.e.,
  no list-like objects) of (2) length equal to zero or one that (3) are not NULL.
- In `assign_label.data.frame()`, NULL elements of a value list are ignored.
- In `assign_label.default()`, label and class attribute are now directly set,
  which comes with a small performance benefit.
