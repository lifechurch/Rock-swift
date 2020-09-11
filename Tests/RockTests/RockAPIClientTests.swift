import XCTest
@testable import Rock

final class RockAPIClientTests: XCTestCase {
    
    let domain = <#domain#>
    let token = <#token#>
    
    let streakTypeID = <#streakTypeID#>
    let groupID = <#groupID#>
    let locationID = <#locationID#>
    let personAliasID = <#personAliasID#>
    let groupGUID = <#groupGUID#>
    
    override func setUp() {
        super.setUp()

        Rock.configure(baseURL: URL(string: domain))

        Rock.assign(token: token)
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
    
    func testGetGroupsByName() {
        let expectation = self.expectation(description: "Send")
        
        Rock.API.send(GetGroups(name: "App Attendance")) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetGroupsByGUID() {
        let expectation = self.expectation(description: "Send")
        
        Rock.API.send(GetGroups(guid: groupGUID)) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetStreakData() {
        let expectation = self.expectation(description: "Send")

        Rock.API.send(GetStreakData(streakTypeIDs: [streakTypeID])) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                assert(list.first?.engagementsThisYear ?? 0 > 0)
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

        Rock.API.send(PostEnroll(streakTypeID: streakTypeID)) { result in
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

        Rock.API.send(PostMarkEngagement(streakTypeID: streakTypeID, groupID: groupID, locationID: locationID)) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }
    
    func testCache() {
        Rock.API.urlSession.configuration.urlCache?.removeAllCachedResponses()
        
        let request = GetGroups(name: "App Attendance")
        
        assert(Rock.API.load(request) == nil)
        
        let expectation = self.expectation(description: "Send")
        
        Rock.API.send(request) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                assert(Rock.API.load(request)!.count > 0)
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
    ]
}
