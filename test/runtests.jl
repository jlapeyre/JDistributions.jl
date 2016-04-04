using JDistributions
using Base.Test

@test typeof(rand(SymBernoulli)) == Int
