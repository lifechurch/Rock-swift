import Foundation

public struct PostMarkEngagement: APIRequest {
    public typealias Response = Empty
    
    public var method: HTTPMethod { return .post }

    public var path: String { return "api/StreakTypes/MarkEngagement/\(streakTypeID)" }
    
    public let streakTypeID: Int
    
    public let groupID: Int
    
    public let locationID: Int
}
