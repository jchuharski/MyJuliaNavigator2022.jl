
using HashCode2014
using MyJuliaPackage

city = HashCode2014.read_city()
sol = MyJuliaPackage.gred(city; depth=12)
print(HashCode2014.is_feasible(sol, city))
print(HashCode2014.total_distance(sol, city))

@code_warntype MyJuliaPackage.total_distance(sol.itineraries, graph)
@code_warntype MyJuliaPackage.gred(city)
graph = create_graph(city)
seen = Set{Set{Int64}}()
current_junction = 4517
neighbors = graph[current_junction]
depth = 2
@code_warntype MyJuliaPackage.explorer_nd(neighbors, seen, current_junction, graph, depth)

#OUTPUT SOLN#
HashCode2014.plot_streets(city, sol; path="map1864255.html")
HashCode2014.write_solution(sol, "sol1864255.txt")

# bound

infeasible = MyJuliaPackage.bidirectional_graph(city)
upper_bound_distance(city; short=true)
upper_bound_speed(city; short=true)

# @time MyJuliaPackage.gred(city)

fake_city = HashCode2014.City(;
    total_duration=10,
    nb_cars=2,
    starting_junction=1,
    junctions=[],
    streets=[
        HashCode2014.Street(1, 2, true, 1, 1),
        HashCode2014.Street(1, 3, false, 1, 2),
        HashCode2014.Street(3, 2, false, 10, 4),
    ],
)
graphy = MyJuliaPackage.create_graph(fake_city)
MyJuliaPackage.explorer_nd(graphy[1], Set{Set{Int64}}(), 1, graph, 2)
