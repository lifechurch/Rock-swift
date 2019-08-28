import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    
    var method: HTTPMethod { get }
}
 
