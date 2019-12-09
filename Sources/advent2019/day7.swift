import Foundation

public func day7task1(programInput: String) -> Int {
    let phaseConfigs = (0..<5).permutations()
    let ampProgram = parseProgram(programInput)
    
    return phaseConfigs
        .map { config in
            return config.reduce(0) { (signal, phase) in
                let interpreter = IntcodeInterpreter(ampProgram)
                interpreter.sendInput(phase)
                interpreter.sendInput(signal)
                switch(interpreter.execute()) {
                case .finished: fatalError("Program halted prematurely")
                case .executionError(let error): fatalError("Program halted with error: \(error)")
                case .generatedOutput(let output): return output
                }
            }
        }
        .max()!
}

extension Collection {
    private func destructure() -> (Element, SubSequence)? {
        guard let head = first else { return nil }
        return (head, self[index(after: startIndex)..<endIndex])
    }
    
    func permutations() -> [[Element]] {
        guard let (head, tail) = self.destructure() else { return [[]] }
        
        return tail.perms().flatMap { others in
            return (others.startIndex...others.endIndex).map { index in
                var result = others
                result.insert(head, at: index)
                return result
            }
        }
    }
}
