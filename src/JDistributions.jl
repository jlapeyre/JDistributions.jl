module JDistributions

# These distributions should work like the following:
# rand(dist)  --> one sample
# rand(dist,n1,n2,...) --> return n1xn2x... array of samples
# rand(dist,A) --> fill Array (multidimensional) with samples

export Pareto, SymBernoulli, Delta, rand

##### Pareto

# Usage:
#  p = Pareto(1.0,2.0)
#  rand(p)
#  rand(p,n)

immutable Pareto
    alpha
    r0
end

function Base.copy(d::Pareto)
    Pareto(d.alpha,d.r0)
end

function Base.Random.rand(p::Pareto)
   return p.r0 * rand()^(-1/p.alpha)
end

function Base.Random.rand!(p::Pareto,a)
    for i in 1:length(a)
        @inbounds a[i] = rand(p)
    end
    return a
end

Base.Random.rand(p::Pareto,n::Int) = rand!(p,zeros(n))

##### SymBernoulli.  Symmetric Bernoulli Distribution, returns  -1 and +1 (integers) with equal probability

# Usage:
# rand(SymBernoulli)    # return one sample
# rand(SymBernoulli,n)  # return n samples
# rand(SymBernoulli,A)  # fill array A with samples

type SymBernoulli
end

function Base.Random.rand(rng,::Type{SymBernoulli})
    2*rand(rng,Bool) - 1
end


function Base.Random.rand(::Type{SymBernoulli},d1::Int,dims::Int... )
    dims = tuple(d1,dims...)
    a = Array(Int,dims...)
    Base.Random.rand!(SymBernoulli,a)
end


function Base.Random.rand!(::Type{SymBernoulli},a)
    for i in 1:length(a)
        a[i] = rand(SymBernoulli)
    end
    a    
end

Base.Random.rand(::Type{SymBernoulli},n::Int) = Base.Random.rand!(SymBernoulli,Array(Int,n))

##### Delta distribution returns constant value

type Delta
    c
end

Base.Random.rand(rng,d::Delta) = d.c
Base.Random.rand(d::Delta) = d.c

function Base.Random.rand!(d::Delta,a)
    fill!(a,d.c)
end

function Base.Random.rand(d::Delta, d1::Int, dims::Int... )
    dims = tuple(d1,dims...)
    a = Array(typeof(d.c),dims...)
    rand!(d,a)
end



end # module
