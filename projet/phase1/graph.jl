import Base.show
import Base.isempty
import Base.merge
"""Type abstrait dont d'autres types de graphes dériveront."""
abstract type AbstractGraph{T} end

"""Type representant un graphe comme un ensemble de noeuds et d'arêtes

Exemple :

		node1 = Node("Joe", 3.14)
		node2 = Node("Steve", exp(1))
		node3 = Node("Jill", 4.12)
		edge1 = Edge(node1, node2, 2)
		edge2 = Edge(node1, node3, 5)
		G = Graph("Ick", [node1, node2, node3], [edge1, edge2])

Attention, tous les noeuds doivent avoir des données de même type.
"""
mutable struct Graph{T} <: AbstractGraph{T}
	name :: String
	nodes :: Vector{Node{T}}
	edges :: Vector{Edge{T}}
end

"""Ajoute un noeud au graphe."""
function add_node!(graph::Graph{T}, node :: Node{T}) where T
	push!(graph.nodes, node)
	graph
end

"""Ajoute une arête au graphe."""
function add_edge!(graph::Graph{T}, edge::Edge{T}) where T
	push!(graph.edges, edge)
	graph
end


# on présume que tous les graphes dérivant d'AbstractGraph
# posséderont des champs `name` et `nodes`.

"""Renvoie le nom du graphe."""
name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds du graphe."""
nodes(graph::AbstractGraph) = graph.nodes

"""Renvoie la liste des arêtes du graphe."""
edges(graph :: AbstractGraph) = graph.edges

"""Renvoie le nombre de noeuds du graphe."""
nb_nodes(graph::AbstractGraph) = length(graph.nodes)

"""Renvoie le nombre d'arêtes du graphe."""
nb_edges(graph::AbstractGraph) = length(graph.edges)

"""Calcul poid total graphe."""
function w_tot_edges(graph :: AbstractGraph)
	W_edge = 0
	for i = 1:length(graph.edges)
		W_edge += graph.edges[i].weight
	end
	W_edge
end

"""Affiche un graphe"""
function show(graph::Graph)
	graph_name = name(graph)
	graph_nb_nodes = nb_nodes(graph)
	graph_nb_edges = nb_edges(graph)
	graph_weight = w_tot_edges(graph)

	for node in nodes(graph)
		show(node)
	end
	for edge in edges(graph)
		show(edge)
	end
	println("Graph ", graph_name, " has ", graph_nb_nodes, " nodes and ",
	graph_nb_edges, " edges. And its total weight is ", graph_weight)
end


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
function is_connected(graph :: AbstractGraph)
	if (nb_nodes(graph) > 1) && (nb_edges(graph) == 0)
		println("La composante n'est pas connexe!")
		return false
	elseif (nb_nodes(graph) == 1) && (nb_edges(graph) == 0)
		return true
	elseif (nb_nodes(graph) > 1) && (nb_edges(graph) > 0)
		connected = Vector{Bool}(); connected_nodes = Vector{Any}()
		for edge in edges(graph)
			push!(connected_nodes, nodes(edge)[1], nodes(edge)[2])
		end
		for node in nodes(graph)
			node in connected_nodes ? push!(connected, true) : push!(connected, false)
		end
		false in connected ? (println("La composante n'est pas connexe!"); return false) : (return true)
	end # gros if
end

""" Fonction qui regarde si un sommet est dans une composante connexe"""
function in_component(node :: AbstractNode{T}, graph :: Graph{T}) where T
	node in nodes(graph) ? (return true) : (return false)
end

"""Fonction qui regarde si une composante connexe/graph est vide (aucun sommet
et aucune arête)"""
function isempty(graph :: AbstractGraph{T}) where T
	return isempty(nodes(graph)) && isempty(edges(graph))
end

"""Fonction qui fusionne deux graphes. N'assure pas la connexité.
Pourrait fusionner deux composantes disjointes non connexes."""
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


"""
Fonction qui détermine les arêtes avec un sommet dans G et l'autre qui ne
l'est pas (on suppose qu'elle est dans un ensemble W)
"""
function edges_adj(G :: AbstractGraph, W :: AbstractGraph)
	edge_adjacentes = Vector{Edge}()
	for edge in edges(W)
		if (edge.node1 in nodes(G)) && !(edge.node2 in nodes(G))
			push!(edge_adjacentes, edge)
		elseif (edge.node2 in nodes(G)) && !(edge.node1 in nodes(G))
			push!(edge_adjacentes, edge)
		end
	end
	return edge_adjacentes
end

"""Fonction pour calculé le degré d'un noeud n dans un graph G"""
function degree(n :: AbstractNode, G :: AbstractGraph)
	degre = 0
	for edge in edges(G)
		if (!is_loop(edge)) && ((edge.node1 == n) || (edge.node2 == n))
			degre += 1
		end
	end
	return degre
end
