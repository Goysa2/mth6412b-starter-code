function rsl(G :: Graph; algorithm_mst :: Function = kruskal2)
    A, racine = algorithm_mst(G)

    for node in nodes(A)
        if parent(node) != node
            add_children!(parent(node), node)
        end
    end

    parcours_preodre(racine)
    println(" ")

return A
end #function
