"""
total_distance(itineraries, graph)

Takes an array of ‘itineraries’ and returns the total distance traversed by the list of itineraries. :)
"""
function total_distance(itineraries, graph)
    visited = Set{Set{Int64}}()
    total_distance = 0
    cars = length(itineraries)
    for car in 1:cars
        intinerary = itineraries[car]
        for i in 1:(length(intinerary) - 1)
            start = intinerary[i]
            finish = intinerary[i + 1]
            neighbors = graph[start]
            distance = 0
            for neighbor in neighbors
                if neighbor[1] == finish
                    distance = neighbor[3]
                    break
                end
            end
            if Set([start, finish]) ∉ visited
                total_distance += distance
            end
            push!(visited, Set([start, finish]))
        end
    end
    return total_distance
end
