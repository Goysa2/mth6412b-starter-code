"""
Algorithme de Kruskal
"""
function kruskal(G :: Graph)
    edges_graph = edges(Graph)
    nodes_graph = nodes(Graph)

    Aₖ = Vector{Comp_connexe{T}}()

    # Fonction pour trier les arêtes en fonctions du poids
    sort!(edges_graph, by = x -> x.weight)

    for edge in edges_graph
        if isempty(Aₖ)
            push!(Aₖ, Comp_connexe[edge.node1, edge.node2], [edge])
        elseif (edge.node1 in nodes.(Aₖ)) && (edge.node2 in nodes.(Aₖ))
             
