import Foundation

func fuelRequirements(mass: Int) -> Int {
    return mass / 3 - 2
}

func totalFuelRequirements(moduleMass: Int) -> Int {
    var total = 0
    var mass = moduleMass
    
    while(mass > 0) {
        mass = max(0, fuelRequirements(mass: mass))
        total += mass
    }

    return total
}

fileprivate func parseInput(_ input: [String]) -> [Int] {
    return input.map { Int($0)! }
}

public func day1task1(input: [String]) -> Int {
    return parseInput(input).reduce(0) { $0 + fuelRequirements(mass: $1) }
}

public func day1task2(input: [String]) -> Int {
    return parseInput(input).reduce(0) { $0 + totalFuelRequirements(moduleMass: $1) }
}
