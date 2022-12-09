using Aqua
using Documenter
using MyJuliaPackage
using JuliaFormatter
using Test
using HashCode2014
using BenchmarkTools

DocMeta.setdocmeta!(MyJuliaPackage, :DocTestSetup, :(using MyJuliaPackage); recursive=true)

@testset verbose = true "MyJuliaPackage.jl" begin
    @testset verbose = true "Code quality (Aqua.jl)" begin
        Aqua.test_all(MyJuliaPackage; ambiguities=false)
    end

    @testset verbose = true "Code formatting (JuliaFormatter.jl)" begin
        @test format(MyJuliaPackage; verbose=true, overwrite=true)
    end

    @testset verbose = true "Doctests (Documenter.jl)" begin
        doctest(MyJuliaPackage)
    end

    @testset verbose = true "Feasible?" begin
        city = HashCode2014.read_city()
        sol = MyJuliaPackage.gred(city)
        @test HashCode2014.is_feasible(sol, city) == true
    end
    @testset verbose = true "graph creation" begin
        city = HashCode2014.City(;
            total_duration=10,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(city)
        check = Dict(2 => [(1, 1, 1)], 1 => [(2, 1, 1), (3, 1, 2)])
        @test graph == check
    end
end
