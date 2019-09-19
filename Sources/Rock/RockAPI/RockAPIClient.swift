import Foundation
#if canImport(Combine)
import Combine
#endif

public class RockAPIClient: APIClient {
    public var baseURL: URL?
    
    public var token: String?
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .custom({ keys in
            return RockKey(stringValue: keys.last?.stringValue.toSwiftKey() ?? "")
        })
        return decoder
    }()
    
    func urlRequest<T: APIRequest>(from request: T) -> URLRequest? {
        guard let url = URL(string: request.path, relativeTo: baseURL) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if let token = token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if request.method == .post {
            let parameters: [String: Codable] = Mirror(reflecting: request).children
                .reduce(into: [:], { previous, child in
                    if let key = child.label?.toRockKey(), let value = child.value as? Codable {
                        previous[key] = value
                    }
                })
            
            if let data = try? JSONSerialization.data(withJSONObject: parameters, options: []), parameters.count > 0 {
                urlRequest.httpBody = data
            }
        }
        
        return urlRequest
    }
    
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        guard let urlRequest = self.urlRequest(from: request) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [unowned self] data, response, error in
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) {
                if let data = data {
                    if let completion = completion as? ResultCallback<Int>, let idString = String(data: data, encoding: .utf8), let id = Int(idString) {
                        completion(.success(id))
                    } else if let completion = completion as? ResultCallback<Empty>, data.count == 0 {
                        completion(.success(Empty()))
                    } else {
                        do {
                            let result = try self.decoder.decode(T.Response.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                }
            } else if let message = data?.errorMessage {
                completion(.failure(RockError(message: message)))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(RockError(message: "Error")))
            }
        }
        task.resume()
    }
    
    #if canImport(Combine)
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public func publisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error>? {
        guard let urlRequest = self.urlRequest(from: request) else {
            return nil
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    #endif
}
