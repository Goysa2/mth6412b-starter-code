function rsl(G :: Graph; algorithm_mst :: Function = kruskal2)
    A, racine = algorithm_mst(G)
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    edges_mst = edges(A)
    nodes_mst = nodes(A)
#    set_left!(racine, edges_mst[1].node1)

#    TSP = Graph("TSP approximé", nodes_graph, edges_mst[1]) # On intialise le graphe représentant la tournée

# Attibuer des enfants de gauche ou de droite aux noeuds du MST
#    for nodey in nodes_mst
#        for nodex in nodes_mst[2:end]
#            if nodex.parent == nodey && nodey.left == nothing && nodey.right == nothing
#                set_left!(nodey, nodex)
#            elseif nodex.parent == nodey && nodey.left !== nothing
#                set_right!(nodey, nodex)
#            end
#        end
#    end

return A
end #function
