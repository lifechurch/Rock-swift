import Foundation

public struct PostEnroll: APIRequest {
    public typealias Response = Int

    public var method: HTTPMethod { return .post }

    public var path: String { return "api/StreakTypes/Enroll/\(streakTypeID)" }
    
    public let streakTypeID: Int
}
