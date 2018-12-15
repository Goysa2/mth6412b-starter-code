"""Algorithme de RSL"""
function rsl(G :: Graph; algorithm_mst :: Function = kruskal2)
    A = algorithm_mst(G)
    n = length(nodes(A))
    n_rand = rand(1:n)
    racine = nodes(A)[n_rand]
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
        node_1 = ordre_noeud[i]; node_2 = ordre_noeud[i+1]
        edge_cpt = 1; new_weight = false
        while !new_weight
            edge = edges(G)[edge_cpt]
            if (edge.node1 == node_1 && edge.node2 == node_2) || (edge.node2 == node_1 && edge.node1 == node_2)
                poids_tournee += weight(edge)
                new_weight = true
            end
            edge_cpt += 1
        end
    end

    node_1 = ordre_noeud[1]; node_end = ordre_noeud[end]
    edge_cpt = 1; final_edge = false
    while !final_edge
        edge = edges(G)[edge_cpt]
        if (edge.node1 == node_1 && edge.node2 == node_end) || (edge.node2 == node_1 && edge.node1 == node_end)
            poids_tournee += weight(edge)
            final_edge = true
        end
        edge_cpt += 1
    end

return A, poids_tournee, ordre_noeud
end #function
