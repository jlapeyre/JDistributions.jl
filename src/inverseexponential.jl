doc"""
    InverseExponential(θ)

A random variable `X` has the *inverse exponential distribution* with
parameter `θ` if `Y = 1/X` has the `Exponential distribution` with parameter `θ`.


```julia
InverseExponential()   # equivalent to InverseExponential(1.0)
params(d)              # get the parameter (`θ`,).
```

The inverse exponential distribution has no mean.
"""

immutable InverseExponential <: ContinuousUnivariateDistribution
    θ::Float64
    ed::Exponential
end

InverseExponential(a::Float64)  = InverseExponential(a,Exponential(a))

InverseExponential{T<:Real}(a::T) = InverseExponential(Float64(a))

InverseExponential()  = InverseExponential(1.0)

support(d::Union{InverseExponential,Type{InverseExponential}}) = RealInterval(0.0,Inf)

#### Sampling

function rand(d::InverseExponential)
    x = rand(d.ed)
    1/x
end

#### Parameters

params(d::InverseExponential) = (d.ed.θ,)

#### Statistics

function moment(d::InverseExponential, k::Float64)
    k  >= 1 && throw(DomainError())
    d.ed.θ^k * gamma(1-k)
end

mean(d::InverseExponential) = Inf

#### Display

Base.show(io::IO, d::InverseExponential) = _show_all_but_last(io,d)
