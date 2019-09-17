import Foundation

public struct GetStreakTypes: APIRequest {
    public typealias Response = [StreakType]

    public var method: HTTPMethod { .get }

    public var path: String { "api/StreakTypes" }
    
    public init() { }
}
