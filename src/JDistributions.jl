module JDistributions
using Distributions

import Base.Random
import Base: rand, rand!, median, mean

import Distributions: support, moment, params, partype

export Pareto, SymBernoulli, Delta, JExponential, TwoPoint, InverseExponential, GeneralizedGamma

export rand, params, partype, moment, support

include("pareto.jl")
include("twopoint.jl")
include("delta.jl")
include("symbernoulli.jl")
include("inverseexponential.jl")
include("gengamma.jl")

#### Display

# Don't show the internal distribution for some functions, only the parameters
function _show_all_but_last(io::IO, d)
    params = fieldnames(d)[1:end-1]
    Distributions.show(io,d,params)
end

#### Exponential. This is in Distributions
# But, I include it here because @parallel + Distributions are giving me hell

immutable JExponential <: ContinuousUnivariateDistribution
    θ::Float64
end

JExponential() = JExponential(1.0)

rand(d::JExponential) = - d.θ * log(1- rand())
mean(d::JExponential) = d.θ

end # module
