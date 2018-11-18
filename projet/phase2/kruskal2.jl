"""
Algorithme de Kruskal
"""
function kruskal2(G :: Graph{T}) where T
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    G2 = Graph("Graphe de recouvrement minimal", nodes_graph, Vector{Edge{T}}())

    e_cpt = 0
    k = 1

    # Fonction pour trier les arêtes en fonctions du poids
    sort!(edges_graph, by = x -> x.weight)
    Aₖ = edges_graph[1].node1
    racine = edges_graph[1].node1

    while e_cpt < length(nodes_graph) - 1
        edge = edges_graph[k];
        compression_chemin!(edge.node1); compression_chemin!(edge.node2);
        edge.node1 = root(edge.node1); edge.node2 = root(edge.node2);
        if (root(edge.node1) != root(edge.node2)) #i.e s'ils sont dans deux composantes différentes
            add_edge!(G2, edge)
            union_rang(edge.node1, edge.node2)
            e_cpt += 1
        end
        for node in nodes_graph
            compression_chemin!(node)
        end
        k += 1
    end # while

    for node in nodes(G2)
        for child in children(node)
            set_parent!(child, node)
        end
    end

    return G2
end
