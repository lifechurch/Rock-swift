import XCTest
@testable import Rock

final class StringConvertsTests: XCTestCase {
    
    let pairs = [
        ("Id", "id"),
        ("Guid", "guid"),
        ("Name", "name"),
        ("ShortCode", "shortCode"),
        ("LocationId", "locationID"),
        ("IsActive", "isActive"),
    ]
    
    func testToSwiftKey() {
        for pair in pairs {
            assert(pair.0.toSwiftKey() == pair.1)
        }
    }
    
    func testToRockKey() {
        for pair in pairs {
            print(pair.1)
            assert(pair.1.toRockKey() == pair.0)
        }
    }
    
    static var allTests = [
        ("testToSwiftKey", testToSwiftKey),
        ("testToRockKey", testToRockKey),
    ]
}
