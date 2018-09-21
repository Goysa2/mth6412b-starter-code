import Base.show

"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractEdge end

"""Type représentant les arêtes d'un graphe.

Exemple:

        arete = Edge("arete1", noeud1, noeud2, 3)

"""
mutable struct Edge <: AbstractEdge
    node1 :: Node
    node2 :: Node
    weight :: Int
end


"""Renvoie les données relatives à l'arête"""
nodes(edge :: AbstractEdge) = edge.node1, edge.node2

"""Renvoie le poid d'une arête"""
weight(edge :: AbstractEdge) = edge.weight

"""Affiche une arête"""
function show(edge :: AbstractEdge)
    s = string("Edge  connecting Nodes ", name(edge.node1),
               "--", name(edge.node2),
               "; Poid ", weight(edge))
    println(s)
end
