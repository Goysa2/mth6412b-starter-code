"""
Algorithme de Kruskal
"""
function kruskal2(G :: Graph{T}) where T
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    G = Graph("Graphe de recourvrement minimal", nodes_graph, Vector{Edge{T}}())

    k = 1
    # Fonction pour trier les arêtes en fonctions du poids
    sort!(edges_graph, by = x -> x.weight)
    Aₖ = edges_graph[1].node1

    # for edge in edges_graph
    while length(edges(G)) < length(nodes_graph) - 1
        edge = edges_graph[k];
        if root(edge.node1) != root(edge.node2) #i.e s'ils sont dans deux composantes différentes
            add_edge!(G, edge)
            if (root(edge.node1) == root(Aₖ)) || (root(edge.node2) == root(Aₖ))
                if root(edge.node1) == root(Aₖ)
                    union_rang(edge.node1, edge.node2)
                else
                    union_rang(edge.node2, edge.node1)
                end
            elseif !(root(edge.node1) == root(Aₖ)) && !(root(edge.node2) == root(Aₖ))
                union_rang(edge.node1, edge.node2)
            end
        end
        for node in nodes_graph
            compression_chemin!(node)
        end
        # println("À l'itération $k")
        # show(G)
        k += 1
    end

    return G
end
