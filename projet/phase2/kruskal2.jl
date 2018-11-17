"""
Algorithme de Kruskal
"""
function kruskal2(G :: Graph{T}) where T
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    G2 = Graph("Graphe de recouvrement minimal", nodes_graph, Vector{Edge{T}}())

    e_cpt = 0
    k = 1
    # temp_edges = Vector{Edge{T}}()
    # Fonction pour trier les arêtes en fonctions du poids
    sort!(edges_graph, by = x -> x.weight)
    Aₖ = edges_graph[1].node1
    racine = edges_graph[1].node1
    set_marked!(racine)

    # for edge in edges_graph
    # while (length(edges(G)) + length(temp_edges)) < length(nodes_graph) - 1
    # while k < 87
    while e_cpt < length(nodes_graph) - 1
        # printstyled("à l'itération k = $k \n", color = :green)
        edge = edges_graph[k];
        println("on traite l'arête:")
        show(edge)
        if (root(edge.node1) != root(edge.node2)) #i.e s'ils sont dans deux composantes différentes
            println("on est dans le cas: deux composantes différentes")
            add_edge!(G2, edge)
            union_rang(edge.node1, edge.node2)
            e_cpt += 1
        end
        for node in nodes_graph
            compression_chemin!(node)
        end
        println("k = $k et e = $e_cpt G:")
        show(G2)
        k += 1
    end # while

    for node in nodes(G2)
        for child in children(node)
            set_parent!(child, node)
        end
    end

    return G2
end
