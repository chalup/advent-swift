import Foundation

enum InterpreterError : Error {
    case invalidOpcode(ip: Int, opcode: Int, dump: [Int])
    case usingOutParamInImmediateMode(ip: Int, opcode: Int, n: Int, dump: [Int])
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

enum ParamMode {
    case immediate
    case position
}

class IntcodeInterpreter {
    private var ip = 0
    private var memory: [Int]
    private var inputs: [Int] = []
    private var status: InterpreterStatus = InterpreterStatus.Running
    
    init(_ program: [Int]) {
        memory = program
    }
    
    func sendInput(_ input: Int) {
        inputs.append(input)
    }
    
    private func fetchOpcode() -> Int { memory[ip] % 100 }
    
    private func inParam(_ n: Int) -> Int {
        switch paramMode(n) {
        case .immediate: return memory[ip+n]
        case .position: return memory[memory[ip+n]]
        }
    }
    
    private func setOutParam(_ n: Int, value: Int) {
        switch paramMode(n) {
        case .immediate: status = InterpreterStatus.Error(error: InterpreterError.usingOutParamInImmediateMode(ip: ip, opcode: fetchOpcode(), n: n, dump: memory))
            case .position: memory[memory[ip+n]] = value
        }
    }
    
    private func paramMode(_ n: Int) -> ParamMode {
        var flag = memory[ip] / 100
        
        for _ in 1..<n { flag /= 10 }
        
        if flag % 10 == 0 { return ParamMode.position } else { return ParamMode.immediate }
    }
    
    func execute() -> ProgramResult {
        while true {
            switch status {
            case .Running:
                let opcode = fetchOpcode()
                
                switch opcode {
                case 1:
                    setOutParam(3, value: inParam(1) + inParam(2))
                    ip += 4
                case 2:
                    setOutParam(3, value: inParam(1) * inParam(2))
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
