
function parseMap(file)
    lines = open(readlines, file)
    dictionary = Dict{Symbol, Symbol}()

    for line in lines
        elements = Symbol.(split(line, ")"))
        dictionary[elements[2]] = elements[1]
    end

    return dictionary
end

function countOrbits(file)
    dict = parseMap(file)
    return sum(keys(dict)) do key
        current = key
        parents = -1
        while current != :root
            current = get(dict, current, :root)
            parents += 1
        end
        return parents
    end
end

countOrbits("input_Day6.txt")
countOrbits("input_example_Day6.txt")


#part2
function findPathLength(file, origin, goal)
    dict = parseMap(file)

    pathOrigin = pathToRoot(origin, dict)
    pathGoal = pathToRoot(goal, dict)

    prefixLength = getCommonPrefixLength(pathOrigin, pathGoal)
    return length(pathOrigin) + length(pathGoal) - 2*prefixLength
end

function pathToRoot(element, dict)
    path = Symbol[]

    current = get(dict, element, :root)
    while current != :root
        pushfirst!(path, current)
        current = get(dict, current, :root)
    end
    return path
end

function getCommonPrefixLength(path1, path2)
    result = findfirst(intersect(eachindex(path1), eachindex(path2))) do i
        return path1[i] != path2[i]
    end

    if result == nothing
        return length(path1)
    else
        return result - 1
    end
end


findPathLength("input_Day6.txt", Symbol("YOU"), Symbol("SAN"))
findPathLength("input_example2_Day6.txt", Symbol("YOU"), Symbol("SAN"))
