using HashCode2014
include("neighbors.jl")
export neighbors
function greedy(city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    durations = Vector{Int}(undef, nb_cars)
    for i = 1:nb_cars
        itineraries[i] = [starting_junction]
        durations[i] = 0
    end
    while true
        for c in 1:nb_cars
            



        end
        break
    end
    print(neighbors(starting_junction, streets, durations, total_duration, 1))
end
greedy(read_city())