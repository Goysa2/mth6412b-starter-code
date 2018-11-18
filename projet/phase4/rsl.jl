function rsl(G :: Graph; algorithm_mst :: Function = kruskal2)
    A = algorithm_mst(G)
    racine = nodes(A)[1]
    while root(racine) != racine
        racine = parent(racine)
    end


    for node in nodes(A)
        if parent(node) != node
                add_children!(parent(node), node)
        end
    end


    ordre_noeud = parcours_preodre_iter(racine)
    println(" ")
    poids_tournee = 0
    for i = 1 : length(edges(A))-1
        node_1 = ordre_noeud[i]
        node_2 = ordre_noeud[i+1]
        for edge in edges(G)
            if (edge.node1 == node_1 && edge.node2 == node_2) || (edge.node2 == node_1 && edge.node1 == node_2)
                poids_tournee += weight(edge)
                break
            end
        end
    end

    node_1 = ordre_noeud[1]
    node_end = ordre_noeud[end]
    for edge in edges(G)
        if (edge.node1 == node_1 && edge.node2 == node_end) || (edge.node2 == node_1 && edge.node1 == node_end)
            poids_tournee += weight(edge)
            break
        end
    end

return A, poids_tournee
end #function
