import Foundation

struct GetCampuses: APIRequest {
    typealias Response = [Campus]
    
    var method: HTTPMethod { return .get }
    
    var path: String {
        let parameters: [String: String] = ["$expand": "Location"]
        return "api/Campuses?\(parameters.urlQueryEscaped)"
    }
}
