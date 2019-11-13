import Foundation

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    
    var method: HTTPMethod { get }
}

extension APIRequest {
    var parameters: [String: Codable] {
        Mirror(reflecting: self).children
            .reduce(into: [:], { previous, child in
                if let key = child.label?.toRockKey(), let value = child.value as? Codable {
                    if case Optional<Codable>.none = value {
                        // do nothing
                    } else if case Optional<Codable>.some(let unwrappedValue) = value {
                        previous[key] = unwrappedValue
                    } else {
                        previous[key] = value
                    }
                }
            })
    }
}
