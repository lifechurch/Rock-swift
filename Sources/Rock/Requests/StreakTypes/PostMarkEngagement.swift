import Foundation

public struct PostMarkEngagement: APIRequest {
    typealias Response = Empty
    
    var method: HTTPMethod { return .post }

    var path: String { return "api/StreakTypes/MarkEngagement/\(streakTypeID)" }
    
    public let streakTypeID: Int
    
    public let groupID: Int
    
    public let locationID: Int
}
