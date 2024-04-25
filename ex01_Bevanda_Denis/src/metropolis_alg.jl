using Random
using DrWatson
@quickactivate"ex01_Bevanda_Denis"
include(srcdir("H_sum.jl"))

# here the MetropolisAlgorithm is implented. The means and stds for different β values are also calculated


# MetropolisAlgorithm for calculating the energy for one β
function MetropolisAlgo(lattice, times, β, J, B)

    energy = Hamiltonian(lattice, J, B)

    net_spins = zeros(times)
    net_energy = zeros(times)

    for t in 1:times

        #random_spin_pos = rand(1:length(lattice))
        rand_x = rand(1:size(lattice,1))
        rand_y = rand(1:size(lattice,2))
        rand_z = rand(1:size(lattice,3))

        spinflip_lattice = deepcopy(lattice)
        spinflip_lattice[rand_x,rand_y,rand_z] = -lattice[rand_x,rand_y,rand_z]

        #= test
        A_2 = copy(A)
        A_2[i,j,k] = -A_2[i,j,k]
        E_i = Hamiltonian(A, J, B)
        E_f = Hamiltonian(A_2, J, B)
        delta_test = 1/2 * (E_f - E_i) 
        delta = 2*J*A[i,j,k]*(A[mod1(i+1,size(A,1)),j,k] + A[mod1(i-1,size(A,1)),j,k] + A[i,mod1(j+1,size(A,2)),k] + A[i,mod1(j-1,size(A,2)),k] + A[i,j,mod1(k+1,size(A,3))] + A[i,j,mod1(k-1,size(A,3))]) + 2*B*A[i,j,k]
        E_i = - J * (A[i,j,k]*A[mod1(i+1,size(A, 1)),j,k] + A[i,j,k]*A[mod1(i-1,size(A, 1)),j,k] + A[i,j,k]*A[i,mod1(j+1,size(A, 2)),k] + A[i,j,k]*A[i,mod1(j-1,size(A, 2)),k] + A[i,j,k]*A[i,j,mod1(k+1,size(A, 3))] + A[i,j,k]*A[i,j,mod1(k-1,size(A, 3))])
        E_f = - J * (A_2[i,j,k]*A_2[mod1(i+1,size(A_2, 1)),j,k] + A_2[i,j,k]*A_2[mod1(i-1,size(A_2, 1)),j,k] + A_2[i,j,k]*A_2[i,mod1(j+1,size(A_2, 2)),k] + A_2[i,j,k]*A_2[i,mod1(j-1,size(A_2, 2)),k] + A_2[i,j,k]*A_2[i,j,mod1(k+1,size(A_2, 3))] + A_2[i,j,k]*A_2[i,j,mod1(k-1,size(A_2, 3))])
        dE = E_f - E_i
        println(delta, " ", delta_test, " ", dE)
        =#

        E_i = - J * NearestNeighboursSum_OneSpin(lattice, rand_x,rand_y,rand_z)
        E_f = - J * NearestNeighboursSum_OneSpin(spinflip_lattice, rand_x,rand_y,rand_z)
        
        dE = E_f - E_i

        if dE <= 0
            # println("accepted")
            energy += dE  
            lattice = deepcopy(spinflip_lattice) 
        else
            if rand() < exp(-dE*β)
            # println("accepted by probability")
            energy += dE
            lattice = deepcopy(spinflip_lattice)
            else
                #println("rejected (by Lebron)")
            end
        end

        net_energy[t] = energy
        net_spins[t] = Magnetization(lattice)

    end
    
    return (net_energy, net_spins)
    
end


# function for calculating the means and stds for variable β values
function getMeans_Energy_Spin_OverTemp(lattice, times, βs, J, B)

    m_means = zeros(length(βs))
    m_stds = zeros(length(βs))
    E_means = zeros(length(βs))
    E_stds = zeros(length(βs))

    for (i, β) in enumerate(βs)

        energies, spins = MetropolisAlgo(lattice, times, β, J, B)
        m_means[i] = mean(spins[(times-100000):end])/length(lattice)
        m_stds[i] = std(spins[(times-100000):end])/length(lattice)
        E_means[i] = mean(energies[(times-100000):end])
        E_stds[i] = std(energies[(times-100000):end])

    end
    return E_means, E_stds, m_means, m_stds

end




