"""
Creates a simple SimpleWeightedDiGraph structure that inherits Junctions as nodes and Streets as edges, and the weights are calculated by distance/duration
"""
function DiGraphFormat(city::City)
    dG = SimpleWeightedDiGraph(length(city.junctions))
    for street in city.streets
        add_edge!(dG, street.endpointA, street.endpointB, street.duration)
        if street.bidirectional
            add_edge!(dG, street.endpointB, street.endpointA, street.duration)
        end
    end
    return dG
end
