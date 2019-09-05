import Foundation

struct GetCampuses: APIRequest {
    typealias Response = [Campus]
    
    var method: HTTPMethod { return .get }
    
    var path: String { return "api/Campuses?$expand=Location" }
}
