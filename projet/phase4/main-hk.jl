# On a besoin de la fonction norm pour le critère d'arrêt de l'algorithme HK
using LinearAlgebra

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

# On va chercher l'algorithme de HK
include("step_size.jl")
include("hk.jl")

# On cherche une tournée minimale et son poids
# println("la tournée obtenu par l'algo HK est: ")
# A, w, W, d, v, t, π1, poids = hk(G, step_size = period_step_size);
A, poids, ordre = hk(G, step_size = period_step_size, algorithm_mst = prim);
# println("son poids est: $poids")
# println("Fin!")
