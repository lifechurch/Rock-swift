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
        
        Rock.API.send(GetGroups(name: "App Attendance")) { result in
            if case .success(let list) = result {
                assert(list.count > 0)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testGetStreakData() {
        let expectation = self.expectation(description: "Send")

        Rock.API.send(GetStreakData(streakTypeIDs: [<#strekTypeID#>])) { result in
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

        Rock.API.send(PostEnroll(streakTypeID: <#strekTypeID#>)) { result in
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

        Rock.API.send(PostMarkEngagement(streakTypeID: <#strekTypeID#>, groupID: <#groupID#>, locationID: <#locationID#>)) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }
    
    func testGetInteractionComponent() {
        let expectation = self.expectation(description: "Send")

        Rock.API.send(GetInteractionComponent(guid: <#guid#>)) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }
    
    func testGetInteractionStatistics() {
        let expectation = self.expectation(description: "Send")

        Rock.API.send(GetInteractionStatistics(interactionChannelID: <#interactionChannelID#>, interactionComponentID: <#interactionComponentID#>)) { result in
            if case .success = result {
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
    }
    
    func testIncrementInteractionStatistics() {
        var interactionStatistics = InteractionStatistics(
            interactionsAllTime: 5,
            interactionsThatDay: 2,
            interactionsThatMonth: 3,
            interactionsThatYear: 4
        )
        
        interactionStatistics.increment()
        
        assert(interactionStatistics.interactionsAllTime == 6)
        assert(interactionStatistics.interactionsThatDay == 3)
        assert(interactionStatistics.interactionsThatMonth == 4)
        assert(interactionStatistics.interactionsThatYear == 5)
    }
    
    func testPostInteraction() {
        let expectation = self.expectation(description: "Send")
        
        let request = PostInteraction(operation: "test", interactionComponentID: <#interactionComponentID#>, interactionSummary: "test", interactionData: "1", interactionDateTime: "2019-11-13T00:00:00.000Z", personAliasID: <#personAliasID#>)

        Rock.API.send(request) { result in
            if case .success = result {
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
