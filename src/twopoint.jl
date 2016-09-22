doc"""
    TwoPoint(p,v1,v2)

    The Two point distribution has mass concentrated on two points.
"""

immutable TwoPoint{T<:Real,V} <: DiscreteUnivariateDistribution
    p::T  # probability of getting first value
    v1::V # value returned with probability p
    v2::V # value returned with probability 1-p    
end

TwoPoint(p::Integer,v1,v2) = TwoPoint(Float64(p),v1,v2)

# @distr_support Bernoulli 0 1

#### Conversions
# convert{T<:Real}(::Type{Bernoulli{T}}, p::Real) = Bernoulli(T(p))
# convert{T <: Real, S <: Real}(::Type{Bernoulli{T}}, d::Bernoulli{S}) = Bernoulli(T(d.p))

#### Parameters

# succprob(d::TwoPoint) = d.p
# failprob(d::TwoPoint) = 1 - d.p

params(d::TwoPoint) = (d.p,d.v1,d.v2)

@inline partype{T<:Real,V}(d::TwoPoint{T,V}) = (T,V)

#### Sampling

function rand(d::TwoPoint)
    if rand() < d.p
        d.v1
    else
        d.v2
    end
end
