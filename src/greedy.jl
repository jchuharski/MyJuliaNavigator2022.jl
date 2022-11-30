# using HashCode2014
# include("neighbors.jl")
# export neighbors
# function greedy(city::City)
#     (; total_duration, nb_cars, starting_junction, streets) = city
#     itineraries = Vector{Vector{Int}}(undef, nb_cars)
#     durations = Vector{Int}(undef, nb_cars)
#     for i in 1:nb_cars
#         itineraries[i] = [starting_junction]
#         durations[i] = 0
#     end
#     while true
#         for c in 1:nb_cars
#         end
#         break
#     end
#     return print(neighbors(starting_junction, streets, durations, total_duration, 1))
# end

function greedy(city::City)
    (; total_duration, nb_cars, starting_junction, streets) = city
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    durations = Vector{Int}(undef, nb_cars)
    for c in 1:nb_cars
        itinerary = [starting_junction]
        duration = 0
        count = 0
        while true
            current_junction = last(itinerary)
            candidates = neighbors(current_junction, streets, durations, total_duration, c)
            if isempty(candidates)
                break
            elseif count == 1000
                break
            else
                if length(candidates) > 1
                    street = candidates[rand(1:2)]
                else
                    street = candidates[1]
                end
                next_junction = HashCode2014.get_street_end(current_junction, street)
                push!(itinerary, next_junction)
                duration += street.duration
            end
            count += 1
        end
        itineraries[c] = itinerary
    end
    return Solution(itineraries)
end
# greedy(read_city())
# plot_streets(read_city(), greedy(read_city()), path = "map.html")
