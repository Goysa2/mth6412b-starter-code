include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("composante_connexe.jl")

first_node = Node("Première", 2)
second_node = Node("Deuxième", 10)
third_node = Node("Troisième", 141)

edge_1_2 = Edge(first_node, second_node, 4)
edge_2_3 = Edge(second_node, third_node, 256)

G_1 = Graph("premier-graphe", [first_node, second_node, third_node], Vector{Edge{Int64}}())
G_2 = Graph("second-graphe", [first_node, second_node, third_node], [edge_1_2])
G_3 = Graph("troisième-graphe", [first_node, second_node, third_node], [edge_1_2, edge_2_3])
G_4 = Graph("quatrième-graphe", [first_node], Vector{Edge{Int64}}())
