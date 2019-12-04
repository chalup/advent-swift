import XCTest
@testable import advent2019

final class day4Tests: XCTestCase {
    func testNonDecreasingCheck() {
        XCTAssertTrue(isNotDecreasing("111111"))
        XCTAssertFalse(isNotDecreasing("223450"))
        XCTAssertTrue(isNotDecreasing("123789"))
    }

    func testDoublePresentCheck() {
        XCTAssertTrue(containsDouble("111111"))
        XCTAssertTrue(containsDouble("223450"))
        XCTAssertFalse(containsDouble("123789"))
    }
    
    func testSeparatedDoublePresentCheck() {
        XCTAssertTrue(containsSeparatedDouble("112233"))
        XCTAssertFalse(containsSeparatedDouble("123444"))
        XCTAssertFalse(containsSeparatedDouble("111444"))
        XCTAssertTrue(containsSeparatedDouble("111122"))
        XCTAssertTrue(containsSeparatedDouble("221111"))
        XCTAssertTrue(containsSeparatedDouble("113444"))
        XCTAssertFalse(containsSeparatedDouble("124444"))
        XCTAssertTrue(containsSeparatedDouble("123345"))
    }
    
    static var allTests = [
        ("Day 4: test non-decreasing check", testNonDecreasingCheck),
    ]
}
