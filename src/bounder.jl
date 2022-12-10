"""
Finds an upper bound for the possible distance traversed by sorting all streets by their 
distance (largest to smallest) and adding the streets until either the total time multiplied 
by the number of cars or the total distance is reached. Uses HashCode2014 to get streets and 
Returns the total distance traversed.
"""

function upper_bound_distance(city::City; short=false)
    if short
        pos_dur = 18000
    else
        pos_dur = city.total_duration
    end
    total_time = 0.0
    total_distance = 0.0
    possible_time = pos_dur * city.nb_cars
    streets = sort(city.streets; by=street -> street.distance, rev=true)
    for street in streets
        if total_time < possible_time
            total_time += street.duration
            total_distance += street.distance
        else
            break
        end
    end
    return total_distance
end

"""
Finds an upper bound for the possible distance traversed by sorting all streets by their distance/duration (largest to smallest) and adding the streets until either the total time multiplied by the number of cars or the total distance is reached. Returns the total distance traversed.
"""

function upper_bound_speed(city::City; short=false)
    if short
        pos_dur = 18000
    else
        pos_dur = city.total_duration
    end
    total_time = 0.0
    total_distance = 0.0
    possible_time = city.nb_cars * pos_dur
    streets = sort(city.streets; by=street -> street.distance / street.duration, rev=true)
    for street in streets
        if total_time + street.duration < possible_time
            total_time += street.duration
            total_distance += street.distance
        else
            break
        end
    end
    return total_distance
end
