import Base.show
import Base.parent

"""Type abstrait dont d'autres types de noeuds dériveront."""
abstract type AbstractNode{T} end

"""Type représentant les noeuds d'un graphe.

Exemple:

        noeud = Node("James", [π, exp(1)])
        noeud = Node("Kirk", "guitar")
        noeud = Node("Lars", 2)

"""
mutable struct Node{T} <: AbstractNode{T}
    name :: String
    data :: T
    min_weight :: Int
end

"""Constructeur"""
function Node()
    return Node("", nothing, typemax(Int))
end

"""Constructeur"""
function Node(s :: String, d :: T) where T
    return Node(s, d, typemax(Int))
end

"""Modifier l'attribut min_weight d'un noeud"""
function set_min_weight!(n :: AbstractNode, w :: Int)
    n.min_weight = w
end

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom du noeud."""
name(node::AbstractNode) = node.name

"""Renvoie les donnees contenues dans le noeud."""
data(node::AbstractNode) = node.data

"""
Renvoie le poids de l'arête de poids minimal connectant ce noeud au sous-arbre
"""
min_weight(node :: AbstractNode) = node.min_weight

"""Affiche un noeud"""
function show(node::AbstractNode)
    println("Node ", name(node), ", data: ", data(node))
end
