import Foundation

public struct GetStreakTypes: APIRequest {
    typealias Response = [StreakType]

    var method: HTTPMethod { return .get }

    var path: String { return "api/StreakTypes" }
}
