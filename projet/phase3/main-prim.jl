include("../phase1/node.jl")
include("../phase1/edge.jl")
include("../phase1/graph.jl")
include("../phase2/exemple-laboratoire.jl")

include("priority_item.jl")
include("queue.jl")



include("prim.jl")

A = prim(G)

show(A)
