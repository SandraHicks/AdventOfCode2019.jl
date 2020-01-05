program = [3,8,1001,8,10,8,105,1,0,0,21,38,63,76,89,106,187,268,349,430,99999,3,9,1001,9,5,9,102,3,9,9,1001,9,2,9,4,9,99,3,9,101,4,9,9,102,3,9,9,101,4,9,9,1002,9,3,9,101,2,9,9,4,9,99,3,9,101,5,9,9,1002,9,4,9,4,9,99,3,9,101,2,9,9,1002,9,5,9,4,9,99,3,9,1001,9,5,9,1002,9,5,9,1001,9,5,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,99]

using OffsetArrays

function runProgram(memory, userInput, userOutput)
    program = OffsetArray(copy(memory),-1)

    get_mem(mode, param) =
        if mode == 1
            return program[param]
        elseif mode == 0
            return program[program[param]]
        end

    set_mem(mode, param, val) =
        if mode == 1
            program[param] = val
        elseif mode == 0
            program[program[param]] = val
        end


    position = 0
    operation = program[position]
    operationDigits = digits(operation, pad=5)
    while operationDigits[1] != 9 && operationDigits[2] != 9
        result = 0
        if operationDigits[1] == 1
            result = get_mem(operationDigits[3], position + 1) + get_mem(operationDigits[4], position + 2)
            set_mem(operationDigits[5], position + 3, result)
            position += 4
        elseif operationDigits[1] == 2
            result = get_mem(operationDigits[3], position + 1) * get_mem(operationDigits[4], position + 2)
            set_mem(operationDigits[5], position + 3, result)
            position += 4
        elseif operationDigits[1] == 3
            set_mem(operationDigits[3], position + 1, popfirst!(userInput))
            position += 2
        elseif operationDigits[1] == 4
            output = get_mem(operationDigits[3], position + 1)
            push!(userOutput, output)
            position += 2
        elseif operationDigits[1] == 5
            if get_mem(operationDigits[3], position + 1) > 0
                position = get_mem(operationDigits[4], position + 2)
            else
                position += 3
            end

        elseif operationDigits[1] == 6
            if get_mem(operationDigits[3], position + 1) == 0
                position = get_mem(operationDigits[4], position + 2)
            else
                position += 3
            end

        elseif operationDigits[1] == 7
            val1 = get_mem(operationDigits[3], position + 1)
            val2 = get_mem(operationDigits[4], position + 2)
            if val1 < val2
                set_mem(operationDigits[5], position + 3, 1)
            else
                set_mem(operationDigits[5], position + 3, 0)
            end
            position += 4
        elseif operationDigits[1] == 8
            val1 = get_mem(operationDigits[3], position + 1)
            val2 = get_mem(operationDigits[4], position + 2)
            if val1 == val2
                set_mem(operationDigits[5], position + 3, 1)
            else
                set_mem(operationDigits[5], position + 3, 0)
            end
            position += 4
        end

        operation = program[position]
        operationDigits = digits(operation, pad=5)
    end
    return userOutput
end

using Combinatorics

mutable struct SingleOutput
    x::Int
end

SingleOutput() = SingleOutput(0)

Base.popfirst!(in::SingleOutput) = in.x
function Base.push!(in::SingleOutput, arg::Int)
    in.x = arg
    #println(arg)
end

function runProgramsPart1(memory)
    runPrograms(memory, 0, 4)
end

function runPrograms(memory, settingFrom, settingTo)
    possibleSettingsIterator = permutations(settingFrom:settingTo)
    #println(possibleSettingsIterator)
    maximum(possibleSettingsIterator) do setting
        channels = (ntuple(5) do i
            c = Channel{Int}(1)
            push!(c, setting[i])
            return c
        end) |> collect
        #@show channels
        push!(channels, Channel{Int}(1))
        #println(channels)

        m = map(1:5) do i
            #println("out", i)
            t = Base.Threads.@spawn begin
                #println("in", i)
                out = SingleOutput()
                runProgram(memory, channels[i], out)
                #println(out.x)
                push!(channels[i+1], out.x)
            end
            #println("outende", i)
            return t
        end

        push!(channels[1], 0)
        #println("pushed")
        #fetch.(m)
        #println.(m)
        output = take!(channels[6])
        return output
    end
end


runProgramsPart1(program)

##part2

example1P2 = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
example2P2 = [3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10]

function runProgramsPart2(memory)
    runPrograms2(memory, 5, 9)
end

function runPrograms2(memory, settingFrom, settingTo)
    possibleSettingsIterator = permutations(settingFrom:settingTo)
    #println(possibleSettingsIterator)
    maximum(possibleSettingsIterator) do setting
        channels = (ntuple(5) do i
            c = Channel{Int}(1)
            push!(c, setting[i])
            return c
        end) |> collect
        #@show channels
        #push!(channels, Channel{Int}(1))
        #println(channels)

        result = Channel{Int}(1)

        m = map(1:5) do i
            #println("out", i)
            t = Base.Threads.@spawn begin
                #println("in", i)
                if i == 5
                    runProgram(memory, channels[i], channels[1])
                    push!(result, take!(channels[1]))
                else
                    runProgram(memory, channels[i], channels[i+1])
                end
                #println(out.x)
            end
            #println("outende", i)
            return t
        end

        push!(channels[1], 0)
        #println("pushed")
        fetch.(m)
        println.(m)
        output = take!(result)
        return output
    end
end
