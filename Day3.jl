path1 = """R998,U367,R735,U926,R23,U457,R262,D473,L353,U242,L930,U895,R321,U683,L333,U623,R105,D527,R437,D473,L100,D251,L958,U384,R655,U543,L704,D759,R529,D176,R835,U797,R453,D650,L801,U437,L468,D841,R928,D747,L803,U677,R942,D851,R265,D684,L206,U763,L566,U774,L517,U337,L86,D585,R212,U656,L799,D953,L24,U388,L465,U656,L467,U649,R658,U519,L966,D290,L979,D819,R208,D907,R941,D458,L882,U408,R539,D939,R557,D771,L448,U460,L586,U148,R678,U360,R715,U312,L12,D746,L958,U216,R275,D278,L368,U663,L60,D543,L605,D991,L369,D599,R464,D387,L835,D876,L810,U377,L521,U113,L803,U680,L732,D449,R891,D558,L25,U249,L264,U643,L544,U504,R876,U403,R950,U19,L224,D287,R28,U914,R906,U970,R335,U295,R841,D810,R891,D596,R451,D79,R924,U823,L724,U968,R342,D349,R656,U373,R864,U374,L401,D102,L730,D886,R268,D188,R621,U258,L788,U408,L199,D422,R101,U368,L636,U543,R7,U722,L533,U242,L340,D195,R158,D291,L84,U936,L570,D937,L321,U947,L707,U32,L56,U650,L427,U490,L472,U258,R694,U87,L887,U575,R826,D398,R602,U794,R855,U225,R435,U591,L58,U281,L834,D400,R89,D201,L328,U278,L494,D70,L770,D182,L251,D44,R753,U431,R573,D71,R809,U983,L159,U26,R540,U516,R5,D23,L603,U65,L260,D187,R973,U877,R110,U49,L502,D68,R32,U153,R495,D315,R720,D439,R264,D603,R717,U586,R732,D111,R997,U578,L243,U256,R147,D425,L141,U758,R451,U779,R964,D219,L151,D789,L496,D484,R627,D431,R433,D761,R355,U975,L983,U364,L200,U578,L488,U668,L48,D774,R438,D456,L819,D927,R831,D598,L437,U979,R686,U930,L454,D553,L77,D955,L98,U201,L724,U211,R501,U492,L495,U732,L511"""

path2 = """L998,U949,R912,D186,R359,D694,L878,U542,L446,D118,L927,U175,R434,U473,R147,D54,R896,U890,R300,D537,R254,D322,R758,D690,R231,U269,R288,U968,R638,U192,L732,D355,R879,U451,R336,D872,L141,D842,L126,U584,L973,D940,R890,D75,L104,U340,L821,D590,R577,U859,L948,D199,L872,D751,L368,U506,L308,U827,R181,U94,R670,U901,R739,D48,L985,D801,R722,D597,R654,D606,R183,U646,R939,U677,R32,U936,L541,D934,R316,U354,L415,D930,R572,U571,R147,D609,L534,D406,R872,D527,L816,D960,R652,D429,L402,D858,R374,D930,L81,U106,R977,U251,R917,U966,R353,U732,L613,U280,L713,D937,R481,U52,R746,U203,L500,D557,L209,U249,R89,D58,L149,U872,R331,D460,R343,D423,R392,D160,L876,U981,L399,D642,R525,U515,L537,U113,R886,D516,L301,D680,L236,U399,R460,D869,L942,D280,R669,U476,R683,D97,R199,D444,R137,D489,L704,D120,R753,D100,L737,U375,L495,D325,R48,D269,R575,U895,L184,D10,L502,D610,R618,D744,R585,U861,R695,D775,L942,U64,L819,U161,L332,U513,L461,D366,R273,D493,L197,D97,L6,U63,L564,U59,L699,U30,L68,U861,R35,U564,R540,U371,L115,D595,L412,D781,L185,D41,R207,D264,R999,D799,R421,D117,R377,D571,R268,D947,R77,D2,R712,D600,L516,U389,L868,D762,L996,U205,L178,D339,L844,D629,R67,D732,R109,D858,R630,U470,L121,D542,L751,U353,L61,U770,R952,U703,R264,D537,L569,U55,L795,U389,R836,U166,R585,U275,L734,U966,L130,D357,L260,U719,L647,D606,R547,U575,R791,U686,L597,D486,L774,U386,L163,U912,L234,D238,L948,U279,R789,U300,R117,D28,L833,U835,L340,U693,R343,D573,R882,D241,L731,U812,R600,D663,R902,U402,R831,D802,L577,U920,L947,D538,L192"""



function parseToSections(pathString)
    path = split(pathString, ","; keepempty = false)
    point = (0,0)
    sections = Tuple[]
    orientations = Symbol[]

    push!(sections, (0,0))
    for step in path
        direction = step[1]
        distance = parse(Int, step[2:end])

        if direction == 'L'
            point = point .- (distance,0)
            push!(orientations, :L)
        elseif direction == 'R'
            point = point .+ (distance,0)
            push!(orientations, :R)
        elseif direction == 'U'
            point = point .+ (0,distance)
            push!(orientations, :U)
        elseif direction == 'D'
            point = point .- (0,distance)
            push!(orientations, :D)
        end

        push!(sections, point)

    end

    return sections, orientations
end

function findNearestIntersection(p1, p2)

    sections1, orientations1 = parseToSections(p1)
    sections2, orientations2 = parseToSections(p2)

    nextIntersection = (0,0)
    distance = 0
    for i in eachindex(sections1)[1:end-1]
        for j in eachindex(sections2)[1:end-1]
            if ((orientations1[i] in [:L, :R]) && (orientations2[j] in [:U, :D])) || ((orientations1[i] in [:D, :U]) && (orientations2[j] in [:L, :R]))
                currentIntersectionTest = (0,0)
                hLeft = (0,0)
                hRight = (0,0)
                vTop = (0,0)
                vBottom = (0,0)

                if orientations1[i] == :L
                    hLeft = sections1[i+1]
                    hRight = sections1[i]
                elseif orientations1[i] == :R
                    hLeft = sections1[i]
                    hRight = sections1[i+1]
                elseif orientations1[i] == :U
                    vTop = sections1[i+1]
                    vBottom = sections1[i]
                elseif orientations1[i] == :D
                    vTop = sections1[i]
                    vBottom = sections1[i+1]
                end

                if orientations2[j] == :L
                    hLeft = sections2[j+1]
                    hRight = sections2[j]
                elseif orientations2[j] == :R
                    hLeft = sections2[j]
                    hRight = sections2[j+1]
                elseif orientations2[j] == :U
                    vTop = sections2[j+1]
                    vBottom = sections2[j]
                elseif orientations2[j] == :D
                    vTop = sections2[j]
                    vBottom = sections2[j+1]
                end

                horizontalMatch = hLeft[1] <= vTop[1] && vTop[1] <= hRight[1]
                verticalMatch = vBottom[2] <= hRight[2] && hRight[2] <= vTop[2]
                if horizontalMatch && verticalMatch
                    currentIntersectionTest = (vTop[1], hRight[2])

                    if getManhattanDistToOrigin(currentIntersectionTest) < getManhattanDistToOrigin(nextIntersection) || nextIntersection == (0,0)
                        nextIntersection = currentIntersectionTest
                        distance = getManhattanDistToOrigin(nextIntersection)
                    end

                end
            end
        end
    end
    return nextIntersection, distance
end

function getManhattanDistToOrigin(point)
    return sum(abs, point)
end

findNearestIntersection(path1, path2)


#part2
function parseToSections2(pathString)
    path = split(pathString, ","; keepempty = false)
    point = (0,0)
    sections = Tuple[]
    orientations = Symbol[]
    steps = Int[]

    push!(sections, (0,0))
    push!(steps, 0)
    totalSteps = 0
    for step in path
        direction = step[1]
        distance = parse(Int, step[2:end])

        if direction == 'L'
            point = point .- (distance,0)
            push!(orientations, :L)
        elseif direction == 'R'
            point = point .+ (distance,0)
            push!(orientations, :R)
        elseif direction == 'U'
            point = point .+ (0,distance)
            push!(orientations, :U)
        elseif direction == 'D'
            point = point .- (0,distance)
            push!(orientations, :D)
        end
        totalSteps += distance
        push!(steps, totalSteps)
        push!(sections, point)

    end

    return sections, orientations, steps
end

function findFirstIntersection(p1, p2)

    sections1, orientations1, steps1 = parseToSections2(p1)
    sections2, orientations2, steps2 = parseToSections2(p2)

    nextIntersection = (0,0)
    steps = 0
    for i in eachindex(sections1)[1:end-1]
        for j in eachindex(sections2)[1:end-1]
            if ((orientations1[i] in [:L, :R]) && (orientations2[j] in [:U, :D])) || ((orientations1[i] in [:D, :U]) && (orientations2[j] in [:L, :R]))
                currentIntersectionTest = (0,0)
                hLeft = (0,0)
                hRight = (0,0)
                vTop = (0,0)
                vBottom = (0,0)

                if orientations1[i] == :L
                    hLeft = sections1[i+1]
                    hRight = sections1[i]
                elseif orientations1[i] == :R
                    hLeft = sections1[i]
                    hRight = sections1[i+1]
                elseif orientations1[i] == :U
                    vTop = sections1[i+1]
                    vBottom = sections1[i]
                elseif orientations1[i] == :D
                    vTop = sections1[i]
                    vBottom = sections1[i+1]
                end

                if orientations2[j] == :L
                    hLeft = sections2[j+1]
                    hRight = sections2[j]
                elseif orientations2[j] == :R
                    hLeft = sections2[j]
                    hRight = sections2[j+1]
                elseif orientations2[j] == :U
                    vTop = sections2[j+1]
                    vBottom = sections2[j]
                elseif orientations2[j] == :D
                    vTop = sections2[j]
                    vBottom = sections2[j+1]
                end

                horizontalMatch = hLeft[1] <= vTop[1] && vTop[1] <= hRight[1]



                verticalMatch = vBottom[2] <= hRight[2] && hRight[2] <= vTop[2]
                if horizontalMatch && verticalMatch
                    currentIntersectionTest = (vTop[1], hRight[2])
                    deltaHorizontal = 0
                    deltaVertical = 0
                    if (orientations1[i] == :L) || (orientations2[j] == :L)
                        deltaHorizontal = hRight[1] - vTop[1]
                    elseif (orientations1[i] == :R) || (orientations2[j] == :R)
                        deltaHorizontal = vTop[1] - hLeft[1]
                    end

                    if (orientations1[i] == :D) || (orientations2[j] == :D)
                        deltaVertical = vTop[2] - hRight[2]
                    elseif (orientations1[i] == :U) || (orientations2[j] == :U)
                        deltaVertical = hRight[2] - vBottom[2]
                    end
                    println(currentIntersectionTest)
                    stepsToIntersection = steps1[i] + steps2[j] + deltaHorizontal + deltaVertical
                    if stepsToIntersection < steps || nextIntersection == (0,0)
                        nextIntersection = currentIntersectionTest
                        steps = stepsToIntersection
                    end

                end
            end
        end
    end
    return nextIntersection, steps
end
)

findFirstIntersection(path1, path2)