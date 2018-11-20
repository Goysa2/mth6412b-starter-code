"""
On se base sur le pseudo code présenté en classe et celui présenté dans
l'article
    An Effective Implementation of the
    Lin-Kernighan Traveling Salesman Heuristic

par Keld Helsgaun. Les étapes énumérées en commentaires correspondent à celles
présentées dans cet article.
"""
function hk(G :: Graph{T}; algorithm_mst :: Function = kruskal2, step_size :: Function = cst) where T
nodes_graph_init = nodes(G)
edges_graph_init = edges(G)
sort!(edges_graph_init, by = x -> x.weight)

# 0. On définit les variables qui ne sont seulement dans le "scope" du while
Tᵏ = nothing; tᵏ = nothing; wᵏ = nothing; dᵏ = nothing

# 1. On établie les variables nécessaires aux long de l'algorithme
k = 0
n = length(nodes_graph_init)
πᵏ = zeros(n)
W = -Inf
vᵏ = Inf # on doit l'initialiser à une certaine valeur. Autant bien prendre
         # la plus grand possible.

while (k < 100) && (false in (vᵏ .== 0))
    # 2. On construit un 1-tree minimum Tᵏ
    # 2.1: on enlève le noeud 1 du graphe
    n_rand = rand(1:n)
    source = nodes_graph_init[1]
    # nodes_G2 = vcat(nodes_graph_init[1:n_rand-1], nodes_graph_init[n_rand+1:end])
    nodes_G2 = nodes_graph_init[2:end]
    G2 = Graph("Graph tmp", nodes_G2, Vector{Edge{T}}())
    for edge in edges_graph_init
        if ((edge.node1 != source) && (edge.node2 != source)) && !(edge in edges(G2)) && !(is_loop(edge))
            add_edge!(G2, edge)
        end
    end

    # 2.2: On cherche le MST de ce nouveau graph
    Tᵏ = algorithm_mst(G2)

    # 2.3: On s'assure que les sommets du graphe G2 puissent être utilisées à
    #      nouveau dans un autre appel à kruskal2 ou prim
    reset!(G2)

    # 2.4: On rajoute deux arêtes pour créer un cycle et ainsi avoir notre 1-tree
    new_edge = 0; cmpt_edge = 1
    while new_edge < 2
        edge = edges_graph_init[cmpt_edge]
        if ((edge.node1 == source) || (edge.node2 == source)) && !(edge in edges(Tᵏ)) && !(is_loop(edge))
            add_edge!(Tᵏ, edge)
            new_edge += 1
        end
        cmpt_edge += 1
    end
    add_node!(Tᵏ, source)

    #Donc à ce point on a notre 1-tree minimum

    # 3. On veut calculer la différence de poids entre l'arbre et le vecteur πᵏ
    # Il devrait y avoir while nrm(vₖ) < eps, mais on va se contenter de calculer
    # les valeurs dont on a besoin pour le moment.

    Lᵏ = w_tot_edges(Tᵏ)
    wᵏ = Lᵏ - 2 * sum(πᵏ[i] for i = 1:n)

    # 4. On calcul W
    W = max(W, wᵏ)

    dᵏ = Vector{Int64}(undef, n)
    for i = 1:n
        node = nodes(Tᵏ)[i]
        dg_node = degree(node, Tᵏ)
        dᵏ[i] = dg_node
    end

    # 5. On calcul vᵏ
    vᵏ = dᵏ .- 2

    # 6. On va vérifier le critère d'optimalité dans la boucle while

    # 7. On calcul un pas de déplacement
    tᵏ = step_size(n, k)

    # 8. On met à jour la valeur de πᵏ
    @. πᵏ = πᵏ + tᵏ * vᵏ

    # 8.1 On met à jour le poids des arêtes avec le nouveau vecteur πᵏ
    for edge in edges_graph_init
        n₁ = parse(Int, name(edge.node1))
        n₂ = parse(Int, name(edge.node2))
        poids = weight(edge)
        set_weight!(edge, poids + πᵏ[n₁] + πᵏ[n₂])
    end

    # 9. On met à jour la valeur de k
    k += 1
    println("k = $k")

end #while


return Tᵏ, wᵏ, W, dᵏ, vᵏ, tᵏ, πᵏ # valeur de retour temporaire, pour s'assurer que chaque étape fonctionne
          # présentement les étapes 1 et deux fonctionnent

end # function