"""
Fonction pour créer un graphe avec un TSP.
Très similaire avec ce qui est fait dans le main de la phase 1
"""
function create_graph(file :: String; name :: String = "Test name")
    ### On va chercher l'information utilisable des fichiers tsp grace à la fonction
    ### read_stsp. On va ensuite convertir cette information pour quelle soit utilisable
    ### par la classe graphe
    nodes_init, edges_init = read_stsp(file)
    edges_init = edges_init[2:end]

    for elem in edges_init
       for indiv in elem
           indiv[1] -= 1
       end
    end

    ### Les sommets et arêtes que l'on va utiliser pour créer le graphe
    nodes_graph = Vector{Node{Int64}}()
    edges_graph = Vector{Edge{Int64}}()

    ### On met tout les sommes dans un tableau de sommets"""
    for i = 1:length(edges_init) + 1
        push!(nodes_graph, Node(string(i), i))
    end


    ### On ajoute les arêtes à notre graphe
    ### On a deux types de structures de matrices avec les poids:
    ### 1) Des matrices tels qu'à la ligne i on a les poids des arêtes reliant
    ###    le sommet i au sommet j. Dans ce cas il faut utiliser le premier if
    ###    pour créer des arêtes.
    ### 2) Sinon on a une structure plus simple: la composante (i,j) de edges_init
    ###    représente l'arête reliant les sommets i et j. Dans un tel cas, on a
    ###    qu'à parcourir tout les éléments de la matrice. On utilise le second if.
    for i = 1:length(edges_init)
        edge = edges_init[i]
        if edges_init[i][1][1] > 1
            for j = i:length(edges_init)
                push!(edges_graph, Edge(nodes_graph[i], nodes_graph[j+1], edge[j-i+1][2]))
            end
        elseif edges_init[i][1][1] == 1
            for j = 1:length(edges_init[i])
                push!(edges_graph, Edge(nodes_graph[i], nodes_graph[j], edge[j][2]))
            end
        end
    end


    G = Graph(name, nodes_graph, edges_graph);
    # return G
    return nodes_init, edges_init, nodes_graph, edges_graph, G
end
