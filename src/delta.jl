doc"""
    Delta(c)

    The *delta* distribution has mass concetrated on a single (constant) value.
"""

##### Delta distribution returns constant value

immutable Delta{T} <: DiscreteUnivariateDistribution
    c::T
end

rand(rng,d::Delta) = d.c
rand(d::Delta) = d.c
