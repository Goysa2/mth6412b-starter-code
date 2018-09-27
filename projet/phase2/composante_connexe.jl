import Base.show

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
mutable struct Comp_connexe{T} <: AbstractGraph{T}
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
# name(graph::AbstractGraph) = graph.name

"""Renvoie la liste des noeuds d'une composante connexe."""
nodes(comp_connexe :: AbstractGraph) = comp_connexe.nodes

"""Renvoie la liste des arêtes d'une composante connexe."""
edges(comp_connexe :: AbstractGraph) = comp_connexe.edges

"""Renvoie le nombre de noeuds d'une composante connexe."""
nb_nodes(comp_connexe :: AbstractGraph) = length(comp_connexe.nodes)

"""Renvoie le nombre d'arêtes d'une composante connexe."""
nb_edges(comp_connexe :: AbstractGraph) = length(comp_connexe.edges)


"""S'assure que la composante est connexe (en théorie devrait fonctionner
pour un graphe également)"""
function is_connected(comp_connexe :: AbstractGraph)
	if (nb_nodes(comp_connexe) > 1) && (nb_edges(comp_connexe) == 0)
		printstyled("plusieurs sommets, aucune arête \n", color = :blue)
		@warn "La composante n'est pas connexe!"
		return false
	elseif (nb_nodes(comp_connexe) == 1) && (nb_edges(comp_connexe) == 0)
		printstyled("un seul sommet, aucune arête \n", color = :blue)
		return true
	elseif (nb_nodes(comp_connexe) > 1) && (nb_edges(comp_connexe) > 0)
		printstyled("plusieurs sommets, au moins une arête \n", color = :blue)
		connected = Vector{Bool}()
		connected_nodes = Vector{Any}()
		for edge in edges(comp_connexe)
			push!(connected_nodes, nodes(edge)[1])
			push!(connected_nodes, nodes(edge)[2])
		end
		for node in nodes(comp_connexe)
			if node in connected_nodes
				push!(connected, true)
			else
				push!(connected, false)
			end
		end
		if false in connected
			@warn "La composante n'est pas connexe!"
			return false
		else
			return true
		end #if
	end # gros if
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
