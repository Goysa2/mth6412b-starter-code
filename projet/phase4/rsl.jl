function rsl(G :: Graph; algorithm_mst :: Function = kruskal2)
    A, racine = algorithm_mst(G)

    for node in nodes(A)
        if parent(node) != node
            add_children!(parent(node), node)
        end
    end

    ordre_noeud = parcours_preodre_iter(racine)
    println(" ")
    poids_tournee = 0
    for i = 1 : length(edges(A))
        node_1 = ordre_noeud[i]
        node_2 = ordre_noeud[i+1]
        for edge in edges(A)
            if (edge.node1 == node_1 && edge.node2 == node_2) || (edge.node2 == node_1 && edge.node1 == node_2)
                poids_tournee += weight(edge)
            end
        end
    end

return A, poids_tournee
end #function
