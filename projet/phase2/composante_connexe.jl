import Base.show
import Base.isempty
import Base.merge

"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T} end

# Les fonctions suivantes fonctionnent excatement comme la structure Graph
"""Type representant un graphe comme un ensemble de noeuds et d'arêtes

Exemple :

		node1 = Node("Joe", 3.14)
		node2 = Node("Steve", exp(1))
		node3 = Node("Jill", 4.12)
		edge1 = Edge(node1, node2, 2)
		edge2 = Edge(node1, node3, 5)
		G = Comp_connexe("Ick", [node1, node2, node3], [edge1, edge2])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Comp_connexe{T} <: AbstractGraph{T}
	name :: String
	nodes :: Vector{Node{T}}
	edges :: Vector{Edge{T}}
end

"""Ajoute un noeud au graphe."""
function add_node!(comp_connexe :: Comp_connexe{T}, node::Node{T}) where T
	push!(comp_connexe.nodes, node)
	comp_connexe
end

"""Ajoute une arête au graphe."""
function add_edge!(comp_connexe :: Comp_connexe{T}, edge::Edge{T}) where T
	push!(comp_connexe.edges, edge)
	comp_connexe
end


# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

# """Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds d'une composante connexe."""
nodes(comp_connexe :: AbstractGraph) = comp_connexe.nodes

"""Renvoie la liste des arêtes d'une composante connexe."""
edges(comp_connexe :: AbstractGraph) = comp_connexe.edges

"""Renvoie le nombre de noeuds d'une composante connexe."""
nb_nodes(comp_connexe :: AbstractGraph) = length(comp_connexe.nodes)

"""Renvoie le nombre d'arêtes d'une composante connexe."""
nb_edges(comp_connexe :: AbstractGraph) = length(comp_connexe.edges)

################################################################################
# On regarde différents cas.
# S'il y a plusieurs sommets et aucune arête le graphe n'est pas connexe
# S'il y a un seul sommet et aucune arêt le graph est connexe
# S'il y a plusieurs noeuds et plusieurs sommets:
#	- On parcours les arêtes du graphe et on mets ses sommets dans un vecteur
#	- On parcours les noeuds de la composante. Si Le noeud est dans le vecteur de
#	  de noeuds que l'on a déjà on met true dans un vecteur de booléen. Sinon
#	  le noeud n'est pas connecté à aucune arête donc on met false dans le vecteur
#   Si il y a une valeur fausse dans le vecteur de booléen à la fin cela signifie
#	qu'un sommet n'est relié à aucune arête donc le graphe n'est pas connexe
################################################################################
"""S'assure que la composante est connexe (en théorie devrait fonctionner
pour un graphe également)"""
function is_connected(comp_connexe :: AbstractGraph)
	if (nb_nodes(comp_connexe) > 1) && (nb_edges(comp_connexe) == 0)
		@warn "La composante n'est pas connexe!"
		return false
	elseif (nb_nodes(comp_connexe) == 1) && (nb_edges(comp_connexe) == 0)
		return true
	elseif (nb_nodes(comp_connexe) > 1) && (nb_edges(comp_connexe) > 0)
		connected = Vector{Bool}(); connected_nodes = Vector{Any}()
		for edge in edges(comp_connexe)
			push!(connected_nodes, nodes(edge)[1], nodes(edge)[2])
		end
		for node in nodes(comp_connexe)
			node in connected_nodes ? push!(connected, true) : push!(connected, false)
		end
		false in connected ? (@warn "La composante n'est pas connexe!"; return false) : (return true)
	end # gros if
end

""" Fonction qui regarde si un sommet est dans une composante connexe"""
function in_connected(node :: Node{T}, comp_connexe :: Comp_connexe{T}) where T
	node in nodes(comp_connexe) ? (return true) : (return false)
end

"""Fonction qui regarde si une composante connexe/graph est vide (aucun sommet
et aucune arête)"""
function isempty(graph :: AbstractGraph{T}) where T
	return isempty(nodes(graph)) && isempty(edges(graph))
end

"""Fonction qui fusionne deux graphe. N'assure aucune connexité.
Pourrait fusionner deux composante non connexe."""
function merge(cmp1 :: AbstractGraph{T}, cmp2 :: AbstractGraph) where T
	cmp = Graph("Merged graph", Vector{Node{T}}(), Vector{Edge{T}}())
	for node in nodes(cmp1)
		add_node!(cmp, node)
	end
	for node in nodes(cmp2)
		add_node!(cmp, node)
	end
	for edge in edges(cmp1)
		add_edge!(cmp, edge)
	end
	for edge in edges(cmp2)
		add_edge!(cmp, edge)
	end

	return cmp
end

"""Affiche une compasante connexe"""
function show(comp_connexe :: Comp_connexe)
	comp_connexe_name = name(comp_connexe)
	comp_connexe_nb_nodes = nb_nodes(comp_connexe)
	comp_connexe_nb_edges = nb_edges(comp_connexe)
	s = string("Connected componant has ", comp_connexe_nb_nodes, " nodes and ",
	comp_connexe_nb_edges, " edges")
	for node in nodes(comp_connexe)
		show(node)
	end
	for edge in edges(comp_connexe)
		show(edge)
	end
	show(s)
end
