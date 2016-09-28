module JDistributions
using Distributions

import Base.Random
import Base: rand, rand!, median, mean

import Distributions: support

export Pareto, SymBernoulli, Delta, JExponential, TwoPoint, InverseExponential

export rand, params, partype, moment, support

include("pareto.jl")
include("twopoint.jl")
include("delta.jl")
include("symbernoulli.jl")
include("inverseexponential.jl")

#### Exponential. This is in Distributions
# But, I include it here because @parallel + Distributions are giving me hell

immutable JExponential <: ContinuousUnivariateDistribution
    θ::Float64
end

rand(d::JExponential) = - d.θ * log(1- rand())
mean(d::JExponential) = d.θ

end # module
