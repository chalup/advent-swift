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

struct State {
    var ip = 0
    var memory: [Int]
    var status: InterpreterStatus = InterpreterStatus.Running
    
    init(program: [Int]) {
        memory = program
    }
    
}

class IntcodeInterpreter {
    static func execute(_ program: [Int]) -> ProgramResult {
        var state = State(program: program)
        
        while true {
            switch state.status {
            case .Running:
                let opcode = state.memory[state.ip]
                
                switch opcode {
                case 1:
                    state.memory[state.memory[state.ip + 3]] = state.memory[state.memory[state.ip + 1]] + state.memory[state.memory[state.ip + 2]]
                    state.ip += 4
                case 2:
                    state.memory[state.memory[state.ip + 3]] = state.memory[state.memory[state.ip + 1]] * state.memory[state.memory[state.ip + 2]]
                    state.ip += 4
                case 99:
                    state.status = InterpreterStatus.Halted
                default:
                    state.status = InterpreterStatus.Error(error: InterpreterError.invalidOpcode(ip: state.ip, opcode: opcode, dump: state.memory))
                }
            case .Halted: return ProgramResult.finished(finalState: state.memory)
            case .Error(let error): return ProgramResult.executionError(error: error)
            }
        }
    }
}
