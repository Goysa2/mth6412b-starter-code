# On va chercher le graphe créer par  le main de la phase 1
 # include("../phase1/main.jl")


 # Si on veut tester avec l'exemple du cours
include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase2/exemple-laboratoire.jl")

# On va chercher l'algorithme de Kruskal
include("../phase2/kruskal2.jl")

# On va chercher l'algorithme de Prim
include("../phase3/prim.jl")

#la fonction de parcours en pre ordre
include("parcours-preodre.jl")

# On va chercher l'algorithme de RSL
include("rsl.jl")

# On cherche une tournée minimale et son poids
println("la tournée donnée par l'algorithme RSL est: ")
A₂ = rsl(G);
println("Fin!")
