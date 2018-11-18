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
end
