import Foundation

public struct GetRecentEngagement: APIRequest {
    public typealias Response = [Engagement?]

    public var method: HTTPMethod { return .get }

    public var path: String {
        return "api/StreakTypes/RecentEngagement/\(streakTypeID)/\(personID)"
    }
    
    public let streakTypeID: Int
    
    public let personID: Int
}
