"""Gets neighboring nodes of the current intersection"""
function neighbors(current_junction, streets, durations, total_duration, car)
    candidates = [
        (s, street) for (s, street) in enumerate(streets) if (
            HashCode2014.is_street_start(current_junction, street) &&
            durations[car] + street.duration <= total_duration
        )
    ]
    # sort!(candidates, by=street.duration)
    ans = []
    for i in 1:length(candidates)
        best = (0, 0)
        del = 0
        for street in candidates
            if street[2].distance > best[1]
                best = (street[2].distance, street[2])
                del = street
            end
        end
        push!(ans, best[2])
        deleteat!(candidates, findall(x -> x == del, candidates))
    end
    return ans
end
