"""
create_graph(city::City)

Creates our own graph instance using a dictionary. Goes through the streets in the ‘city.streets’ from HashCode2014.jl. Makes the keys of the dictionary the first junction of each street and makes the values of each key a list of all neighboring streets. Each neighboring street is a tuple listed as (end junction, duration (of the street between the first junction and the end junction), distance). Checks if the streets are bidirectional and will create the tuple and add that into the list of neighbors. :)

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

"""
Creates a second graph instance using a dictionary. 
Goes through the streets in the city.streets from HashCode2014.jl. 
Makes the keys of the dictionary the first junction of each street 
and makes the values of each key a list of all neighboring streets. 
Each neighboring street is a tuple listed as (end junction, duration 
(of the street between the first junction and the end junction), distance). 
Automatically makes every street bidirectional. Returns a dictionary of {start_junc: 
[(end_junc, duration, distance)]}. :)
"""

function bidirectional_graph(city::City)
    graph = Dict{Int,Vector{Tuple{Int,Int,Int}}}()# {start_junc: [(end_junc, duration, distance)]}
    for street in city.streets
        first_junc, second_junc = street.endpointA, street.endpointB # endpoints
        distance, duration = street.distance, street.duration # dist, duration
        forward_street = (second_junc, duration, distance)
        if first_junc ∈ keys(graph)
            push!(graph[first_junc], forward_street)
        else
            graph[first_junc] = [forward_street]
        end
        backward_street = (first_junc, duration, distance)
        if second_junc ∈ keys(graph)
            push!(graph[second_junc], backward_street)
        else
            graph[second_junc] = [backward_street]
        end
    end
    return graph
end
