import XCTest
@testable import advent2019

final class day2Tests: XCTestCase {
    private func runProgram(_ program: String) throws -> [Int] {
        let result = IntcodeInterpreter(parseProgram(program)).execute()
        
        switch result {
        case .executionError(let error): throw error
        case .finished(let finalState): return finalState
        }
    }
    
    func testProgramExecution() {
        XCTAssertEqual(try! runProgram("1,0,0,0,99"), [2,0,0,0,99])
        XCTAssertEqual(try! runProgram("2,3,0,3,99"), [2,3,0,6,99])
        XCTAssertEqual(try! runProgram("2,4,4,5,99,0"), [2,4,4,5,99,9801])
        XCTAssertEqual(try! runProgram("1,1,1,4,99,5,6,0,99"), [30,1,1,4,2,5,6,0,99])
    }
    
    static var allTests = [
        ("Day 2: program execution test", testProgramExecution),
    ]
}
