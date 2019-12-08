program = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,13,19,1,10,19,23,2,9,23,27,1,6,27,31,1,10,31,35,1,35,10,39,1,9,39,43,1,6,43,47,1,10,47,51,1,6,51,55,2,13,55,59,1,6,59,63,1,10,63,67,2,67,9,71,1,71,5,75,1,13,75,79,2,79,13,83,1,83,9,87,2,10,87,91,2,91,6,95,2,13,95,99,1,10,99,103,2,9,103,107,1,107,5,111,2,9,111,115,1,5,115,119,1,9,119,123,2,123,6,127,1,5,127,131,1,10,131,135,1,135,6,139,1,139,5,143,1,143,9,147,1,5,147,151,1,151,13,155,1,5,155,159,1,2,159,163,1,163,6,0,99,2,0,14,0]
programExample1 = [1,0,0,0,99]
using OffsetArrays

function resetProgram(program, i, j)
    program[1] = i
    program[2] = j
end

function runProgram(input, withReset, i = 0, j = 0)
    program = OffsetArray(copy(input),-1)

    if withReset; resetProgram(program, i, j) end

    position = 0
    operation = program[position]
    while operation != 99
        result = 0
        if operation == 1
            result = program[program[position + 1]] + program[program[position + 2]]
        elseif operation == 2
            result = program[program[position + 1]] * program[program[position + 2]]
        end
        program[program[position+3]] = result
        position += 4
        operation = program[position]
    end
    return program[0]
end


#part1
runProgram(programExample1, false)

@btime runProgram(program, true, 12, 2)


#part2

wantedOutput = 19690720

function findResetValuesFor(program, result)
    resultI = -1
    resultJ = -1
    for i in 0:99
        for j in 0:99
            output = runProgram(program, true, i, j)
            if output == result
                resultI = i
                resultJ = j
                break
            end
        end
        if resultI >= 0 break end
    end
    return (resultI,resultJ)
end

@btime findResetValuesFor(program, wantedOutput)
