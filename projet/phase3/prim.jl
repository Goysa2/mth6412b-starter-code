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

    while !is_empty(file_de_priorite)
            for edge in edges_adj(Aₖ, G)
                if (edge.node1 in nodes(Aₖ)) && !(edge.node2 in nodes(Aₖ))
                    if weight(edge) < min_weight(edge.node2)
                        set_min_weight!(edge.node2, weight(edge))
                        set_parent!(edge.node2, edge.node1)
                    end
                elseif (edge.node2 in nodes(Aₖ)) && !(edge.node1 in nodes(Aₖ))
                    if weight(edge) < min_weight(edge.node1)
                        set_min_weight!(edge.node1, weight(edge))
                        set_parent!(edge.node1, edge.node2)
                    end
                end
            end # for

            nouveau_noeud = popfirst!(file_de_priorite)
            add_node!(Aₖ, nouveau_noeud)
            new_edge = false
            for edge in edges(G)
                if (edge.node1 == parent(nouveau_noeud)) && (edge.node2 == nouveau_noeud)
                    add_edge!(Aₖ, edge)
                    break
                elseif (edge.node2 == parent(nouveau_noeud)) && (edge.node1 == nouveau_noeud)
                    add_edge!(Aₖ, edge)
                    break
                end
            end
    end
    return Aₖ
end
