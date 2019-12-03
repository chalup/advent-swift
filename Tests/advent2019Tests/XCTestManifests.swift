import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(day1Tests.allTests),
        testCase(day2Tests.allTests),
        testCase(day3Tests.allTests),
    ]
}
#endif
