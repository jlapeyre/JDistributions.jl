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
    ed::Exponential
end

InverseExponential(a::Float64)  = InverseExponential(Exponential(a))

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

#### Display

function Base.show(io::IO, d::InverseExponential)
    print(io, Distributions.distrname(d))
    print(io, '(')
    print(io, 'θ')
    print(io, '=')
    show(io, d.ed.θ)
    print(io, ')')
end
