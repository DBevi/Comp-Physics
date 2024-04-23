using Random
using DrWatson
@quickactivate"ex01_Bevanda_Denis"
include(srcdir("H_sum.jl"))

# here the MetropolisAlgorithm is implented. The means and stds for different β values are also calculated


# MetropolisAlgorithm for calculating the energy for one β
function MetropolisAlgo(lattice, times, β)

    energy = Hamiltonian(lattice, J, B)

    net_spins = zeros(times)
    net_energy = zeros(times)

    for t in 1:times

        init_lattice = deepcopy(lattice)

        random_spin_pos = rand(1:length(lattice))
        
        spin_i = lattice[random_spin_pos]
        spin_f = lattice[random_spin_pos] * -1

        lattice[random_spin_pos] = spin_f
        spinflip_lattice = deepcopy(lattice)

        E_i = Hamiltonian(init_lattice, J, B)
        E_f = Hamiltonian(spinflip_lattice, J, B)

        dE = E_f - E_i

        if dE > 0
            if rand() < exp(-β*dE)
                #println("accepted by probability")
                energy = energy + dE
                lattice = deepcopy(spinflip_lattice)
            else
                #println("rejected")
                lattice = deepcopy(init_lattice)
            end
        else
            #println("accepted")
            energy = energy + dE  
            lattice = deepcopy(spinflip_lattice)  
        end

        net_energy[t] = energy
        net_spins[t] = SpinSum(lattice)

    end
    
    return (net_energy, net_spins)
    
end


# function for calculating the means and stds for variable β values
function getMeans_Energy_Spin_OverTemp(lattice, times, βs)

    m_means = zeros(length(βs))
    m_stds = zeros(length(βs))
    E_means = zeros(length(βs))
    E_stds = zeros(length(βs))

    for (i, β) in enumerate(βs)

        energies, spins = MetropolisAlgo(lattice, times, β)
        m_means[i] = mean(spins[(times-100000):end])/length(lattice)
        m_stds[i] = std(spins[(times-100000):end])/length(lattice)
        E_means[i] = mean(energies[(times-100000):end])
        E_stds[i] = std(energies[(times-100000):end])

    end

    return E_means, E_stds, m_means, m_stds

end