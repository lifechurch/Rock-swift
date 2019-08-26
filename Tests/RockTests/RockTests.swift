import XCTest
@testable import Rock

final class RockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Rock().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
