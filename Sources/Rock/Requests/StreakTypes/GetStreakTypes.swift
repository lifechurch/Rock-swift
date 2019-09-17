import Foundation

public struct GetStreakTypes: APIRequest {
    public typealias Response = [StreakType]

    public var method: HTTPMethod { return .get }

    public var path: String { return "api/StreakTypes" }
}
