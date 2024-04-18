using Random

function ising1d!(s, β, niters, rng)
    n = length(s)
    min_h = -2
    max_h = 2
    prob = [1/(1+exp(-2*β*h)) for h in min_h:max_h]
    #prob_f(h) = 1/(1+exp(-2*β*h))
    for iter in 1:niters, i in 1:n
        sl = s[ifelse(i == 1, n, i-1)]
        sr = s[ifelse(i == n, 1, i+1)]
        # h = -2, 0, 2
        h = sl + sr
        s[i] = ifelse(rand(rng) < prob[h-min_h+1], +1, -1)
        #s[i] = ifelse(rand(rng) < prob_f(h), +1, -1)
    end
end

function energy(s)
    n = length(s)
    - sum((s[i] * s[ifelse(i == n, 1, i+1)] for i in 1:n))
end

num_spins = 20
rng = MersenneTwister(4649)
#println(rng)
spins = rand(rng, Int8[-1, 1], num_spins)
#println(spins)
β = 10.0
niters = 5
s = copy(spins)

# Run once to compile the function
ising1d!(s, β, niters, rng)

println(spins)
println(s)