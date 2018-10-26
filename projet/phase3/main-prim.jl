# On va chercher le graphe créer par  le main de la phase 1
# include("../phase1/main.jl")

# Si on veut tester avec l'exemple du cours
include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase2/exemple-laboratoire.jl")

include("priority_item.jl")
include("queue.jl")


include("prim.jl")

A = prim(G);

show(A)
