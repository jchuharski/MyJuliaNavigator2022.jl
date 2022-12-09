# city = read_city()
# G = DiGraphFormat(read_city())
# ans = Graphs.non_backtracking_randomwalk(G, 1, 2^40)
# print(length(ans))
# (; total_duration, nb_cars, starting_junction, streets) = city
# itineraries = Vector{Vector{Int}}(undef, nb_cars)
# for c in 1:nb_cars
#     itineraries[c] = ans
# end
# sol = Solution(itineraries)
# plot_streets(city, sol, path = "map.html")
# using HashCode2014
# export greedy_sol
# include("../src/greedy_solver.jl")
# export DiGraphFormat
# include("../src/graph_format.jl")
# using Graphs
# using SimpleWeightedGraphs

using HashCode2014
using MyJuliaPackage

city = HashCode2014.read_city()
sol = MyJuliaPackage.gred(city)
@code_warntype MyJuliaPackage.gred(city)

graph = create_graph(city)
seen = Set{Set{Int64}}()
current_junction = 4517
neighbors = graph[current_junction]
depth = 2
@code_warntype MyJuliaPackage.explorer_nd(neighbors, seen, current_junction, graph, depth)
# HashCode2014.is_feasible(sol, city)
print(HashCode2014.is_feasible(sol, city))
# print(MyJuliaPackage.grace_rec(city) == MyJuliaPackage.grace_d2(city))
HashCode2014.plot_streets(city, sol; path="map.html")
HashCode2014.write_solution(sol, "bestsol.txt")
# HashCode2014.read_solution("feasible_sol_basic.txt")
# graph = MyJuliaPackage.create_graph(city)
# print(MyJuliaPackage.total_distance(sol.itineraries, graph))
print(HashCode2014.total_distance(sol, city))

# print(MyJuliaPackage.corners(city))
# graph = DiGraphFormat(city)
# sols = [[4517], [4517], [4517], [4517],
# enumerate_paths(dijkstra_shortest_paths(graph, 4517), 7847),
# enumerate_paths(dijkstra_shortest_paths(graph, 4517), 533),
# enumerate_paths(dijkstra_shortest_paths(graph, 4517), 4507),
# enumerate_paths(dijkstra_shortest_paths(graph, 4517), 2510)
#  ]
#  sol = HashCode2014.Solution(sols)
#  HashCode2014.is_feasible(sol, city)
#  HashCode2014.plot_streets(city, sol, path ="map.html")
# most = 0
# for n in values(graph)
#     if length(n) > most
#         most = length(n)
#     end
# end
# print(most)
