import Foundation

public struct GetRecentEngagement: APIRequest {
    typealias Response = [Engagement?]

    var method: HTTPMethod { return .get }

    var path: String {
        return "api/StreakTypes/RecentEngagement/\(streakTypeID)/\(personID)"
    }
    
    let streakTypeID: Int
    
    let personID: Int
}
