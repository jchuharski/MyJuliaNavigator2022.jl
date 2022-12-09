"""
Base case for the recursion explorer. Checks just the best distance/duration in the set of streets we haven't traversed. :)
"""
function explorer_1d(neighbors, seen, current_junc)
    best = (0.0, (0, 0, 0))
    for neighbor in neighbors # for each (end, duration, distance) tuple in the neighbors
        street_end, duration, distance = neighbor
        if Set([current_junc, street_end]) ∈ seen # check if we have seen the street
            continue
        elseif distance / duration > best[1]
            best = (distance / duration, neighbor)
        end
    end
    return best# return [total distance, (end, duration, distance)] that is best to take
end
"""
Explores arbitrary depth of the graph using recursion. Sums distance/duration to get the best overall speed. :)
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
            base_best = (base_best[1] + distance / duration, neighbor)
        else
            base_best = (base_best[1], neighbor)
        end
        if base_best[1] > best[1]
            best = base_best
        end
    end
    return best# return [total distance, (end, duration, distance)] that is best to take
end
