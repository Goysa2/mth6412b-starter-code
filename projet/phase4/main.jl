# On va chercher le graphe créer par  le main de la phase 1
include("../phase1/main.jl")

# On va chercher les fonctions
include("../phase3/priority_item.jl")
include("../phase3/queue.jl")

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
A₂, poids = rsl(G);
println("le poids de la tournée est $poids")
println("Fin!")
