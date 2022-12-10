
# using HashCode2014
# using MyJuliaPackage

# city = HashCode2014.read_city()
# sol = MyJuliaPackage.gred(city; depth=10)
# print(HashCode2014.is_feasible(sol, city))
# print(HashCode2014.total_distance(sol, city))

# @code_warntype MyJuliaPackage.total_distance(sol.itineraries, graph)
# @code_warntype MyJuliaPackage.gred(city)
# graph = create_graph(city)
# seen = Set{Set{Int64}}()
# current_junction = 4517
# neighbors = graph[current_junction]
# depth = 2
# @code_warntype MyJuliaPackage.explorer_nd(neighbors, seen, current_junction, graph, depth)

# #OUTPUT SOLN#
# HashCode2014.plot_streets(city, sol; path="map1864255.html")
# HashCode2014.write_solution(sol, "sol1864255.txt")

# # bound

# infeasible = MyJuliaPackage.bidirectional_graph(city)
# upper_bound_distance(city; short=true)
# upper_bound_speed(city; short=true)
