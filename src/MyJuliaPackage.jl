module MyJuliaPackage

using HashCode2014
using Graphs
using SimpleWeightedGraphs

export DiGraphFormat
export greedy
include("greedy.jl")

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
end
