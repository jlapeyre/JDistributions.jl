module JDistributions

# These distributions should work like the following:
# rand(dist)  --> one sample
# rand(dist,n1,n2,...) --> return n1xn2x... array of samples
# rand(dist,A) --> fill Array (multidimensional) with samples

import Base.Random
import Base: rand, rand!

export Pareto, SymBernoulli, Delta, JExponential, rand

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
immutable Pareto
    alpha::Float64
    r0::Float64
end

function Base.copy(d::Pareto)
    Pareto(d.alpha,d.r0)
end

function rand(p::Pareto)
   return p.r0 * rand()^(-one(p.alpha)/p.alpha)
end

# function Base.Random.rand(p::Pareto)
#    return p.r0 * rand()^(-one(p.alpha)/p.alpha)
# end

function rand!(p::Pareto,a)
    for i in 1:length(a)
        @inbounds a[i] = rand(p)
    end
    return a
end

rand(p::Pareto,n::Int) = rand!(p,zeros(n))

##### SymBernoulli.  Symmetric Bernoulli Distribution, returns  -1 and +1 (integers) with equal probability

# Usage:
# rand(SymBernoulli)    # return one sample
# rand(SymBernoulli,n)  # return n samples
# rand(SymBernoulli,A)  # fill array A with samples

type SymBernoulli
end

function rand(rng,::Type{SymBernoulli})
    2*rand(rng,Bool) - 1
end


function rand(::Type{SymBernoulli},d1::Int,dims::Int... )
    dims = tuple(d1,dims...)
    a = Array(Int,dims...)
    rand!(SymBernoulli,a)
end


function rand!(::Type{SymBernoulli},a)
    for i in 1:length(a)
        a[i] = rand(SymBernoulli)
    end
    a    
end

rand(::Type{SymBernoulli},n::Int) = rand!(SymBernoulli,Array(Int,n))

##### Delta distribution returns constant value

type Delta
    c::Float64
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

immutable JExponential
    θ::Float64
end

function Base.copy(d::JExponential)
   JExponential(d.θ)
end

function rand(d::JExponential)
   return - d.θ * log(1- rand())
end

# function Base.Random.rand!(d::JExponential,a)
#     for i in 1:length(a)
#         @inbounds a[i] = rand(d)
#     end
#     return a
# end

function rand(p::JExponential,d1::Int,dims::Int... )
    dims = tuple(d1,dims...)
    a = Array(Int,dims...)
    rand!(p,a)
end


function rand!(p::JExponential,a)
    for i in 1:length(a)
        a[i] = rand(p)
    end
    a    
end

rand(p::JExponential,n::Int) = rand!(p,Array(typeof(p.θ),n))


end # module
