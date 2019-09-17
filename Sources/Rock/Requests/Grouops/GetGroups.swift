import Foundation

public struct GetGroups: APIRequest {
    public typealias Response = [Group]

    public var method: HTTPMethod { .get }

    public var path: String {
        let parameters: [String: String] = [
            "$filter": "Name eq 'App Attendance' and Campus ne null",
            "$expand": "Campus/Location",
        ]
        return "api/Groups?\(parameters.urlQueryEscaped)"
    }
    
    public init() { }
}
