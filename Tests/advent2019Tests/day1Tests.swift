import XCTest
@testable import advent2019

final class day1Tests: XCTestCase {
    func testFuelRequirements() {
        XCTAssertEqual(fuelRequirements(mass: 12), 2)
        XCTAssertEqual(fuelRequirements(mass: 14), 2)
        XCTAssertEqual(fuelRequirements(mass: 1969), 654)
        XCTAssertEqual(fuelRequirements(mass: 100756), 33583)
    }
    
    func testTotalFuelRequirements() {
        XCTAssertEqual(totalFuelRequirements(moduleMass: 14), 2)
        XCTAssertEqual(totalFuelRequirements(moduleMass: 1969), 966)
        XCTAssertEqual(totalFuelRequirements(moduleMass: 100756), 50346)
    }
    
    static var allTests = [
        ("Day 1: calculate fuel requirements", testFuelRequirements),
        ("Day 1: calculate total fuel requirements", testTotalFuelRequirements),
    ]
}
