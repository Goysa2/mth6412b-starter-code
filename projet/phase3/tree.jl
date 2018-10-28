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
end

"""Ajoute un enfant à p"""
function add_children!(t :: Tree, e :: Tree)
	push!(t.children, e)
end

"""Retire un enfant à p"""
function remove_child!(t :: Tree)
	pop!(t.children)
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
		add_children!(root(arbre1), root(arbre2))
        set_parent!(root(arbre2), root(arbre1))
		set_root!(root(arbre2), root(arbre1))
		for enfant in children(arbre2)
			set_root!(enfant, root(arbre2))
		end
    elseif rang(root(arbre1)) != rang(root(arbre2))
        if rang(root(arbre1)) > rang(root(arbre2))
			add_children!(root(arbre1), root(arbre2))
            set_parent!(root(arbre2), root(arbre1))
			set_root!(root(arbre2), root(arbre1))
			for enfant in children(arbre2)
				set_root!(enfant, root(arbre2))
			end
        else
			add_children!(root(arbre2), root(arbre1))
            set_parent!(root(arbre1), root(arbre2))
			set_root!(root(arbre1), root(arbre2))
			for enfant in children(arbre1)
				set_root!(enfant, root(arbre1))
			end
        end
    end
end

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
