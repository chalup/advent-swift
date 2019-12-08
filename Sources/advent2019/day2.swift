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
    
    switch IntcodeInterpreter(program).execute() {
    case .finished(let finalState):
        return finalState[0]
    case .executionError(let error):
        throw error
    }
}

enum Day2Error : Error {
    case cannotFindNounAndVerb
}

public func day2task2(input: String, desiredOutput: Int) throws -> Int {
    let program = parseProgram(input)

    for noun in 0...99 {
        for verb in 0...99 {
            let program = tweak(program: program, noun: noun, verb: verb)

            switch IntcodeInterpreter(program).execute() {
            case .finished(let finalState):
                if (finalState[0] == desiredOutput) {
                    return noun * 100 + verb
                }
            case .executionError: Void()
            }
        }
    }

    throw Day2Error.cannotFindNounAndVerb
}
