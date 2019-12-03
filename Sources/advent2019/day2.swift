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
        if let noun = noun { memory[1] = noun }
        if let verb = verb { memory[2] = verb }
        
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

public func day2task1(input: String) throws -> Int {
    return try parseProgram(input).execute(noun: 12, verb: 2)[0]
}

class CannotFindNounAndVerb : Error {}

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
    throw CannotFindNounAndVerb()
}
