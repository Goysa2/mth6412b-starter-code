include("stack.jl")

function parcours_preodre(n :: Union{AbstractNode, Nothing})
    nom = name(n)
    print("$nom ")
    if length(children(n)) > 0
        nbre_enfants = length(children(n))
        demi = div(length(children(n)), 2)
        for i = 1:demi
            parcours_preodre(children(n)[i])
        end
        for j = (demi+1):nbre_enfants
            parcours_preodre(children(n)[j])
        end
    end
    return
end

function parcours_preodre_iter(n :: Union{AbstractNode, Nothing})
    root = n
    node_stack = Stack{Node}()
    push!(node_stack, n)
    node_visit = Vector{Node}()

    while length(node_stack) > 0
        current_node = pop!(node_stack)
        print("$(name(current_node)) ")
        push!(node_visit, current_node)

        for child in children(current_node)
            push!(node_stack, child)
        end
    end
    return node_visit
end
