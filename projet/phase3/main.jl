include("tree.jl")

### Arbre simple de base
# tree1 = Tree("sam", 3.14)
# tree2 = Tree("femme de sam", 3.14)
# tree3 = Tree("fille de sam", 3.14)
# tree4 = Tree("fils de sam", 3.14)
#
### Union par le rang
# union_rang(tree1, tree2)
# union_rang(tree3, tree4)
# union_rang(tree1, tree3)
#
### Compression par de chemin
# compression_rang!(tree1)
# println("parent tree1 = $(name(parent(tree1)))")
# println("root tree1 = $(name(root(tree1)))")
# println("parent tree2 = $(name(parent(tree2)))")
# println("root tree2 = $(name(root(tree2)))")
# println("parent tree3 = $(name(parent(tree3)))")
# println("root tree3 = $(name(root(tree3)))")
# println("parent tree4 = $(name(parent(tree4)))")
# println("root tree4 = $(name(root(tree4)))")

### Arbre un peu plus compliqué
a = Tree("a", 0)
b = Tree("b", 0)
c = Tree("c", 0)
d = Tree("d", 0)
e = Tree("e", 0)
f = Tree("f", 0)
add_children!(a, b)
set_root!(b, a)
set_parent!(b, a)
add_children!(b, c)
set_root!(c, a)
set_parent!(c, b)
add_children!(b, d)
set_root!(d, a)
set_parent!(d, b)
add_children!(c, e)
set_root!(e, a)
set_parent!(e, c)
add_children!(d, f)
set_root!(f, a)
set_parent!(f, d)

compression_rang!(a)

println("children(a) = $(name.(children(a)))")
