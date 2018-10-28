import Base.show
import Base.isempty
import Base.merge
import Base.parent

include("../phase1/node.jl")


# Les fonctions suivantes fonctionnent excatement comme la structure Graph
"""Type representant un arbre"""
mutable struct Tree{T} <: AbstractNode{T}
	name 	 :: String
	data 	 :: T
	parent 	 :: Union{Nothing, Tree}
	children :: Array{Tree}
	root 	 :: Union{Nothing, Tree}
	rang 	 :: Int
end

# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Constructeur d'arbre"""
function Tree()
	return Tree("", nothing, nothing, Array{Tree}(), nothing, 0)
end

"""Constructeur d'arbre"""
function Tree(s :: String, d :: T) where T
	arbre = Tree(s, d, nothing, Array{Tree}(undef, 1), nothing, 0)
	set_root!(arbre, arbre)
	set_parent!(arbre, arbre)
	return arbre
end

"""Renvoie le nom du graphe."""
name(t :: Tree) = t.name

"""Renvoie le parent"""
parent(t :: Tree) = t.parent

"""Renvoie les enfants"""
children(t :: Tree) = t.children

"""Renvoie la racine"""
root(t :: Tree) = t.root

"""Désigne le parent"""
function set_parent!(t :: Tree, p :: Tree)
	t.parent = p
	set_root!(t, root(p))
end

"""Ajoute un enfant à p"""
function add_children!(t :: Tree, e :: Tree)
	push!(t.children, e)
	set_parent!(e, t)
end

"""Désigne la racine d'une tosante"""
function set_root!(t :: Tree, r :: Tree)
	t.root = r
end

"""Donne l'information de la tosante"""
data(t :: Tree) = t.data

"""Affiche une tosante"""
show(t :: Tree) = show(data(t))

"""Donne le rang de tasante"""
rang(t :: Tree) = t.rang

"""Attribue le rang d'une tosante"""
function set_rang!(t :: Tree, r :: Int)
	t.rang = r
end

function union_rang(arbre1 :: Tree, arbre2 :: Tree)
    if rang(root(arbre1)) == rang(root(arbre2))
        set_rang!(root(arbre1), rang(root(arbre1)) + 1)
        set_parent!(root(arbre2), root(arbre1))
    elseif rang(root(arbre1)) != rang(root(arbre2))
        if rang(root(arbre1)) > rang(root(arbre2))
            set_parent!(root(arbre2), root(arbre1))
        else
            set_parent!(root(arbre1), root(arbre2))
        end
    end
end

################################################################################
# On regarde différents cas.
# S'il y a plusieurs sommets et aucune arête le graphe n'est pas connexe
# S'il y a un seul sommet et aucune arêt le graph est connexe
# S'il y a plusieurs noeuds et plusieurs sommets:
#	- On parcours les arêtes du graphe et on mets ses sommets dans un vecteur
#	- On parcours les noeuds de la tosante. Si Le noeud est dans le vecteur de
#	  de noeuds que l'on a déjà on met true dans un vecteur de booléen. Sinon
#	  le noeud n'est pas connecté à aucune arête donc on met false dans le vecteur
#   Si il y a une valeur fausse dans le vecteur de booléen à la fin cela signifie
#	qu'un sommet n'est relié à aucune arête donc le graphe n'est pas connexe
################################################################################
# """S'assure que la tosante est connexe (en théorie devrait fonctionner
# pour un graphe également)"""
# function is_connected(Tree :: AbstractGraph)
# 	if (nb_nodes(Tree) > 1) && (nb_edges(Tree) == 0)
# 		@warn "La tosante n'est pas connexe!"
# 		return false
# 	elseif (nb_nodes(Tree) == 1) && (nb_edges(Tree) == 0)
# 		return true
# 	elseif (nb_nodes(Tree) > 1) && (nb_edges(Tree) > 0)
# 		connected = Vector{Bool}(); connected_nodes = Vector{Any}()
# 		for edge in edges(Tree)
# 			push!(connected_nodes, nodes(edge)[1], nodes(edge)[2])
# 		end
# 		for node in nodes(Tree)
# 			node in connected_nodes ? push!(connected, true) : push!(connected, false)
# 		end
# 		false in connected ? (@warn "La tosante n'est pas connexe!"; return false) : (return true)
# 	end # gros if
# end
#
# """ Fonction qui regarde si un sommet est dans une tosante connexe"""
# function in_connected(node :: Node{T}, Tree :: Tree{T}) where T
# 	node in nodes(Tree) ? (return true) : (return false)
# end
#
# """Fonction qui regarde si une tosante connexe/graph est vide (aucun sommet
# et aucune arête)"""
# function isempty(graph :: AbstractGraph{T}) where T
# 	return isempty(nodes(graph)) && isempty(edges(graph))
# end
#
# """Fonction qui fusionne deux graphe. N'assure aucune connexité.
# Pourrait fusionner deux tosante non connexe."""
# function merge(cmp1 :: AbstractGraph{T}, cmp2 :: AbstractGraph) where T
# 	cmp = Graph("Merged graph", Vector{Node{T}}(), Vector{Edge{T}}())
# 	for node in nodes(cmp1)
# 		add_node!(cmp, node)
# 	end
# 	for node in nodes(cmp2)
# 		add_node!(cmp, node)
# 	end
# 	for edge in edges(cmp1)
# 		add_edge!(cmp, edge)
# 	end
# 	for edge in edges(cmp2)
# 		add_edge!(cmp, edge)
# 	end
#
# 	return cmp
# end
#
# """Affiche une tasante connexe"""
# function show(Tree :: Tree)
# 	Tree_name = name(Tree)
# 	Tree_nb_nodes = nb_nodes(Tree)
# 	Tree_nb_edges = nb_edges(Tree)
# 	s = string("Connected tonant has ", Tree_nb_nodes, " nodes and ",
# 	Tree_nb_edges, " edges")
# 	for node in nodes(Tree)
# 		show(node)
# 	end
# 	for edge in edges(Tree)
# 		show(edge)
# 	end
# 	show(s)
# end
