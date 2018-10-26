using Test
include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase2/exemple-laboratoire.jl")

W = Graph("sous-graphe de G", [a], Vector{Edge{Int}}())

@test ((edges_adj(W, G)[1] == a_b) || (edges_adj(W, G)[1] == a_h))
@test ((edges_adj(W, G)[2] == a_b) || (edges_adj(W, G)[2] == a_h))


W₂ = Graph("autre sous graphe de G", [a, b, c], [a_b, b_c])

@test ((edges_adj(W₂, G)[1] == a_h) || (edges_adj(W₂, G)[1] == b_h) || (edges_adj(W₂, G)[1] == c_i) || (edges_adj(W₂, G)[1] == c_f) || (edges_adj(W₂, G)[1] == c_d))
@test ((edges_adj(W₂, G)[2] == a_h) || (edges_adj(W₂, G)[2] == b_h) || (edges_adj(W₂, G)[2] == c_i) || (edges_adj(W₂, G)[2] == c_f) || (edges_adj(W₂, G)[2] == c_d))
@test ((edges_adj(W₂, G)[3] == a_h) || (edges_adj(W₂, G)[3] == b_h) || (edges_adj(W₂, G)[3] == c_i) || (edges_adj(W₂, G)[3] == c_f) || (edges_adj(W₂, G)[3] == c_d))
@test ((edges_adj(W₂, G)[4] == a_h) || (edges_adj(W₂, G)[4] == b_h) || (edges_adj(W₂, G)[4] == c_i) || (edges_adj(W₂, G)[4] == c_f) || (edges_adj(W₂, G)[4] == c_d))
@test ((edges_adj(W₂, G)[5] == a_h) || (edges_adj(W₂, G)[5] == b_h) || (edges_adj(W₂, G)[5] == c_i) || (edges_adj(W₂, G)[5] == c_f) || (edges_adj(W₂, G)[5] == c_d))
