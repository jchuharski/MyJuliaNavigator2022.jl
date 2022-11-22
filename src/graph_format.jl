function DiGraphFormat(city::City)
    G = SimpleWeightedDiGraph(length(city.junctions))
    for street in city.streets
        add_edge!(G, street.endpointA, street.endpointB, street.distance)
        if street.bidirectional
            add_edge!(G, street.endpointB, street.endpointA, street.distance)
        end
    end
    return G
end

DiGraphFormat(read_city())
