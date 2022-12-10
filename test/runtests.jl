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
        sol = MyJuliaPackage.gred(city; depth=2)
        @test HashCode2014.is_feasible(sol, city) == true
    end
    @testset verbose = true "graph creation" begin
        fake_city = HashCode2014.City(;
            total_duration=10,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(fake_city)
        check = Dict(2 => [(1, 1, 1)], 1 => [(2, 1, 1), (3, 1, 2)])
        @test graph == check
    end
    @testset verbose = true "bidirectional graph creation" begin
        fake_city = HashCode2014.City(;
            total_duration=10,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.bidirectional_graph(fake_city)
        check = Dict(2 => [(1, 1, 1)], 1 => [(2, 1, 1), (3, 1, 2)], 3 => [(1, 1, 2)])
        @test graph == check
    end
    @testset verbose = true "lowest duration neighbors" begin
        fake_city = HashCode2014.City(;
            total_duration=10,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 3, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(fake_city)
        check = (2, 1, 1)
        @test MyJuliaPackage.lowest_dur_neighbor(graph[1]) == check
    end

    @testset verbose = true "lowest duration neighbors 2" begin
        fake_city = HashCode2014.City(;
            total_duration=10,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(fake_city)
        check = (2, 1, 1)
        @test MyJuliaPackage.lowest_dur_neighbor(graph[1]) == check
    end

    @testset verbose = true "explore 1d forward" begin
        fake_city = HashCode2014.City(;
            total_duration=10,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(fake_city)
        check = (2 / 11, (3, 1, 2))
        @test MyJuliaPackage.explorer_1d(graph[1], Set{Set{Int64}}(), 1)[1] ≈ check[1]
    end

    @testset verbose = true "explore nd base case" begin
        fake_city = HashCode2014.City(;
            total_duration=10,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(fake_city)
        check = (3 / (11), (3, 1, 2))
        @test MyJuliaPackage.explorer_nd(graph[2], Set{Set{Int64}}(), 2, graph, 1)[1] ≈
            check[1]
    end

    @testset verbose = true "bounds speed" begin
        fake_city = HashCode2014.City(;
            total_duration=1,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 1, 1),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(fake_city)
        check = 2
        @test MyJuliaPackage.upper_bound_speed(fake_city) == check
    end

    @testset verbose = true "bounds distance" begin
        fake_city = HashCode2014.City(;
            total_duration=1,
            nb_cars=2,
            starting_junction=1,
            junctions=[],
            streets=[
                HashCode2014.Street(1, 2, true, 3, 3),
                HashCode2014.Street(1, 3, false, 1, 2),
            ],
        )
        graph = MyJuliaPackage.create_graph(fake_city)
        check = 3
        @test MyJuliaPackage.upper_bound_distance(fake_city) == check
    end
end
