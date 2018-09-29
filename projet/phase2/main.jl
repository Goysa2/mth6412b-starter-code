include("test-connected.jl")
include("exemple-laboratoire.jl")
include("kruskal.jl")

A = kruskal(exemple_graph)

show(A)
