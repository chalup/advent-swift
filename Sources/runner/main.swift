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
    let day5 = try String(contentsOfFile: dir + "day5.txt").singleLine()
    let day6 = try String(contentsOfFile: dir + "day6.txt").lines()
    let day7 = try String(contentsOfFile: dir + "day7.txt").singleLine()

    advent(day: 1, task: 1) { day1task1(input: day1) }
    advent(day: 1, task: 2) { day1task2(input: day1) }
    try advent(day: 2, task: 1) { try day2task1(input: day2) }
    try advent(day: 2, task: 2) { try day2task2(input: day2, desiredOutput: 19690720) }
    advent(day: 3, task: 1) { distanceToNearestIntersection(wireSpecs: day3) }
    advent(day: 3, task: 2) { shortestIntersectionPath(wireSpecs: day3) }
    advent(day: 4, task: 1) { day4task1(range: 272091...815432) }
    advent(day: 4, task: 2) { day4task2(range: 272091...815432) }
    try advent(day: 5, task: 1) { try day5task1(program: day5) }
    try advent(day: 5, task: 2) { try day5task2(program: day5) }
    advent(day: 6, task: 1) { day6task1(input: day6) }
    advent(day: 6, task: 2) { day6task2(input: day6) }
    advent(day: 7, task: 1) { day7task1(programInput: day7) }
} catch {
    print("uh oh :( \(error)")
}
