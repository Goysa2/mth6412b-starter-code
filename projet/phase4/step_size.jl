"""Fonction qui retourne un pas de déplacement constant"""
function cst(n :: Int, k :: Int)
    t = 1.0
    return t
end

"""Fonction qui diminue la taille du pas en fonction du nombre d'itération"""
function cst_decrease(n :: Int, k :: Int)
    t = 1.0
    k = max(1.0, k)
    return t/k
end


"""
Fonction qui détermine un pas de déplacement en fonction d'une période (un
nombre d'itération) et de la diminution ou non de la quantité W.
"""
function period_step_size(n :: Int, k :: Int; W :: Float64 = -Inf, p_init :: Int = 2)
    t = 1.0
    good_step_size = false
    vec_periode = [n/p_init]
    while !good_step_size
        if k < sum(vec_periode[i] for i = 1:length(vec_periode))
            good_step_size = true
        else
            push!(vec_periode, n/(p_init * 2))
        end
    end
    return t/length(vec_periode)
end
