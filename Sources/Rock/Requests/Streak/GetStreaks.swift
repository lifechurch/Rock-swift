import Foundation

public struct GetStreaks: APIRequest {
    typealias Response = [Streak]

    var method: HTTPMethod { return .get }

    var path: String {
        let parameters: [String: String] = [
            "$filter": "PersonAliasId eq \(personAliasId)",
            "$expand": "StreakType",
        ]
        return "api/Streaks?\(parameters.urlQueryEscaped)"
    }
        
    public let personAliasId: Int
}
