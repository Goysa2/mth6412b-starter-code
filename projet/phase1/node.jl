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
    name 		:: String
    data 		:: T
    min_weight 	:: Real
    parent 		:: Union{Nothing, AbstractNode}
	root 		:: Union{Nothing, AbstractNode}
	children 	:: Vector
    rang 		:: Int
end

"""Constructeur"""
function Node()
    return Node("", nothing, typemax(Int), nothing, nothing, Vector(), 0)
end

"""Constructeur"""
function Node(s :: String, d :: T) where T
    a = Node(s, d, typemax(Int), nothing, nothing, Vector(), 0)
    set_parent!(a, a)
    set_root!(a, a)
    return a
end


"""Modifier l'attribut min_weight d'un noeud"""
function set_min_weight!(n :: AbstractNode, w :: Real)
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

"Montre les enfants d'un noeud"
function children(n:: Node)
	return n.children
end

"Ajoute un enfant à un noeud"
function add_children!(n :: Node, e :: Node)
	push!(n.children, e)
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
    print("Node $(name(node)) data: $(data(node)) parent = $(name(parent(node))) root = $(name(root(node)))  children = $(name.(children(node)))\n")

end

"""Union par le rang"""
function union_rang(x:: Node, y :: Node)
 	compression_chemin!(x); compression_chemin!(y)
	x = root(x); y = root(y)

	if rang(x) < rang(y)
		set_parent!(x, y)
	elseif rang(y) < rang(x)
		set_parent!(y, x)
	else
		set_parent!(y, x)
		set_rang!(x, rang(x) + 1)
	end
end


"""Compression des chemin"""
function compression_chemin!(n :: Node)
	if parent(n) != n
		set_root!(n, root(parent(n)))
	end
end # function
