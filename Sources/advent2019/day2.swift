import Foundation

func parseProgram(_ input: String) -> [Int] { input.split(separator: ",").map { String($0).asInt() } }

func tweak(program: [Int], noun: Int, verb: Int) -> [Int] {
    var tweakedProgram = program
    
    tweakedProgram[1] = noun
    tweakedProgram[2] = verb
    
    return tweakedProgram
}

public func day2task1(input: String) throws -> Int {
    let program = tweak(program: parseProgram(input), noun: 12, verb: 2)
    return try IntcodeInterpreter.execute(program)[0]
}

enum Day2Error : Error {
    case cannotFindNounAndVerb
}

public func day2task2(input: String, desiredOutput: Int) throws -> Int {
    let program = parseProgram(input)

    for noun in 0...99 {
        for verb in 0...99 {
            let output = try IntcodeInterpreter.execute(tweak(program: program, noun: noun, verb: verb))[0]
            if (output == desiredOutput) {
                return noun * 100 + verb
            }
        }
    }

    throw Day2Error.cannotFindNounAndVerb
}
