import XCTest
@testable import advent2019

final class day2Tests: XCTestCase {
    func testProgramExecution() {
        XCTAssertEqual(try! parseProgram("1,0,0,0,99").execute(), [2,0,0,0,99])
        XCTAssertEqual(try! parseProgram("2,3,0,3,99").execute(), [2,3,0,6,99])
        XCTAssertEqual(try! parseProgram("2,4,4,5,99,0").execute(), [2,4,4,5,99,9801])
        XCTAssertEqual(try! parseProgram("1,1,1,4,99,5,6,0,99").execute(), [30,1,1,4,2,5,6,0,99])
    }
    
    static var allTests = [
        ("Day 2: program execution test", testProgramExecution),
    ]
}
