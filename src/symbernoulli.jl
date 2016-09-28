doc"""
    SymBernoulli()

The *symmetric Bernoulli distribution*, has mass concetrated on -1 and +1 (integers) with equal probability.
"""

immutable SymBernoulli <: DiscreteUnivariateDistribution
end

SymB = Union{SymBernoulli,Type{SymBernoulli}}

#### Sampling

rand(d::SymB)  =  2*rand(Bool) - 1

#### Statistics

mean(d::SymB) =  0

moment(d::SymB, k::Integer) = iseven(k) ? 2 : 0

moment(d::SymB, k::Number) = (Complex(0.0,-1.0))^k

