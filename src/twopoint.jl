doc"""
    TwoPoint{V}(p::Float64,v1::V,v2::V)

The Two point distribution has mass concentrated on two points. The
value `v1` is returned with probability `p` and the second with probability `(1-p)`.

```jldoctest
julia> d = TwoPoint(.5,"cat","dog")   # samples are "cat" and "dog" with equal probability
JDistributions.TwoPoint{String}(
p: 0.5
v1: cat
v2: dog
)
```
"""

immutable TwoPoint{V} <: DiscreteUnivariateDistribution
    p::Float64  # probability of getting first value
    v1::V # value returned with probability p
    v2::V # value returned with probability 1-p    
end

TwoPoint(p::Integer,v1,v2) = TwoPoint(Float64(p),v1,v2)

#### Sampling

rand(d::TwoPoint) = rand() < d.p ? d.v1 : d.v2

#### Parameters

params(d::TwoPoint) = (d.p,d.v1,d.v2)

@inline partype{V}(d::TwoPoint{V}) = (V,)

#### Statistics

mean{T<:Number}(d::TwoPoint{T}) = (d.p * d.v1 + d.p * d.v2)/convert(T,2)
