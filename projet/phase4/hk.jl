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
Tᵏ = nothing; tᵏ = nothing; wᵏ = Inf; wᵏ⁻¹ = Inf; Lᵏ = Inf
edges_graph = Dict([((name(edges_graph_init[1].node1),name(edges_graph_init[1].node2)), weight(edges_graph_init[1]))])
for edge in edges_graph_init
    temp_Dict = Dict([((name(edge.node1),name(edge.node2)), weight(edge))])
    edges_graph = merge!(edges_graph, temp_Dict)
end

# 1. On établie les variables nécessaires aux long de l'algorithme
k = 0
n = length(nodes_graph_init)
πᵏ = zeros(n); dᵏ = zeros(n)
W = -Inf
Wprec = -Inf
vᵏ = NaN * zeros(n) # on doit l'initialiser à une certaine valeur.
# dᵏ = NaN * zeros(n)
norm_obj = norm(2*ones(n))
periode = 1
duree_periode = n/2
double_period = false

while (k == 0) || ((k < 1_000) && (norm(tᵏ) > 1e-06) && (duree_periode != 0) && (vᵏ != zeros(n)))
    # @show k

    # Avant toute chose on doit "reset" G, on veut que chaque noeud redevienne
    # son propre parent et sa propre racine pour pouvoir faire kruskal2 ou prim
    reset!(G)
    # 2. On construit un 1-tree minimum Tᵏ
    # 2.1: on enlève le noeud 1 du graphe
    n_rand = rand(1:n)
    source = nodes_graph_init[n_rand]
    !(n_rand in [1.0, n])  && (nodes_G2 = vcat(nodes_graph_init[1:n_rand-1], nodes_graph_init[n_rand+1:end]))
    n_rand == 1 && (nodes_G2 = nodes_graph_init[2:end])
    n_rand == n && (nodes_G2 = nodes_graph_init[1:end-1])
    G2 = Graph("Graph tmp", nodes_G2, Vector{Edge{T}}())
    for edge in edges_graph_init
        if ((edge.node1 != source) && (edge.node2 != source)) && !(edge in edges(G2)) && !(is_loop(edge))
            add_edge!(G2, edge)
        end
    end

    # 2.2: On cherche le MST de ce nouveau graph
    Tᵏ = algorithm_mst(G2)

    # 2.4: On rajoute deux arêtes pour créer un cycle et ainsi avoir notre 1-tree
    new_edge = 0; cmpt_edge = 1
    while new_edge < 2
        edge = edges_graph_init[cmpt_edge]
        if ((edge.node1 == source) || (edge.node2 == source)) && !(edge in edges(Tᵏ)) && !(is_loop(edge))
            add_edge!(Tᵏ, edge)
            new_edge += 1
            if new_edge == 1
                if (edge.node1 == source)
                    set_parent!(source, edge.node2)
                else
                    set_parent!(source, edge.node1)
                end
            end
        end
        cmpt_edge += 1
    end
    set_root!(source, root(nodes(Tᵏ)[1]))
    add_node!(Tᵏ, source)

    #Donc à ce point on a notre 1-tree minimum

    # 3. On veut calculer la différence de poids entre l'arbre et le vecteur πᵏ
    Lᵏ = w_tot_edges(Tᵏ)
    wᵏ⁻¹ = wᵏ
    wᵏ = Lᵏ - 2 * sum(πᵏ[i] for i = 1:n)

    # 4. On calcul W
    Wprec = W
    W = max(W, wᵏ)

    # 5. On calcul vᵏ
    # 5.1 On détermine le vecteur dᵏ
    dᵏ = Vector{Int64}(undef, n)
    for i = 1:n
        node = nodes(Tᵏ)[i]
        dg_node = degree(node, Tᵏ)
        dᵏ[i] = dg_node
    end

    # 5.2 On calcul vᵏ
    vᵏ = dᵏ .- 2

    # 6. On va vérifier le critère d'optimalité dans la boucle while

    # 7. On calcul un pas de déplacement
    (periode == 1) && (double_period = (wᵏ - wᵏ⁻¹ > 0.0))
    (k == Int(floor(duree_periode))) && (Wprec < W) && (duree_periode *= 2)
    (k > duree_periode) && (periode *= 2)
    (k > duree_periode) && (duree_periode /= 2)
    tᵏ = step_size(n, k, periode, duree_periode, double_period)
    # @show tᵏ

    # 8. On met à jour la valeur de πᵏ
    @. πᵏ .= πᵏ .+ tᵏ .* vᵏ

    # 8.1 On met à jour le poids des arêtes avec le nouveau vecteur πᵏ
    for edge in edges_graph_init
        n₁ = parse(Int, name(edge.node1))
        n₂ = parse(Int, name(edge.node2))
        clef = (name(edge.node1), name(edge.node2))
        poids = edges_graph[clef]
        set_weight!(edge, poids + πᵏ[n₁] + πᵏ[n₂])
    end

    # for edge in edges_graph_init
    #     n₁ = parse(Int, name(edge.node1))
    #     n₂ = parse(Int, name(edge.node2))
    #     poids = weight(edge)
    #     set_weight!(edge, poids + πᵏ[n₁] + πᵏ[n₂])
    # end

    # 9. On met à jour la valeur de k
    k += 1

end #while

if (vᵏ == zeros(n))
    printstyled("L'algorithme produit une tournée \n", color = :green)
else
    printstyled("L'algorithme ne produit pas une tournée. \n", color = :yellow)
    printstyled("On parcours les noeuds en post-ordre pour \n", color = :yellow)
    printstyled("produire une tournée à partir du dernier \n", color = :yellow)
    printstyled("1-tree obtenu \n", color = :yellow)
end

return Tᵏ, wᵏ, W, dᵏ, vᵏ, tᵏ, πᵏ # valeur de retour temporaire, pour s'assurer que chaque étape fonctionne
          # présentement les étapes 1 et deux fonctionnent

end # function
