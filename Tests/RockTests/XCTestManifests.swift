import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RockTests.allTests),
        testCase(StringConvertsTests.allTests),
    ]
}
#endif
