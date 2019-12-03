import XCTest
@testable import advent2019

final class day3Tests: XCTestCase {
    func testNearestIntersection() {
        XCTAssertEqual(try distanceToNearestIntersection(wireSpecs: ["R8,U5,L5,D3", "U7,R6,D4,L4"]), 6)
        XCTAssertEqual(try distanceToNearestIntersection(wireSpecs: ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"]), 159)
        XCTAssertEqual(try distanceToNearestIntersection(wireSpecs: ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]), 135)
    }
    
    func testShortestIntersectionPath() {
        XCTAssertEqual(try shortestIntersectionPath(wireSpecs: ["R8,U5,L5,D3", "U7,R6,D4,L4"]), 30)
        XCTAssertEqual(try shortestIntersectionPath(wireSpecs: ["R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83"]), 610)
        XCTAssertEqual(try shortestIntersectionPath(wireSpecs: ["R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"]), 410)
    }
    
    static var allTests = [
        ("Day 3: test nearest intersection", testNearestIntersection),
        ("Day 3: test shortest intersection path", testShortestIntersectionPath),
    ]
}
