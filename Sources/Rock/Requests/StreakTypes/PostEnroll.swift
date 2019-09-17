import Foundation

public struct PostEnroll: APIRequest {
    public typealias Response = Int

    public var method: HTTPMethod { .post }

    public var path: String { "api/StreakTypes/Enroll/\(streakTypeID)" }
    
    public let streakTypeID: Int
    
    public init(streakTypeID: Int) {
        self.streakTypeID = streakTypeID
    }
}
