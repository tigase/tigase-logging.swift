import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(tigase_loggingTests.allTests),
    ]
}
#endif
