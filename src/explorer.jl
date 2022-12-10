"""
explorer_1d (neighbors, seen, current_junc)

Base case for our recursion explorer. Checks if the street has been taken previously. Returns the unseen street with the largest ‘distance/duration’ as a list of [total distance, (street end, duration, distance)].
 :)
"""
function explorer_1d(neighbors, seen, current_junc)
    best = (0.0, (0, 0, 0))
    for neighbor in neighbors # for each (end, duration, distance) tuple in the neighbors
        street_end, duration, distance = neighbor
        if Set([current_junc, street_end]) ∈ seen # check if we have seen the street
            continue
        elseif distance / duration > best[1]
            best = (1 / 11 * (distance / duration), neighbor)
        end
    end
    return best# return [total distance, (end, duration, distance)] that is best to take
end
"""
explorer_nd(neighbors, seen, current_junc, graph, depth)

Explores some arbitrary ‘depth’ of our graph using recursion. Calls in [‘explorer_1d’](@ref). Sums the ‘distance/duration’ for each unseen street and finds the largest overall speed. Returns a list of [total distance, (street end, duration, distance)]. :)
"""
function explorer_nd(neighbors, seen, current_junc, graph, depth)
    best = (0.0, (0, 0, 0))
    for neighbor in neighbors # for each (end, duration, distance) tuple in the neighbors
        street_end, duration, distance = neighbor
        neighbor_list = graph[street_end]
        if depth == 1
            base_best = explorer_1d(neighbor_list, seen, street_end)
        else
            base_best = explorer_nd(neighbor_list, seen, street_end, graph, depth - 1)
        end
        if Set([current_junc, street_end]) ∉ seen # check if we have seen the street
            base_best = (
                (base_best[1] + depth^(1 / 2.9) / 11 * (distance / duration)), neighbor
            )
        else
            base_best = (base_best[1], neighbor)
        end
        if base_best[1] > best[1]
            best = base_best
        end
    end
    return best# return [total distance, (end, duration, distance)] that is best to take
end
