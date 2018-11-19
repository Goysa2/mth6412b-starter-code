"""
On se base sur le pseudo code présenté en classe et celui présenté dans
l'article
    An Effective Implementation of the
    Lin-Kernighan Traveling Salesman Heuristic

par Keld Helsgaun. Les étapes énumérées en commentaires correspondent à celles
présentées dans cet article.
"""
function hk(G :: Graph{T}; algorithm_mst :: Function = kruskal2) where T
nodes_graph_init = nodes(G)
edges_graph_init = edges(G)
sort!(edges_graph_init, by = x -> x.weight)

# 1. On établie les variables nécessaires aux long de l'algorithme
k = 0
n = length(nodes_graph_init)
πₖ = zeros(n)
W = -Inf


# 2. On construit un 1-tree minimum Tᵏ
# 2.1: on enlève le noeud 1 du graphe
G2 = Graph("Graph tmp", nodes_graph_init[2:end], Vector{Edge{T}}())
for edge in edges_graph_init
    if (edge.node1 != nodes_graph_init[1]) && (edge.node2 != nodes_graph_init[1])
        add_edge!(G2, edge)
    end
end

# 2.2: On cherche le MST de ce nouveau graph
Tᵏ = algorithm_mst(G2)

# 2.3: On rajoute deux arêtes pour créer un cycle et ainsi avoir notre 1-tree
new_edge = 0; cmpt_edge = 1
while new_edge < 2
    edge = edges_graph_init[cmpt_edge]
    if ((edge.node1 == nodes_graph_init[1]) || (edge.node2 == nodes_graph_init[1])) && !(edge in edges(Tᵏ)) && !(is_loop(edge))
        add_edge!(Tᵏ, edge)
        new_edge += 1
    end
    cmpt_edge += 1
end
add_node!(Tᵏ, nodes_graph_init[1])

#Donc à ce point on a notre 1-tree minimum

# 3. On veut calculer la différence de poids entre l'arbre et le vecteur πₖ
# Il devrait y avoir while nrm(vₖ) < eps, mais on va se contenter de calculer
# les valeurs dont on a besoin pour le moment.

Lᵏ = w_tot_edges(Tᵏ)
wᵏ = Lᵏ - 2 * sum(πₖ[i] for i = 1:n)

# 4. On calcul W
W = max(W, wᵏ)

dᵏ = Vector{Int64}(undef, n)
for i = 1:n
    node = nodes(Tᵏ)[i]
    dg_node = degree(node, Tᵏ)
    dᵏ[i] = dg_node
end

# 5. On calcul vᵏ
vᵏ = dᵏ .- 2


return Tᵏ, wᵏ, W, dᵏ # valeur de retour temporaire, pour s'assurer que chaque étape fonctionne
          # présentement les étapes 1 et deux fonctionnent

end # function
