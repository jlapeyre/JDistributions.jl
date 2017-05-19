using JDistributions
using Base.Test

@test typeof(rand(SymBernoulli)) == Int

@test rand(Delta(1)) == 1
@test rand(Delta("cat")) == "cat"

@test (rand(Pareto(1.0,1.0)); true)

@test (rand(SymBernoulli); true)
@test (rand(SymBernoulli()); true)

@test mean(SymBernoulli()) == 0
@test moment(SymBernoulli(),1) == 0
@test moment(SymBernoulli(),2) == 1

@test (rand(TwoPoint(.5,1,2)); true)

@test (rand(InverseExponential()); true)

@test params(InverseExponential(2.0)) == (2.0,)

@test (rand(GeneralizedGamma()); true)

@test (rand(JExponential()); true)

if Int != Int32
    @test_approx_eq mean(JExponential()) 1.0
else
    @test_approx_eq_eps mean(JExponential()) 1.0 1e-9
end
