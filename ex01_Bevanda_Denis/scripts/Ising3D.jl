using Random
using DrWatson
using Plots
using Statistics
@quickactivate"ex01_Bevanda_Denis"
include(srcdir("H_sum.jl"))
include(srcdir("metropolis_alg.jl"))


# this is the main method where the functions are accessed and the results are plotted.
# fist a nxnxn Array is generated

n = 3
n_row = n
n_column = n
n_depth = n
J = 1
B = 0
k_b = 1
βs = range(0.1,2.5,step=0.02)                               
βs = collect(βs)                # create Array of different β values, β = 1/(k_b*T)
niters = 300000                 # iteration times

spins_lattice = rand(Int8[-1, 1], n_row, n_column, n_depth)  # creates a 3-dim lattice with random entries of 1 or -1

#=
# Here we run the implemented Metropolis algorithm once for test purposes 
β = 0.7
energy, magnetization = MetropolisAlgo(spins_lattice, niters, β, J, B)

x1 = range(0, niters-1)
x2 = range(0, niters-1)
y1 = energy
y2 = magnetization
plot([x1 x2], [y1 y2], xlabel="Iteration Times", ylabel=["Energy" "Magnetization"], layout=(2,1))
#p1 = plot(x1, y1, xlabel="Iteration Times", ylabel="Energy")
#p2 = plot(x2, y2, xlabel="Iteration Times", ylabel="Average Spin ̄m", label="y2")
#plot(p1, p2, layout=(2,1))
=#


# calculate the energies and magnetization and their means/stds for different β values 
E_means, E_stds, m_means, m_stds = getMeans_Energy_Spin_OverTemp(spins_lattice, niters, βs, J, B)


# plot the results over the Temperatur T=1/(k_b*β)
x1 = 1 ./ (k_b .* βs)
y1 = abs.(m_means)
p1 = plot(x1, y1, xlabel="Temperatur", ylabel="Magnetization")
display(p1)

x2 = 1 ./ (k_b .* βs)
y2 = E_means
p2 = plot(x2, y2, xlabel="Temperatur", ylabel="Energy")
display(p2)

x3 = 1 ./ (k_b .* βs)
y3 = (E_stds.^2) .* ((k_b.*βs).^2)
p3 = plot(x3, y3, xlabel="Temperatur", ylabel="Cv")
display(p3)

x4 = 1 ./ (k_b .* βs)
y4 = (m_stds.^2) .* ((k_b.*βs).^2)
p4 = plot(x4, y4, xlabel="Temperatur", ylabel="χ")
display(p4)

# for J=1 the critical Temperatur is somewhere at Tc=~5K
