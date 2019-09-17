import XCTest
@testable import Rock

final class RockAPIClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

        Rock.configure(baseURL: URL(string: <#domain#>))

        Rock.assign(token: <#token#>)
    }
    
    func testGetCampuses() {
        let expectation = self.expectation(description: "Send")
        
        Rock.API.send(GetCampuses()) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetGroups() {
        let expectation = self.expectation(description: "Send")
        
        Rock.API.send(GetGroups()) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetStreaks() {
        let expectation = self.expectation(description: "Send")
        
        Rock.API.send(GetStreaks(personAliasId: 220324)) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetRecentEngagement() {
        let expectation = self.expectation(description: "Send")

        Rock.API.send(GetRecentEngagement(streakTypeID: 18, personID: 540527)) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }
    
    func testGetStreakTypes() {
        let expectation = self.expectation(description: "Send")
        
        Rock.API.send(GetStreakTypes()) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
        
    func testPostEnroll() {
        let expectation = self.expectation(description: "Send")

        Rock.API.send(PostEnroll(streakTypeID: 17)) { result in
            switch result {
            case .success(let id):
                print(id)
                expectation.fulfill()
            case .failure(let error):
                assert(error.localizedDescription == "The streak already exists")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }
        
    func testPostMarkEngagement() {
        let expectation = self.expectation(description: "Send")

        Rock.API.send(PostMarkEngagement(streakTypeID: 18, groupID: 2276359, locationID: 15)) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure(let error):
                assert(error.localizedDescription == "The streak already exists")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }

    #if canImport(Combine)
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func testPublisher() {
        let expectation = self.expectation(description: "Publisher")

        let cancellable = Rock.API.publisher(GetCampuses())?
            .replaceError(with: [])
            .sink(receiveValue: { list in
                assert(list.count > 0)
                expectation.fulfill()
            })

        waitForExpectations(timeout: 10)

        cancellable?.cancel()
    }
    #endif

    static var allTests = [
        ("testGetCampuses", testGetCampuses),
        ("testGetStreakTypes", testGetStreakTypes),
        ("testPostEnroll", testPostEnroll),
        ("testPostMarkEngagement", testPostMarkEngagement),
        ("testGetRecentEngagement", testGetRecentEngagement),
    ]
}
