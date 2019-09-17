import Foundation

public struct PostMarkEngagement: APIRequest {
    typealias Response = Empty
    
    var method: HTTPMethod { return .post }

    var path: String { return "api/StreakTypes/MarkEngagement/\(streakTypeID)" }
    
    let streakTypeID: Int
    
    let groupID: Int
    
    let locationID: Int
}
