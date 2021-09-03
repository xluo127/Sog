using Sog
using Test
using Random

@testset "MyPkg0.jl" begin
    @test isequal(sog(), nothing)
    @test isequal(sog([]), nothing)
    @test isequal(sog(['o']), Bool[1])
    @test isequal(sog(["one"]), Bool[1])
    @test isequal(sog(["one", "two", "one", "one", "two"]), Bool[1, 1, 1, 0, 1])
    Random.seed!(127)
    @test isequal(sog(rand(1:10, 20)), Bool[1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1])
    @test isequal(sog([missing, missing, missing]), Bool[1, 0, 0])
    @test isequal(sog([missing, 1, missing, missing, 1, 1]), Bool[1, 1, 1, 0, 1, 0])
    @test isequal(sog(["a", "a", "a", 'a']), Bool[1, 0, 0, 1])
    @test isequal(sog([1, 1.0, 1.00000]), Bool[1, 0, 0])
    @test isequal(sog([Inf, Inf32, Inf64]), Bool[1, 0, 0])

    #For Vectors
    @test isequal(sog([[], []]),nothing)
    @test isequal(sog([[1, 1, 1, 2, 2], [1.5, 1.5, 20.0, 3.0, 3.0]]), Bool[1, 0, 1, 1, 0])
    @test isequal(sog([["abc", "ab", "ab"],["ab", "ab", "ab"]]), Bool[1, 1, 0])
    #@time sog(rand(1:100, 10^6))
    #xxx = [round.(rand(10^6)), rand(1:10, 10^6), [randstring('a':'e', 2) for _ in 1:10^6]]
    #@time sog(xxx)
end
