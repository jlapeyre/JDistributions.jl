# JDistributions

This package contains some probability distributions. Some are not
available in `Distributions`. Some are here for historical reasons.

Below is a brief description of some distributions.
See the doc strings for more descriptions.

### InverseExponential

### TwoPoint

### SymBernoulli (fair coin)

Distribution with weight `1/2` on both `1` and `-1`

```julia
rand(SymBernoulli)      # return one sample
```

### Delta weight concentrated on  a single point

```julia
Delta(1)
Delta(1.0)
Delta("dog")
```

### JExponential

Same as Distributions.Exponential, but the copy constructor
works with `@parallel`. (maybe we should have tried deepcopy ?)


