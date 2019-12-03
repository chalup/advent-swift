import Foundation

import advent2019

func advent(day: Int, task: Int, block: () throws -> Any) rethrows {
    let start = Date()
    let result = try block()
    let elapsedMs: Int = Int(-start.timeIntervalSinceNow * 1_000)
    
    print("Day \(day), task \(task) [\(elapsedMs)ms]: \(result)")
}

do {
    let dir = CommandLine.arguments[1]

    let day1 = try String(contentsOfFile: dir + "day1.txt").lines()
    let day2 = try String(contentsOfFile: dir + "day2.txt").singleLine()
    let day3 = try String(contentsOfFile: dir + "day3.txt").lines()

    advent(day: 1, task: 1) { day1task1(input: day1) }
    advent(day: 1, task: 2) { day1task2(input: day1) }
    try advent(day: 2, task: 1) { try day2task1(input: day2) }
    try advent(day: 2, task: 2) { try day2task2(input: day2, desiredOutput: 19690720) }
    try advent(day: 3, task: 1) { try distanceToNearestIntersection(wireSpecs: day3) }
    try advent(day: 3, task: 2) { try shortestIntersectionPath(wireSpecs: day3) }
} catch {
    print("uh oh :( \(error)")
}
