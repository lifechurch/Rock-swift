import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    
    var method: HTTPMethod { get }
}
 
