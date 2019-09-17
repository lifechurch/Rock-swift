import Foundation

public struct GetCampuses: APIRequest {
    public typealias Response = [Campus]
    
    public var method: HTTPMethod { .get }
    
    public var path: String {
        let parameters: [String: String] = ["$expand": "Location"]
        return "api/Campuses?\(parameters.urlQueryEscaped)"
    }
    
    public init() { }
}
