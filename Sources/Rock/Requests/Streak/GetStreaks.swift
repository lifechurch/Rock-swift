import Foundation

public struct GetStreaks: APIRequest {
    public typealias Response = [Streak]

    public var method: HTTPMethod { .get }

    public var path: String {
        let parameters: [String: String] = [
            "$filter": "PersonAliasId eq \(personAliasID)",
            "$expand": "StreakType",
        ]
        return "api/Streaks?\(parameters.urlQueryEscaped)"
    }
        
    public let personAliasID: Int
    
    public init(personAliasID: Int) {
        self.personAliasID = personAliasID
    }
}
