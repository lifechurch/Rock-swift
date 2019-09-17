import Foundation

public struct GetStreaks: APIRequest {
    public typealias Response = [Streak]

    public var method: HTTPMethod { return .get }

    public var path: String {
        let parameters: [String: String] = [
            "$filter": "PersonAliasId eq \(personAliasId)",
            "$expand": "StreakType",
        ]
        return "api/Streaks?\(parameters.urlQueryEscaped)"
    }
        
    public let personAliasId: Int
}
