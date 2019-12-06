import Foundation

enum InterpreterError : Error {
    case invalidOpcode(ip: Int, opcode: Int, dump: [Int])
}

enum ProgramResult {
    case finished(finalState: [Int])
    case executionError(error: InterpreterError)
}

class IntcodeInterpreter {
    static func execute(_ program: [Int]) -> ProgramResult {
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
                return ProgramResult.finished(finalState: memory)
            default:
                return ProgramResult.executionError(error: InterpreterError.invalidOpcode(ip: ip, opcode: opcode, dump: memory))
            }
        }
    }
}
