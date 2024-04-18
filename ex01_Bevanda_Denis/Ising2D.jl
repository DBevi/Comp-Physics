using Random
using DrWatson

num_row = 5
num_column = 5

spins = rand(Int8[-1, 1], num_row, num_column)


function calculate_EdivJ(s)
    
    erg = 0
    sum = 0
    
    for i in 1:num_row
        for j in 1:num_column

            if i == num_row && j == num_column
                erg = s[i, j] * s[i, j-1] + s[i, j] * s[i-1, j]
            elseif i == 1 && j == 1
                erg = s[i, j] * s[i+1, j] + s[i, j] * s[i, j+1]
            elseif i == 1 && j == num_column
                erg = s[i, j] * s[i, j-1] + s[i, j] * s[i+1, j]
            elseif i == num_row && j == 1
                erg = s[i, j] * s[i-1, j] + s[i, j] * s[i, j+1]

            elseif i == 1
                erg = s[i, j] * s[i, j-1] + s[i, j] * s[i+1, j] + s[i, j] * s[i, j+1]
            elseif j == 1
                erg = s[i, j] * s[i-1, j] + s[i, j] * s[i, j+1] + s[i, j] * s[i+1, j]
            elseif i == num_row
                erg = s[i, j] * s[i, j-1] + s[i, j] * s[i-1, j] + s[i, j] * s[i, j+1]
            elseif j == num_column
                erg = s[i, j] * s[i-1, j] + s[i, j] * s[i, j-1] + s[i, j] * s[i+1, j]

            else
                erg = s[i, j] * s[i, j-1] + s[i, j] * s[i+1, j] + s[i, j] * s[i, j+1] + s[i, j] * s[i-1, j]
            end
            sum = sum + erg

        end
    end 
    -sum
end

println(calculate_EdivJ(spins))