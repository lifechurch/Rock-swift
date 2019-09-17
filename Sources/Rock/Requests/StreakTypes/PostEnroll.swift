import Foundation

public struct PostEnroll: APIRequest {
    typealias Response = Int

    var method: HTTPMethod { return .post }

    var path: String { return "api/StreakTypes/Enroll/\(streakTypeID)" }
    
    public let streakTypeID: Int
}
