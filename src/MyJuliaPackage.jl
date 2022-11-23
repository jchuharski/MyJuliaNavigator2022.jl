module MyJuliaPackage

using HashCode2014
using Graphs
using SimpleWeightedGraphs

export DiGraphFormat
export greedy
export greedy_sol
include("greedy.jl")
include("greedy_solver.jl")
include("graph_format.jl")

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
city = read_city()
sol = greedy_sol(read_city())
# HashCode2014.is_feasible(sol, city)
print(HashCode2014.is_feasible(sol, city))
# plot_streets(city, sol, path = "mmap.html")
# HashCode2014.write_solution(sol, "feasible_sol_basic.txt")

end
