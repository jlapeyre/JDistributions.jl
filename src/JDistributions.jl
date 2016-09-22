module JDistributions
using Distributions

# These distributions should work like the following:
# rand(dist)  --> one sample
# rand(dist,n1,n2,...) --> return n1xn2x... array of samples
# rand(dist,A) --> fill Array (multidimensional) with samples

import Base.Random
import Base: rand, rand!, median, mean, copy

export Pareto, SymBernoulli, Delta, JExponential, TwoPoint

export rand, params, partype

include("twopoint.jl")

##### Pareto

# Distribution
# rho(r) = α * r0^α r^(-α-1),  for r >= r0, alpha > 0
#          0,  otherwise
# rho(r) has no mean for 0<α<1

# Usage:
#  p = Pareto(1.0,2.0)
#  rand(p)
#  rand(p,n)

# I noticed lots of allocation using this in routines (depends on how it is used)
# Adding type annotation Float64 fixed this problem.
# Testing sums of large numbers of these now allcates 200 bytes rather than 7GB
immutable Pareto <: ContinuousUnivariateDistribution
    alpha::Float64
    r0::Float64
end

Pareto(alpha) = Pareto(alpha,1.0)

copy(d::Pareto) = Pareto(d.alpha,d.r0)

median(d::Pareto) = d.r0 * 2.0^(1.0/d.alpha)

mean(d::Pareto) = d.alpha < 1.0 ? Inf : d.alpha/(d.alpha-1) * d.r0

rand(p::Pareto) = p.r0 * rand()^(-one(p.alpha)/p.alpha)

# Not needed because we are subtyping from Distributions
# function rand!(p::Pareto,a)
#     for i in 1:length(a)
#         @inbounds a[i] = rand(p)
#     end
#     return a
# end

# rand(p::Pareto,n::Int) = rand!(p,zeros(n))

##### SymBernoulli.  Symmetric Bernoulli Distribution, returns  -1 and +1 (integers) with equal probability

# Usage:
# rand(SymBernoulli)    # return one sample
# rand(SymBernoulli,n)  # return n samples
# rand!(SymBernoulli,A)  # fill array A with samples

immutable SymBernoulli <: Distribution
end

rand(rng,::Type{SymBernoulli}) =  2*rand(rng,Bool) - 1
rand(::Type{SymBernoulli}) =  2*rand(Bool) - 1
mean(::Type{SymBernoulli}) =  0

function rand(::Type{SymBernoulli},d1::Int,dims::Int... )
    dims = tuple(d1,dims...)
    a = Array(Int,dims...)
    rand!(SymBernoulli,a)
end

function rand!(::Type{SymBernoulli},a)
    for i in 1:length(a)
        @inbounds  a[i] = rand(SymBernoulli)
    end
    a    
end

rand(::Type{SymBernoulli},n::Int) = rand!(SymBernoulli,Array(Int,n))

##### Delta distribution returns constant value

immutable Delta{T} <: Distribution
    c::T
end

function Base.copy(d::Delta)
    Delta(d.c)
end

rand(rng,d::Delta) = d.c
rand(d::Delta) = d.c

function rand!(d::Delta,a)
    fill!(a,d.c)
end

function rand(d::Delta, d1::Int, dims::Int... )
    dims = tuple(d1,dims...)
    a = Array(typeof(d.c),dims...)
    rand!(d,a)
end

#### Exponential. This is in Distributions
# But, I include it here because @parallel + Distributions are giving me hell

immutable JExponential <: Distribution
    θ::Float64
end

copy(d::JExponential) = JExponential(d.θ)
rand(d::JExponential) = - d.θ * log(1- rand())
mean(d::JExponential) = d.θ

function rand(p::JExponential,d1::Int,dims::Int... )
    dims = tuple(d1,dims...)
    a = Array(Int,dims...)
    rand!(p,a)
end

function rand!(p::JExponential,a)
    for i in 1:length(a)
        @inbounds a[i] = rand(p)
    end
    a    
end

rand(p::JExponential,n::Int) = rand!(p,Array(typeof(p.θ),n))


end # module
