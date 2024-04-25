using Random
using DrWatson

# here we calculate the Hamiltonian and Magnetization for the given System. Therefore the NearestNeighboursSum is first needed. 

# calculates the sum over the nearest neighbours of the spins in the given lattice with periodic boundary conditions
function NearestNeighboursSum(lattice)
    erg = 0
    for k in axes(lattice, 3) 
        for j in axes(lattice, 2)  
            for i in axes(lattice, 1)
                erg += (lattice[i,j,k]*lattice[mod1(i+1,size(lattice, 1)),j,k] + lattice[i,j,k]*lattice[mod1(i-1,size(lattice, 1)),j,k] + lattice[i,j,k]*lattice[i,mod1(j+1,size(lattice, 2)),k] + lattice[i,j,k]*lattice[i,mod1(j-1,size(lattice, 2)),k] + lattice[i,j,k]*lattice[i,j,mod1(k+1,size(lattice, 3))] + lattice[i,j,k]*lattice[i,j,mod1(k-1,size(lattice, 3))])
                #= same expression, just longer
                if 0 < i+1 <= size(lattice, 1)
                    erg = erg + lattice[i, j, k] * lattice[i+1, j, k]
                else
                    erg = erg + lattice[i,j,k] * lattice[mod1(i+1,size(lattice, 1)),j,k]
                end
                if 0 < i-1 <= size(lattice, 1)
                    erg = erg + lattice[i, j, k] * lattice[i-1, j, k]
                else
                    erg = erg + lattice[i,j,k] * lattice[mod1(i-1,size(lattice, 1)),j,k]
                end
                if 0 < j+1 <= size(lattice, 2)
                    erg = erg + lattice[i, j, k] * lattice[i, j+1, k]
                else
                    erg = erg + lattice[i,j,k] * lattice[i,mod1(j+1,size(lattice, 2)),k]
                end
                if 0 < j-1 <= size(lattice, 2)
                    erg = erg + lattice[i, j, k] * lattice[i, j-1, k]
                else
                    erg = erg + lattice[i,j,k] * lattice[i,mod1(j-1,size(lattice, 2)),k]
                end
                if 0 < k+1 <= size(lattice, 3)
                    erg = erg + lattice[i, j, k] * lattice[i, j, k+1]
                else
                    erg = erg + lattice[i,j,k] * lattice[i,j,mod1(k+1,size(lattice, 3))]
                end
                if 0 < k-1 <= size(lattice, 3)
                    erg = erg + lattice[i, j, k] * lattice[i, j, k-1]
                else
                    erg = erg + lattice[i,j,k] * lattice[i,j,mod1(k-1,size(lattice, 3))]
                end
                =#
            end
        end    
    end    
    return erg
end

function NearestNeighboursSum_OneSpin(lattice, i,j,k)
    return erg = lattice[i,j,k]*lattice[mod1(i+1,size(lattice, 1)),j,k] + lattice[i,j,k]*lattice[mod1(i-1,size(lattice, 1)),j,k] + lattice[i,j,k]*lattice[i,mod1(j+1,size(lattice, 2)),k] + lattice[i,j,k]*lattice[i,mod1(j-1,size(lattice, 2)),k] + lattice[i,j,k]*lattice[i,j,mod1(k+1,size(lattice, 3))] + lattice[i,j,k]*lattice[i,j,mod1(k-1,size(lattice, 3))]
end
    
# sums the spins in a given lattice
function SpinSum(lattice)
    erg = 0
    for k in axes(lattice, 3) 
        for j in axes(lattice, 2)  
            for i in axes(lattice, 1)
                erg += lattice[i, j, k]
            end
        end
    end
    return erg
end

# calculates the Hamiltonian using the NearestNeighboursSum and SpinSum
function Hamiltonian(lattice, J, B)
    return H = -J * NearestNeighboursSum(lattice) - B * SpinSum(lattice)
end

# calculates the Magnetization
function Magnetization(lattice)
    erg = 0
    return erg = SpinSum(lattice)/length(lattice)
end
