function rsl(G :: Graph; algorithm_mst :: Function = kruskal2)
    A, racine = algorithm_mst(G)
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    edges_mst = edges(A)


    TSP = Graph("TSP approximé", nodes_graph, edges_mst[1]) # On intialise le graphe représentant la tournée


end #function
