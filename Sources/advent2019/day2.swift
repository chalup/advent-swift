import Foundation

enum IntcodeError : Error {
    case invalidOpcode(opcode: Int)
}

class IntcodeProgram {
    let initialMemory: [Int]
    
    init(initialProgram: [Int]) {
        initialMemory = initialProgram
    }
    
    func execute(noun: Int? = nil, verb: Int? = nil) throws -> [Int] {
        var memory = initialMemory
        if (noun != nil) { memory[1] = noun! }
        if (verb != nil) { memory[2] = verb! }
        
        var ip = 0
        
        while true {
            let opcode = memory[ip]
            
            switch opcode {
            case 1:
                memory[memory[ip + 3]] = memory[memory[ip + 1]] + memory[memory[ip + 2]]
                ip += 4
            case 2:
                memory[memory[ip + 3]] = memory[memory[ip + 1]] * memory[memory[ip + 2]]
                ip += 4
            case 99:
                return memory
            default:
                throw IntcodeError.invalidOpcode(opcode: opcode)
            }
        }
    }
}

func parseProgram(_ input: String) -> IntcodeProgram {
    return IntcodeProgram(initialProgram: input.split(separator: ",").map { Int($0)! })
}

public func day2task1() -> Int {
    return try! parseProgram(day2input).execute(noun: 12, verb: 2)[0]
}

class CannotFindNounAndVerb : Error {}

let day2input = "1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,13,19,2,9,19,23,1,23,6,27,1,13,27,31,1,31,10,35,1,9,35,39,1,39,9,43,2,6,43,47,1,47,5,51,2,10,51,55,1,6,55,59,2,13,59,63,2,13,63,67,1,6,67,71,1,71,5,75,2,75,6,79,1,5,79,83,1,83,6,87,2,10,87,91,1,9,91,95,1,6,95,99,1,99,6,103,2,103,9,107,2,107,10,111,1,5,111,115,1,115,6,119,2,6,119,123,1,10,123,127,1,127,5,131,1,131,2,135,1,135,5,0,99,2,0,14,0"


public func day2task2() throws -> Int {
    for noun in 0...99 {
        for verb in 0...99 {
            let output = try parseProgram(day2input).execute(noun: noun, verb: verb)[0]
            if (output == 19690720) {
                return noun * 100 + verb
            }
        }
    }
    throw CannotFindNounAndVerb()
}
