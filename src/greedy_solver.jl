"""
    Similar to Guillame's solution execpt much faster on a SimpleWeightedDiGraph so runtime is much faster...
"""
function greedy_sol(city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city

    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    graph = DiGraphFormat(city)

    start = starting_junction

    for c in 1:nb_cars
        time_left = total_duration
        itin = Vector{Int}(undef, 1)
        itin[1] = start
        while time_left > 100
            current = last(itin)
            possible = outneighbors(graph, current)
            if isempty(possible)
                break
            else
                choice = rand(possible)
                push!(itin, choice)
                time_left -= graph.weights[choice, current]
            end
        end

        new_itin = city.streets[itin]
        itineraries[c] = itin
    end
    return Solution(itineraries)
end

# plot_streets(paris, greedy_sol(paris), path="./map1.html")
# write_solution(greedy_sol(paris), "./outut_solution.txt")
# using BenchmarkTools
# @benchmark greedy_sol(paris)
# @benchmark HashCode2014.random_walk(paris)
