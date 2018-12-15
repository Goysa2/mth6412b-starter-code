using LinearAlgebra

### On a ajoute les structures/fonctions nécessaires
include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase1/read_stsp.jl")

# On va chercher les fonctions
include("../phase3/priority_item.jl")
include("../phase3/queue.jl")

# On va chercher l'algorithme de Kruskal
include("../phase2/kruskal2.jl")

# On va chercher l'algorithme de Prim
include("../phase3/prim.jl")

#la fonction de parcours en pre ordre
include("../phase4/parcours-preodre.jl")

# On va chercher l'algorithme de HK
include("../phase4/step_size.jl")
include("../phase4/hk.jl")

# On va chercher l'algorithme de RSL
include("../phase4/rsl.jl")

# On va chercher les outils pour reconstruire une image
include("tools.jl")

# On a besoin d'un graphe pour générer nos propres tournées
include("create_graph.jl")

file = "shredder/shredder-julia/tsp/instances/nikos-cat.tsp"
# G = create_graph(file)
nodes_init, edges_init, nodes_graph, edges_graph, G = create_graph(file)
# on cherche notre tournee
A, poids, tournee = hk(G, algorithm_mst = kruskal2)

println("on a une tournée")

# on met la tournee sous forme de tableau  d'entier
tournee_int = [0]
for elem in tournee
   entier = parse(Int64, name(elem))
   push!(tournee_int, entier)
end

# on crée le fichier .tour
tournee_file = "pizza-food-wallpaper.tour"
write_tour(tournee_file, tournee_int, float32(poids))

# On peut reconstruire une image à l'aide d'une tournée déjà fournie
# tournee_file = "shredder/shredder-julia/tsp/tours/nikos-cat.tour"
image = "shredder/shredder-julia/images/shuffled/pizza-food-wallpaper.png"
nom_final = "pizza-food-wallpaper.png"
#
reconstruct_picture(tournee_file, image, nom_final)
#
printstyled("Image reconstruites! \n", color = :green)
println("on a qqchose")
