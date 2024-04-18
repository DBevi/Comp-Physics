using Random
using DrWatson


num_row = 5
num_column = 5
num_depth = 5

spins = rand(Int8[-1, 1], num_row, num_column, num_depth)


#println(spins) 
#println()



function Hamiltonian_Energy_3D(J, Hm, spins)

    #calc magnetisation#
    spinNo = N_col*N_row*N_z
    spinSum = 0
    for z=1:N_z
        for y=1:N_col
            for x=1:N_row
                spinSum = spinSum + a[x,y,z]
            end
        end
    end
    magnetisation = spinSum/spinNo

    #calc neighbours
    neighbourNo = 
    for z=1:N_z
        for y=1:N_col
            for x=1:N_row
                spin = a[x,y,z]
                for s=[-1,1]
                end
            end
        end
    end

    spinSum, magnetisation 

end

E = hamiltonian3D(0,0,spins)
println(E)
