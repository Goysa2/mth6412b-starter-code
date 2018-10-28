"""
Algorithme de Prim
"""
function prim(G :: Graph{T}) where T
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    noeud_source = nodes_graph[1]
    set_min_weight!(noeud_source, 0)
    file_de_priorite = PriorityQueue{AbstractNode}()
    for node in nodes_graph
        (node != noeud_source) && push!(file_de_priorite, node)
    end


    # arbre de recouvrement minimal
    Aₖ = Graph("Arbre de recouvrement minimal", Vector{Node{T}}(), Vector{Edge{T}}())
    add_node!(Aₖ, noeud_source)
    # i = 1
    while !is_empty(file_de_priorite)
        # println("on est au début du while")
        @show edges_adj(Aₖ, G)
            for edge in edges_adj(Aₖ, G)
                if (edge.node1 in nodes(Aₖ)) && !(edge.node2 in nodes(Aₖ))
                    if weight(edge) < min_weight(edge.node2)
                        set_min_weight!(edge.node2, weight(edge))
                    end
                elseif (edge.node2 in nodes(Aₖ)) && !(edge.node1 in nodes(Aₖ))
                    if weight(edge) < min_weight(edge.node2)
                        set_min_weight!(edge.node2, weight(edge))
                    end
                end
            end # for

            nouveau_noeud = popfirst!(file_de_priorite)
            add_node!(Aₖ, nouveau_noeud)
            new_edge = Edge(noeud_source, noeud_source, Inf)
            for edge in edges(G)
                if weight(edge) == min_weight(nouveau_noeud)
                    if (edge.node1 == nouveau_noeud) || (edge.node2 == nouveau_noeud)
                        new_edge = edge
                    end
                end
            end
            add_edge!(Aₖ, new_edge)
            # show(Aₖ)
            # i += 1
    end # while

    return Aₖ
end
