"""Fonction qui retourne un pas de déplacement constant"""
function cst(n :: Int,
             k :: Int,
             periode :: Int,
             duree_periode :: Float64,
             double :: Bool)
    t = 1.0
    return t
end

"""Fonction qui diminue la taille du pas en fonction du nombre d'itération"""
function cst_decrease(n :: Int,
                      k :: Int,
                      periode :: Int,
                      duree_periode :: Float64,
                      double :: Bool)
    t = 1.0
    k = max(1.0, k)
    return t/k
end

"""Fonction qui diminue la taille du pas en fonction du nombre d'itération"""
function cst_decrease_sqrt(n :: Int,
                           k :: Int,
                           periode :: Int,
                           duree_periode :: Float64,
                           double :: Bool)
    t = 1.0
    k = max(1.0, k)
    return t/sqrt(k)
end


"""
Fonction qui détermine un pas de déplacement en fonction d'une période (un
nombre d'itération) et de la diminution ou non de la quantité W.
"""
function period_step_size(n :: Int,
                          k :: Int,
                          periode :: Int,
                          duree_periode :: Float64,
                          double :: Bool)
    t = 1.0
    (periode > 1) && (t = t/(2^(periode-1)))
    double && (t *= 2.0)
    return t
end
