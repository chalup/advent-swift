import Foundation

fileprivate func runDiagnostics(_ program: String, systemId: Int) throws -> Int {
    let interpreter = IntcodeInterpreter(parseProgram(program))
    interpreter.sendInput(systemId)
    
    func run() throws -> [Int] {
        var outputs: [Int] = []

        while true {
            let result = interpreter.execute()
            
            switch result {
            case .finished: return outputs
            case .executionError(let error): throw error
            case .generatedOutput(let output): outputs.append(output)
            }
        }
    }
    
    let outputs = try run()
    assert(outputs.dropLast().allSatisfy { $0 == 0 })
    return outputs.last!
}

public func day5task1(program: String) throws -> Int { try runDiagnostics(program, systemId: 1) }
public func day5task2(program: String) throws -> Int { try runDiagnostics(program, systemId: 5) }
