"""
Algorithme de Kruskal
"""
function kruskal(G :: Graph{T}) where T
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    Aₖ = Comp_connexe("Arbre de recouvrement minimal", Vector{Node{T}}(), Vector{Edge{T}}())
    temp_comp_conn = Vector{Comp_connexe{T}}()
    k = 1
    # Fonction pour trier les arêtes en fonctions du poids
    sort!(edges_graph, by = x -> x.weight)

    for edge in edges_graph
        if isempty(Aₖ)
            if !(is_loop(edge))
                add_node!(Aₖ, edge.node1); add_node!(Aₖ, edge.node2);
                add_edge!(Aₖ, edge)
            end
        elseif !(edge.node1 in nodes(Aₖ)) && !(edge.node2 in nodes(Aₖ))
            tmp = Comp_connexe("tmp $k", [edge.node1, edge.node2], [edge])
            no_merge = true
            for cmp in temp_comp_conn
                if (edge.node1 in nodes(cmp)) || (edge.node2 in nodes(cmp))
                    cmp = merge(cmp, tmp)
                    no_merge = false
                    break
                end
            end
            no_merge && push!(temp_comp_conn, tmp)
        elseif (edge.node1 in nodes(Aₖ)) && !(edge.node2 in nodes(Aₖ))
            no_merge = true
            for cmp in temp_comp_conn
                if edge.node2 in nodes(cmp)
                    Aₖ = merge(cmp, Aₖ)
                    add_edge!(Aₖ, edge)
                    no_merge = false
                    break
                end
            end# for
            no_merge && add_node!(Aₖ, edge.node2)
            no_merge && add_edge!(Aₖ, edge)
        elseif !(edge.node1 in nodes(Aₖ)) && (edge.node2 in nodes(Aₖ))
            no_merge = true
            for cmp in temp_comp_conn
                if edge.node1 in nodes(cmp)
                    Aₖ = merge(cmp, Aₖ)
                    add_edge!(Aₖ, edge)
                    no_merge = false
                    break
                end
            end# for
            no_merge && add_node!(Aₖ, edge.node1)
            no_merge && add_edge!(Aₖ, edge)
        end
        # fonction qui m'ont aidé à débuger, ultimement on devrait les enlever
        # println("à l'itération $k  on a Aₖ")
        # show(Aₖ)
        # println(" ")
        # println("à l'itération $k  on a temp_comp_conn")
        # for cmp in temp_comp_conn
        #     show(cmp)
        # end
        k += 1
    end # for

    return Aₖ
end
