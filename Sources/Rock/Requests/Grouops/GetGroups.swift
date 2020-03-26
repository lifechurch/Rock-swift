import Foundation

public struct GetGroups: APIRequest {
    public typealias Response = [Group]

    public var method: HTTPMethod { .get }

    public var path: String {
        var parameters: [String: String] = [
            "$expand": "Campus/Location",
        ]
        if let name = name {
            parameters["$filter"] = "Name eq '\(name)' and Campus ne null"
        } else if let guid = guid {
            parameters["$filter"] = "Guid eq guid'\(guid)'"
        }
        return "api/Groups?\(parameters.urlQueryEscaped)"
    }
    
    public let name: String?    
    public let guid: String?
    
    public init(name: String? = nil, guid: String? = nil) {
        self.name = name
        self.guid = guid
    }
}
