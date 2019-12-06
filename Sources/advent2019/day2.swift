import Foundation

func parseProgram(_ input: String) -> IntcodeProgram {
    return IntcodeProgram(initialProgram: input.split(separator: ",").map { String($0).asInt() })
}

public func day2task1(input: String) throws -> Int {
    return try parseProgram(input).execute(noun: 12, verb: 2)[0]
}

enum Day2Error : Error {
    case cannotFindNounAndVerb
}

public func day2task2(input: String, desiredOutput: Int) throws -> Int {
    let program = parseProgram(input)

    for noun in 0...99 {
        for verb in 0...99 {
            let output = try program.execute(noun: noun, verb: verb)[0]
            if (output == desiredOutput) {
                return noun * 100 + verb
            }
        }
    }
    throw Day2Error.cannotFindNounAndVerb
}
