rangeFrom = 231832
rangeTo = 767346



function checkForPasswords(range)
    count(range) do n
        return checkConditionIncreasing(n) && checkAtLeastOneDouble(n)
    end
end

function checkConditionIncreasing(number)
    digis = digits(number)
    for i in eachindex(digis)[1:end-1]
        # smaller because digits are ordered from right to left
        if digis[i] < digis[i+1]
            return false
        end
    end
    return true
end

function checkAtLeastOneDouble(number)
    digis = digits(number)
    for i in eachindex(digis)[1:end-1]
        # smaller because digits are ordered from right to left
        if digis[i] == digis[i+1]
            return true
        end
    end
    return false
end

checkForPasswords(rangeFrom:rangeTo)

#part2

function checkForPasswordsPart2(range)
    numbers = Int[]
    count(range) do n
        if checkConditionIncreasing(n) && checkAtLeastOneDouble(n) && checkNoTriples(n)
            push!(numbers, n)
        end

        return checkConditionIncreasing(n) && checkAtLeastOneDouble(n) && checkNoTriples(n)
    end

    return numbers
end

function checkNoTriples(number)
    digis = digits(number)
    doubleDetections = 0
    for i in eachindex(digis)[1:end-1]
        # smaller because digits are ordered from right to left
        if digis[i] == digis[i+1]
            doubleDetections += 1
            if i == 1 && digis[i+1] == digis[i+2]
                doubleDetections -= 1
            elseif i+1 == 6 && digis[i] == digis[i-1]
                doubleDetections -= 1
            elseif i > 1 && i+1 < 6 && (digis[i] == digis[i-1] || digis[i+1] == digis[i+2])
                doubleDetections -= 1
            end
        end
    end
    if doubleDetections > 0
        return true
    else
        return false
    end
end

checkForPasswordsPart2(rangeFrom:rangeTo)
checkNoTriples(233445)
