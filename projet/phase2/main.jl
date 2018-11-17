# On va chercher le graphe créer par  le main de la phase 1
 include("../phase1/main.jl")

# Si on veut tester avec l'exemple du cours
# include("../phase1/node.jl")
# include("../phase1/edge.jl")
# include("../phase1/graph.jl")
# include("exemple-laboratoire.jl")

# On va chercher l'algorithme de Kruskal et les nouvelles structures
# et fonctions qu'on a définie
cd("../phase2/")
include("kruskal2.jl")

# On construit l'arbre de recouvrement minimal avec l'algorithme de kruskal
A₂ = kruskal2(G);
# println("no show")
printstyled("l'arbre de recouvrement final est: \n", color = :green)
show(A₂)
# show(Root)

# for node in nodes(A₂)
#     compression_chemin!(node)
# end
