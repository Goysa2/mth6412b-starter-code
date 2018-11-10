"""
Algorithme de Kruskal
"""
function kruskal2(G :: Graph{T}) where T
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    G = Graph("Graphe de recourvrement minimal", Vector{Node{T}}(), Vector{Edge{T}}())

    k = 1
    # Fonction pour trier les arêtes en fonctions du poids
    sort!(edges_graph, by = x -> x.weight)
    Aₖ = edges_graph[1].node1

    # for edge in edges_graph
    while k < 6
        println("a l'intération $k")
        show(Aₖ)
        edge = edges_graph[k];
        printstyled("on traite l'arête ", color = :yellow)
        show(edge)
        if root(edge.node1) != root(edge.node2) #i.e s'ils sont dans deux composantes différentes
            add_edge!(G, edge)
            printstyled("on est dans 2 composantes connexes différentes \n", color = :green)
            if (root(edge.node1) == root(Aₖ)) || (root(edge.node2) == root(Aₖ))
                if root(edge.node1) == root(Aₖ)
                    union_rang(Aₖ, edge.node2)
                else
                    union_rang(Aₖ, edge.node1)
                end
                printstyled("on a node1, node2, Aₖ \n", color = :yellow)
                show(edge.node1)
                show(edge.node2)
                show(Aₖ)
                printstyled("on a fait deux unions par le rang \n", color = :yellow)
            elseif !(root(edge.node1) == root(Aₖ)) && !(root(edge.node2) == root(Aₖ))
                union_rang(edge.node1, edge.node2)
            end
        end
        k += 1
    end

    return G
end
