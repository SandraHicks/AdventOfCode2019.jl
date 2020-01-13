

function parseLayers1(file)
    lines = open(readlines, file)
    dictionary = Dict{Int, Array{Int}}()
    dicZeros = Dict{Int, Int}()
    dicOnes = Dict{Int, Int}()
    dicTwos = Dict{Int, Int}()

    width = 25
    height = 6
    #width = 3
    #height = 2

    currentLayer = 1
    dictionary[currentLayer] = []
    dicZeros[currentLayer] = 0
    dicOnes[currentLayer] = 0
    dicTwos[currentLayer] = 0

    #line = "123456781012123456021012"
    for line in lines
        for i = firstindex(line):lastindex(line)
            entry = Int(line[i])
            entry -= 48
            if entry == 0
                dicZeros[currentLayer] += 1
            elseif entry == 1
                dicOnes[currentLayer] += 1
            elseif entry == 2
                dicTwos[currentLayer] += 1
            end

            push!(dictionary[currentLayer], entry)
            if (i % (width * height)) == 0 && i != lastindex(line)
                currentLayer += 1
                #println(currentLayer, width, height, i)
                dictionary[currentLayer] = []
                dicZeros[currentLayer] = 0
                dicOnes[currentLayer] = 0
                dicTwos[currentLayer] = 0
            end
        end
    end
    #return dicZeros
    maxZerosLayer = findmin(dicZeros)
    println(maxZerosLayer, " ", dicOnes[maxZerosLayer[2]], " ",dicTwos[maxZerosLayer[2]])
    return dicOnes[maxZerosLayer[2]] * dicTwos[maxZerosLayer[2]]
end


#part2

function parseLayers(file, width, height)
    lines = open(readlines, file)
    dictionary = Dict{Int, Matrix{Int}}()

    currentLayer = 1
    dictionary[currentLayer] = zeros(height, width)

    #line = "123456781012123456021012"
    for line in lines
        w = 0
        h = 1
        #println(line)
        for i = firstindex(line):lastindex(line)
            entry = Int(line[i])
            entry -= 48
            w += 1
            if w > width
                w = 1
                h += 1
            end

            #println(i, "w", w, "h", h, "v", entry)
            mat = dictionary[currentLayer]
            mat[h,w] = entry
            dictionary[currentLayer] = mat
            if (i % (width * height)) == 0 && i != lastindex(line)
                currentLayer += 1
                #println(currentLayer, width, height, i)
                dictionary[currentLayer] = zeros(height, width)

                w = 0
                h = 1
            end
        end
    end
    #return dicZeros
    return dictionary
end

#0 black, 1 white, 2 transp
function renderImage(file, width, height)
    image = parseLayers(file, width, height)
    #println(image)
    image = sort(image)
    for i in 1:height
        for j in 1:width
            pixel = 2
            for k in keys(image)
                #println("i",i,"j",j)
                pixel = image[k][i,j]
                if pixel == 1
                    print("▒")
                    break
                elseif pixel == 0
                    print("█")
                    break
                end
            end
        end
        print("\n")
    end
end

#ERROR: BoundsError: attempt to access 6×25 Array{Int64,2} at index [7, 1]
#/Day8.jl:103
