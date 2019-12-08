import Foundation

enum InterpreterError : Error {
    case invalidOpcode(ip: Int, opcode: Int, dump: [Int])
}

enum ProgramResult {
    case finished(finalState: [Int])
    case executionError(error: InterpreterError)
}

enum InterpreterStatus {
    case Running
    case Halted
    case Error(error: InterpreterError)
}

class IntcodeInterpreter {
    private var ip = 0
    private var memory: [Int]
    private var status: InterpreterStatus = InterpreterStatus.Running
    
    init(_ program: [Int]) {
        memory = program
    }
    
    func execute() -> ProgramResult {
        while true {
            switch status {
            case .Running:
                let opcode = memory[ip]
                
                switch opcode {
                case 1:
                    memory[memory[ip + 3]] = memory[memory[ip + 1]] + memory[memory[ip + 2]]
                    ip += 4
                case 2:
                    memory[memory[ip + 3]] = memory[memory[ip + 1]] * memory[memory[ip + 2]]
                    ip += 4
                case 99:
                    status = InterpreterStatus.Halted
                default:
                    status = InterpreterStatus.Error(error: InterpreterError.invalidOpcode(ip: ip, opcode: opcode, dump: memory))
                }
            case .Halted: return ProgramResult.finished(finalState: memory)
            case .Error(let error): return ProgramResult.executionError(error: error)
            }
        }
    }
}
