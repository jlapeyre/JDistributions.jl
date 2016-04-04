# JDistributions

This package contains some probability distributions.
It is intended for private use. It exists because

1. It was written before precompilation when the official `Distributions` packages took
an eternity to load.
2. It has distributions that are not (or at one time were not) included in
   `Distributions`.
3. Works around some bugs (or apparent bugs) in using `Distributions` with parallel
  worker processes.
