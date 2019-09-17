import Foundation

public struct GetGroups: APIRequest {
    typealias Response = [Group]

    var method: HTTPMethod { return .get }

    var path: String {
        let parameters: [String: String] = [
            "$filter": "Name eq 'App Attendance' and Campus ne null",
            "$expand": "Campus/Location",
        ]
        return "api/Groups?\(parameters.urlQueryEscaped)"
    }
}
