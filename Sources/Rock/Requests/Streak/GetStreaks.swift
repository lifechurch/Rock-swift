import Foundation

struct GetStreaks: APIRequest {
    typealias Response = [Streak]

    var method: HTTPMethod { return .get }

    var path: String { return "api/Streaks?$filter=StreakTypeId%20eq%20\(streakTypeID)%20and%20PersonAliasId%20eq%20\(personAliasId)" }
    
    let streakTypeID: Int
    
    let personAliasId: Int
}
