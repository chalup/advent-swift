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
    func permutations() -> [[Element]] {
        func helper(results: inout [[Element]], head: [Element], elements: [Element]) {
            if (elements.isEmpty) {
                results.append(head)
            } else {
                for i in elements.indices {
                    var newElements = elements
                    
                    let e = newElements.remove(at: i)
                    
                    var newHead = head
                    newHead.append(e)
                    
                    helper(results: &results, head: newHead, elements: newElements)
                }
            }
        }
        
        var result: [[Element]] = []
        helper(results: &result, head: [], elements: Array(self))
        return result
    }
}
