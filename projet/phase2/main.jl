# On va chercher le graphe créer par  le main de la phase 1
include("../phase1/main.jl")

# On va chercher l'algorithme de Kruskal et les nouvelles structures
# et fonctions qu'on a définie
cd("../phase2/")
include("composante_connexe.jl")
include("kruskal.jl")

# On construit l'arbre de recouvrement minimal avec l'algorithme de kruskal
A₂ = kruskal(G)
show(A₂)
