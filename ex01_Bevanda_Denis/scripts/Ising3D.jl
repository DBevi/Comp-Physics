using Random
using DrWatson
using Plots
using Statistics
@quickactivate"ex01_Bevanda_Denis"
include(srcdir("H_sum.jl"))
include(srcdir("metropolis_alg.jl"))

# this is the main method where the functions are accessed and the results are plotted.
# also a 3x3x3 Array is generated

n_row = 3
n_column = 3
n_depth = 3

J = 1
B = 0

#βs = 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9
βs = range(0.1,2.5,step=0.05)                               
βs = collect(βs)                # create Array of different β values, β = 1/(T*J)
niters = 300000                 # iteration times

spins_lattice = rand(Int8[-1, 1], n_row, n_column, n_depth)  # creates a 3-dim lattice with random entries of 1 or -1


#=
# Here we run the implemented Metropolis algorithm once for test purposes 
β = 0.7
Energy, AvrgSpin = MetropolisAlgo(spins_lattice, niters, β)

x1 = range(0, niters-1)
x2 = range(0, niters-1)
y1 = Energy
y2 = AvrgSpin/length(spins_lattice)
plot([x1 x2], [y1 y2], xlabel="Iteration Times", ylabel=["Energy" "Average Spin ̄m"], layout=(2,1))
#p1 = plot(x1, y1, xlabel="Iteration Times", ylabel="Energy")
#p2 = plot(x2, y2, xlabel="Iteration Times", ylabel="Average Spin ̄m", label="y2")
#plot(p1, p2, layout=(2,1))
=#


# calculate the energies and magnetization and their means for different β values 
E_means, E_stds, m_means, m_stds = getMeans_Energy_Spin_OverTemp(spins_lattice, niters, βs)



# in the following we plot the results over the Temperatur
T = zeros(length(βs))
for i in 1:length(βs)
    T[i] = 1/(βs[i]*J)
end

x1 = T
y1 = abs.(m_means)
p1 = plot(x1, y1, xlabel="Temperatur", ylabel="Average Spin ̄m")

x2 = T
y2 = E_means
p2 = plot(x2, y2, xlabel="Temperatur", ylabel="Avrg Energy")

x3 = T
y3 = (E_stds.^2) .* (βs.^2)
p3 = plot(x3, y3, xlabel="Temperatur", ylabel="Cv")

x4 = T
y4 = (m_stds.^2) .* (βs.^2)
p4 = plot(x4, y4, xlabel="Temperatur", ylabel="χ")

# for J=1 the critical Temperatur is somewhere at Tc=~5K