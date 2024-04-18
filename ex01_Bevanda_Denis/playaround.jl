using Random
using DrWatson

n_row = 10
n_col = 10

a = rand(n_row, n_col)
lattice_n = zeros(n_row, n_col)

#fills lattice_n with 1 (25%) or -1 (75%)
function fill_up_lattice(n_row, n_col, a)  

    for i=1 : n_row
        for j=1 : n_col
            if a[i,j] >= 0.75
                lattice_n[i,j] = 1
            else
                lattice_n[i,j] = -1
            end
        end
    end
    lattice_n

end

lattice_n = fill_up_lattice(n_row, n_col, a)
#println(lattice_n)

#convert float to integer array
lattice_n = [floor(Int,x) for x in lattice_n]
#println(lattice_n)

function HamiltonianEnergy_2D(J, B, spins)

    
    for y=1:N_col
        for x=1:N_row
            spin = lattice_n[x,y]
            for s=[-1,1]
            end
        end
    end

    spinSum

end


E = HamiltonianEnergy(0, 0, lattice_n)
