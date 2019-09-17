import Foundation

public struct GetRecentEngagement: APIRequest {
    public typealias Response = [Engagement?]

    public var method: HTTPMethod { .get }

    public var path: String { "api/StreakTypes/RecentEngagement/\(streakTypeID)/\(personID)" }
    
    public let streakTypeID: Int
    
    public let personID: Int
    
    public init(streakTypeID: Int, personID: Int) {
        self.streakTypeID = streakTypeID
        self.personID = personID
    }
}
