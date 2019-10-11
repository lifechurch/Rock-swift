import Foundation

public struct GetStreakData: APIRequest {
    public typealias Response = [StreakData]

    public var method: HTTPMethod { .get }

    public var path: String { "api/StreakTypes/StreakData/\(streakTypeIDs.map({ "\($0)" }).joined(separator: ","))" }
    
    public let streakTypeIDs: [Int]
    
    public init(streakTypeIDs: [Int]) {
        self.streakTypeIDs = streakTypeIDs
    }
}
