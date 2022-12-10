"""
gred(city::City)

Implements our greedy search with a weighted lookahead algorithm. Using BFS and [‘explorer_nd’](@ref) to look ahead from the start junction and pick the best path to take while still obeying time constraints. Does not weigh ‘seen’ streets in the best path calculation. Weighs the ‘distance/time’ of each street by the 2.9th root of the depth it was found at divided by 10. Returns a vector of ‘itineraries’ using [‘Solution’](@ref) in [‘HashCode2014’](@ref).  :)
"""
function gred(city::City; depth=10)
    (; total_duration, nb_cars, starting_junction, streets) = city
    graph = create_graph(city)
    itineraries = Vector{Vector{Int}}(undef, nb_cars)
    durations = Vector{Int}(undef, nb_cars)
    ender = false
    seen = Set{Set{Int64}}()  # set of Set{start_junc, end_junc} objects to keep track of streets that we have seen
    for i in 1:nb_cars
        itineraries[i] = [starting_junction]
        durations[i] = 0
    end
    while true
        if ender == true # looks for end condition
            break
        end
        for car in 1:nb_cars # all cars simultaneously 
            if durations[car] == total_duration
                continue
            end
            current_junc = last(itineraries[car]) # this gives us our next junction to look at
            neighbors = graph[current_junc] # list of (end_junc, duration, distance) tuples
            next_junc = explorer_nd(neighbors, seen, current_junc, graph, depth) # [total depth distance, (end_junc, duration, distance)]
            if next_junc[1] != 0.0
                street_end, duration, distance = next_junc[2]
                if durations[car] + duration <= total_duration
                    push!(itineraries[car], street_end) # update itinerary
                    push!(seen, Set([current_junc, street_end])) # update seen list
                    durations[car] += duration# update durations
                else
                    durations[car] = total_duration # update duration
                end
            else
                street_end, duration, distance = lowest_dur_neighbor(neighbors)
                if durations[car] + duration <= total_duration
                    push!(itineraries[car], street_end) # update itinerary
                    push!(seen, Set([current_junc, street_end])) # update seen list
                    durations[car] += duration# update durations
                else
                    durations[car] = total_duration # update duration
                end
            end
        end
        for i in 1:8 # check end conditions for outer while loop
            if durations[i] != total_duration
                break
            else
                ender = true
            end
        end
    end
    return Solution(itineraries)
end
