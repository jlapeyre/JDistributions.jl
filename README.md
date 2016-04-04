# JDistributions

This package contains some probability distributions.
It is intended for private use. It exists because

1. It was written before precompilation, when the official `Distributions` packages took
an eternity to load.
2. It has distributions that are not (or at one time were not) included in
   `Distributions`.
3. Works around some bugs (or apparent bugs) in using `Distributions` with parallel
  worker processes.

### Pareto

### SymBernoulli (fair coin)

Distribution with weight `1/2` on both `1` and `-1`

```julia
rand(SymBernoulli)      # return one sample
rand(SymBernoulli,n)    # return n samples
rand!(SymBernoulli,A)   # fill array A with samples
```

### Delta weight concentrated on  a single point

```julia
Delta(1)
Delta(1.0)
Delta("dog")
```

### JExponential

Same as Distributions.Exponential, but the copy constructor
works with `@parallel`.
