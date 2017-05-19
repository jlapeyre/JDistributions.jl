doc"""
    SymBernoulli()

The *symmetric Bernoulli distribution*, has mass concetrated on -1 and +1 (integers) with equal probability.
"""

immutable SymBernoulli <: DiscreteUnivariateDistribution
end

SymB = Union{SymBernoulli,Type{SymBernoulli}}

#### Sampling

rand(d::SymB)  =  2*rand(Bool) - 1

#rand(DataType::SymBernoulli, dims::Int64...)  =  rand(SymBernoulli(),dims...)

#### Statistics

mean(d::SymB) =  0

moment(d::SymB, k::Integer) = iseven(k) ? one(k) : zero(k)

moment(d::SymB, k::Number) = (1^k + Complex(-float(one(k)), zero(k))^k) * 1//2

