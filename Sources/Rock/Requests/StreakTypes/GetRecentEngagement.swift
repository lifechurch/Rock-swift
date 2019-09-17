import Foundation

public struct GetRecentEngagement: APIRequest {
    typealias Response = [Engagement?]

    var method: HTTPMethod { return .get }

    var path: String {
        return "api/StreakTypes/RecentEngagement/\(streakTypeID)/\(personID)"
    }
    
    public let streakTypeID: Int
    
    public let personID: Int
}
