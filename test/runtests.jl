using JDistributions
using Base.Test

@test typeof(rand(SymBernoulli)) == Int

@test rand(Delta(1)) == 1
@test rand(Delta("cat")) == "cat"

@test (rand(Pareto(1.0,1.0)); true)

@test (rand(SymBernoulli); true)
@test (rand(SymBernoulli()); true)

@test (rand(TwoPoint(.5,1,2)); true)

@test (rand(InverseExponential()); true)

@test params(InverseExponential(2.0)) == (2.0,)

@test (rand(GeneralizedGamma()); true)
