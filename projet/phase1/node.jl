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
    parent :: Union{Nothing, AbstractNode}
    root :: Union{Nothing, AbstractNode}
    rang :: Int
end

"""Constructeur"""
function Node()
    return Node("", nothing, typemax(Int), nothing, nothing, 0)
end

"""Constructeur"""
function Node(s :: String, d :: T) where T
    a = Node(s, d, typemax(Int), nothing, nothing, 0)
    set_parent!(a, a)
    set_root!(a, a)
    return a
end

"""Modifier l'attribut min_weight d'un noeud"""
function set_min_weight!(n :: AbstractNode, w :: Int)
    n.min_weight = w
end

"""Affiche le parent d'un noeud"""
parent(n :: AbstractNode) = n.parent

"""Renvoie la racine"""
root(n :: Node) = n.root

"""Modifie le parent d'un noeud"""
function set_parent!(n :: AbstractNode, p :: AbstractNode)
    n.parent = p
end

"""Désigne la racine d'une composante"""
function set_root!(n :: Node, r :: Node)
	n.root = r
end

"""Donne le rang de composante"""
rang(n :: Node) = n.rang

"""Attribue le rang d'une composante"""
function set_rang!(n :: Node, r :: Int)
	n.rang = r
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
    print("Node $(name(node)) data: $(data(node)) parent = $(name(parent(node))) root = $(name(root(node)))\n")

end

function union_rang(x:: Node, y :: Node)
	if root(x) != root(y)
		if rang(root(x)) == rang(root(y))
	        set_rang!(root(x), rang(root(x)) + 1)
	        set_parent!(root(y), root(x))
			set_root!(root(y), root(parent(y)))
			set_parent!(y, x)
	    elseif rang(root(x)) != rang(root(y))
	        if rang(root(x)) > rang(root(y))
				set_parent!(root(y), root(x))
				set_root!(root(y), root(parent(y)))
				set_parent!(y, x)
	        else
				set_parent!(root(x), root(y))
				set_root!(root(x), root(parent(x)))
				set_parent!(x, y)
	        end
	    end # comparaison rang racine
	end # if
end

function compression_chemin!(n :: Node)
	if parent(n) != n
		# set_parent!(n, root(parent(n)))
		set_root!(n, root(parent(n)))
	end
end # function
