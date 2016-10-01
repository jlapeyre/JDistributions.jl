doc"""
  Pareto(alpha,x0)

  The Pareto distribution has probability density function

  f(x) = α * x0^α x^(-α-1), for x >= x0, alpha > 0
  0                       , otherwise
"""

immutable Pareto <: ContinuousUnivariateDistribution
    alpha::Float64
    x0::Float64
end

Pareto(alpha) = Pareto(alpha,1.0)
Pareto() = Pareto(1.0)

#### Sampling

rand(p::Pareto) = p.x0 * rand()^(-one(p.alpha)/p.alpha)

median(d::Pareto) = d.x0 * 2.0^(1.0/d.alpha)

mean(d::Pareto) = d.alpha < 1.0 ? Inf : d.alpha/(d.alpha-1) * d.x0
