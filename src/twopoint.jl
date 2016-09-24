doc"""
    TwoPoint(p,v1,v2)

    The Two point distribution has mass concentrated on two points. The
    value `v1` is returned with probability `p` and the second with probability `(1-p)`.
"""

immutable TwoPoint{T<:Real,V} <: DiscreteUnivariateDistribution
    p::T  # probability of getting first value
    v1::V # value returned with probability p
    v2::V # value returned with probability 1-p    
end

TwoPoint(p::Integer,v1,v2) = TwoPoint(Float64(p),v1,v2)

#### Sampling

rand(d::TwoPoint) = rand() < d.p ? d.v1 : d.v2

#### Parameters

params(d::TwoPoint) = (d.p,d.v1,d.v2)

@inline partype{T<:Real,V}(d::TwoPoint{T,V}) = (T,V)

