import Foundation

func finalFrequency(changes: [String]) -> Int {
    return changes
        .map { Int($0)! }
        .reduce(0) { $0 + $1 }
}

func detectCycle(changes: [String]) -> Int {
    var currentFrequency = 0
    var observedFrequencies: Set<Int> = [0]
    
    while true {
        for change in changes {
            currentFrequency += Int(change)!
            
            let (inserted, _) = observedFrequencies.insert(currentFrequency)
            
            if (!inserted) {
                return currentFrequency
            }
        }
    }
}
