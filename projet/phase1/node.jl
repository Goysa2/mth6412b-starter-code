import Base.show

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
    rank :: Int
    parent :: Union{Nothing, Node}
end

"""Constructeur"""
function Node()
    return Node("", nothing, 0, nothing)
end

"""Constructeur"""
function Node(s :: String, d :: T) where T
    return Node(s, d, 0, nothing)
end

"""Fonction pour attribué la valeur du rang à un noeud"""
function set_rank!(node :: Node, r :: Int)
    node.rank = r
end

"""Fonction pour attribué un parent à un noeud"""
function set_parent!(node :: Node, p :: Node)
    node.parent = p
end

# on présume que tous les noeuds dérivant d'AbstractNode
# posséderont des champs `name` et `data`.

"""Renvoie le nom du noeud."""
name(node::AbstractNode) = node.name

"""Renvoie les donnees contenues dans le noeud."""
data(node::AbstractNode) = node.data

"""Renvoie le rang du noeud"""
rank(node :: AbstractNode) = node.rank

"""Renvoie le parent du noeud"""
parent(node :: AbstractNode) = node.parent

"""Affiche un noeud"""
function show(node::AbstractNode)
    println("Node ", name(node), ", data: ", data(node))
end
