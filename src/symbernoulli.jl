doc"""
   SymBernoulli()

   The *symmetric Bernoulli distribution*, has mass concetrated on -1 and +1 (integers) with equal probability.
"""

immutable SymBernoulli <: DiscreteUnivariateDistribution
end

#### Sampling

rand(::Type{SymBernoulli}) =  2*rand(Bool) - 1
rand(d::SymBernoulli) =  2*rand(Bool) - 1

#### Statistics

mean(::Type{SymBernoulli}) =  0
mean(d::SymBernoulli) =  0
