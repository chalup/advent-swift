import Foundation

enum IntcodeError : Error {
    case invalidOpcode(opcode: Int)
}

class IntcodeInterpreter {
    static func execute(_ program: [Int]) throws -> [Int] {
        var memory = program
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
