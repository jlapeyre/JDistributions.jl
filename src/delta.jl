doc"""
    Delta(c)

The *delta* distribution has mass concetrated on the value `c`.
"""

##### Delta distribution returns constant value

immutable Delta{T} <: DiscreteUnivariateDistribution
    c::T
end

rand(rng,d::Delta) = d.c
rand(d::Delta) = d.c

mean(d::Delta) = d.c

moment(d::Delta, k::Real) = (d.c)^k
