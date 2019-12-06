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
