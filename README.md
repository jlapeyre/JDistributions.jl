# JDistributions

*Some probability distributions that are not in `Distributions.jl`*

Linux, OSX: [![Build Status](https://travis-ci.org/jlapeyre/JDistributions.jl.svg)](https://travis-ci.org/jlapeyre/JDistributions.jl)
&nbsp;
Windows: [![Build Status](https://ci.appveyor.com/api/projects/status/github/jlapeyre/JDistributions.jl?branch=master&svg=true)](https://ci.appveyor.com/project/jlapeyre/jdistributions-jl)
&nbsp; &nbsp; &nbsp;
[![Coverage Status](https://coveralls.io/repos/github/jlapeyre/JDistributions.jl/badge.svg)](https://coveralls.io/github/jlapeyre/JDistributions.jl)
[![codecov.io](http://codecov.io/github/jlapeyre/JDistributions.jl/coverage.svg?branch=master)](http://codecov.io/github/jlapeyre/JDistributions.jl?branch=master)

See the doc strings for more descriptions.

- GeneralizedGamma

- InverseExponential

- TwoPoint

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
