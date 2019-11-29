import XCTest
@testable import advent2019

final class day1Tests: XCTestCase {
    func testFinalFrequency() {
        XCTAssertEqual(finalFrequency(changes: ["+1", "-2", "+3", "+1"]), 3)
        XCTAssertEqual(finalFrequency(changes: ["+1", "+1", "+1"]), 3)
        XCTAssertEqual(finalFrequency(changes: ["+1", "+1", "-2"]), 0)
        XCTAssertEqual(finalFrequency(changes: ["-1", "-2", "-3"]), -6)
    }
    
    func testLoopDetection() {
        XCTAssertEqual(detectCycle(changes: ["+1", "-2", "+3", "+1"]), 2)
        XCTAssertEqual(detectCycle(changes: ["+1", "-1"]), 0)
        XCTAssertEqual(detectCycle(changes: ["+3", "+3", "+4", "-2", "-4"]), 10)
        XCTAssertEqual(detectCycle(changes: ["-6", "+3", "+8", "+6", "-6"]), 5)
        XCTAssertEqual(detectCycle(changes: ["+7", "+7", "-2", "-7", "-4"]), 14)
    }
    
    static var allTests = [
        ("Day 1: calculate final frequency", testFinalFrequency),
        ("Day 1: detect frequency loop", testLoopDetection),
    ]
}
