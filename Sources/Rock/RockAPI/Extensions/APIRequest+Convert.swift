import Foundation

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
    
    func handle(data: Data, decoder: JSONDecoder) -> Result<Response, Error> {
        if let idString = String(data: data, encoding: .utf8), let id = Int(idString), Response.self == Int.self {
            return Result<Int, Error>.success(id) as! Result<Response, Error>
        } else if Response.self == Empty.self {
            return Result<Empty, Error>.success(Empty()) as! Result<Response, Error>
        }
        
        do {
            let result = try decoder.decode(Response.self, from: data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
