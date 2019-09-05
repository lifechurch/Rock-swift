import Foundation

struct PostMarkEngagement: APIRequest {
    typealias Response = Empty
    
    var method: HTTPMethod { return .post }

    var path: String { return "api/StreakTypes/MarkEngagement/\(streakTypeID)" }
    
    let streakTypeID: Int
    
    let locationID: Int
}
