import Foundation

public struct GetGroups: APIRequest {
    public typealias Response = [Group]

    public var method: HTTPMethod { .get }

    public var path: String {
        let parameters: [String: String] = [
            "$filter": "Name eq '\(name)' and Campus ne null",
            "$expand": "Campus/Location",
        ]
        return "api/Groups?\(parameters.urlQueryEscaped)"
    }
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
