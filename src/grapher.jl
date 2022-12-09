"""
Creates our own graph instance so that we don't have to recompute things so many times. :)
"""
function create_graph(city::City)
    graph = Dict{Int,Vector{Tuple{Int,Int,Int}}}()# {start_junc: [(end_junc, duration, distance)]}
    for street in city.streets
        first_junc, second_junc = street.endpointA, street.endpointB # endpoints
        distance, duration = street.distance, street.duration # dist, duration
        data = (second_junc, duration, distance) # street forward
        if first_junc ∈ keys(graph)
            push!(graph[first_junc], data)
        else
            graph[first_junc] = [data]
        end
        if street.bidirectional # checks two way street
            back = (first_junc, duration, distance)
            if second_junc ∈ keys(graph)
                push!(graph[second_junc], back)
            else
                graph[second_junc] = [back]
            end
        end
    end
    return graph
end
