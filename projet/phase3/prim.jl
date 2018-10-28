"""
Algorithme de Prim
"""
function prim(G :: Graph{T}) where T
    edges_graph = edges(G)
    nodes_graph = nodes(G)

    noeud_source = nodes_graph[1]
    set_min_weight!(noeud_source, 0)
    file_de_priorite = PriorityQueue{AbstractNode}()
    for i = 2 : length(nodes_graph)
        push!(file_de_priorite, nodes_graph[i])
    end

    # arbre de recouvrement minimal
    Aₖ = Graph("Arbre de recouvrement minimal", Vector{Node{T}}(), Vector{Edge{T}}())
    add_node!(Aₖ, noeud_source)

    while !isempty(file_de_priorite)
            for node in nodes(Aₖ)
                edge_min = Inf
                for edge in edges_graph
                    if edge.node1 == node
                        set_min_weight!(edge.node2, weight(edge))
                        if weight(edge) < edge_min
                            edge_min = edge
                        end
                    elseif edge.node2 == node
                        set_min_weight!(edge.node1, weight(edge))
                        if weight(edge) < edge_min
                            edge_min = edge
                        end
                    end
                end # for
                nouveau_noeud = popfirst!(file_de_priorite)
                add_node!(Aₖ, nouveau_noeud)
                add_edge!(Aₖ, edge_min)
            end # for
    end # while

    return Aₖ
end
