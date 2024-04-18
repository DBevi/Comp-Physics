using Random

function energyfast(s)
    n = length(s)
    - sum((s[i] * s[ifelse(i == n, 1, i+1)] for i in 1:n))
end

function energyslow(s)
    n = length(s)
    erg = 0
    sum = 0
    
    for i in 1:n
        if i == n
            erg = s[i] * s[1]
        else
            erg = s[i] * s[i+1]
        end
        sum = sum + erg
    end 
    -sum
end


num_spins = 20
β = 10.0

spins = rand(Int8[-1, 1], num_spins)

#E = energy(spins)

println(spins)
println(energyfast(spins))
println(energyslow(spins))