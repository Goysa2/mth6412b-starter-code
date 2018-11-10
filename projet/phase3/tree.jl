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
	return Tree("", nothing, nothing, Array(Tree[]), nothing, 0)
end

"""Constructeur d'arbre"""
function Tree(s :: String, d :: T) where T
	arbre = Tree(s, d, nothing, Array(Tree[]), nothing, 0)
	set_root!(arbre, arbre)
	set_parent!(arbre, arbre)
	return arbre
end

"""Fonction d'affichage d'un arbre"""
function show(t :: Tree)
	println("Tree $(name(t)) has parent $(name(parent(t))) and root $(name(root(t)))")
end



"""On regarde si un arbre est "vide", c'est-à-dire pas de parent, pas d'enfant et
pas de racine"""
function isempty(t :: Tree)
	return (root(t) == nothing) && (parent(t) == nothing) && (isempty(children(t)))
end

"""Renvoie les enfants"""
children(t :: Tree) = t.children

"""Renvoie la racine"""
root(t :: Tree) = t.root

"""Ajoute un enfant à p"""
function add_children!(t :: Tree, e :: Tree)
	if e != t
		push!(t.children, e)
	end
end

"""Retire un enfant à p"""
function remove_child!(t :: Tree)
	pop!(t.children)
end

"""Désigne la racine d'une composante"""
function set_root!(t :: Tree, r :: Tree)
	t.root = r
end

"""Donne le rang de composante"""
rang(t :: Tree) = t.rang

"""Attribue le rang d'une composante"""
function set_rang!(t :: Tree, r :: Int)
	t.rang = r
end

function union_rang(arbre1 :: Tree, arbre2 :: Tree)
	if root(arbre1) != root(arbre2)
		if rang(root(arbre1)) == rang(root(arbre2))
	        set_rang!(root(arbre1), rang(root(arbre1)) + 1)
	        set_parent!(root(arbre2), root(arbre1))
			set_root!(root(arbre2), root(parent(arbre2)))
	    elseif rang(root(arbre1)) != rang(root(arbre2))
	        if rang(root(arbre1)) > rang(root(arbre2))
				set_parent!(root(arbre2), root(arbre1))
				set_root!(root(arbre2), root(parent(arbre2)))
	        else
				set_parent!(root(arbre1), root(arbre2))
				set_root!(root(arbre1), root(parent(arbre1)))
	        end
	    end # comparaison rang racine
	end # arbre1 != arbre 2
end

# function union_rang(x :: Tree, y :: Tree)
# 	x_root = root(x)
# 	y_root = root(y)
#
# 	if x_root == y_root
# 		return
# 	end
#
# 	if rang(x_root) < rang(y_root)
# 		(x_root, y_root) = (y_root, x_root)
# 	end
#
# 	set_parent!(y_root, x_root)
# 	if rang(x_root) == rang(y_root)
# 	  set_rang!(x_root, rang(x_root) + 1)
#   	end
# end

function compression_rang!(arbre :: Tree)
	if (length(children(arbre)) > 0)
		for child in children(arbre)
			if length(children(child)) > 0
				set_parent!.(children(child), parent(arbre))
				add_children!.(arbre, children(child))
			end
		end
	else
		return arbre
	end
end
