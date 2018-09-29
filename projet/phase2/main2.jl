include("../phase1/main.jl")

cd("../phase2/")
include("composante_connexe.jl")
include("kruskal.jl")


A₂ = kruskal(G)
show(A₂)
