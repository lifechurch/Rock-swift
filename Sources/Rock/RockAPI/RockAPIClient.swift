import Foundation
#if canImport(Combine)
import Combine
#endif

public class RockAPIClient: APIClient {
    public var baseURL: URL?
    
    public var token: String?
    
    lazy var urlSession: URLSession = {
        let urlSession = URLSession.shared
        urlSession.configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        return urlSession
    }()
    
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
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if request.method == .post {
            let parameters = request.parameters
            if let data = try? JSONSerialization.data(withJSONObject: parameters, options: []), parameters.count > 0 {
                urlRequest.httpBody = data
            }
        }
        
        return urlRequest
    }
    
    public func send<T: APIRequest>(_ request: T, willUseCache: Bool = false, completion: ResultCallback<T.Response>? = nil) {
        guard let urlRequest = self.urlRequest(from: request) else {
            completion?(.failure(APIError.invalidURL))
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            if let response = response, let data = data, let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) {
                if willUseCache {
                    self?.store(request: urlRequest, response: response, data: data)
                }
                self?.handle(request: request, data: data, completion: completion)
            } else if let message = data?.errorMessage {
                completion?(.failure(RockError(message: message)))
            } else if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.failure(RockError(message: "Error")))
            }
        }
        
        if willUseCache {
            if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: urlRequest) {
                handle(request: request, data: cachedResponse.data, completion: completion)
            }
        }
        
        task.resume()
    }
    
    private func store(request: URLRequest, response: URLResponse, data: Data) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        self.urlSession.configuration.urlCache?.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func handle<T: APIRequest>(request: T, data: Data, completion: ResultCallback<T.Response>? = nil) {
        if let completion = completion as? ResultCallback<Int>, let idString = String(data: data, encoding: .utf8), let id = Int(idString) {
            completion(.success(id))
        } else if let completion = completion as? ResultCallback<Empty>, data.count == 0 {
            completion(.success(Empty()))
        } else {
            do {
                let result = try decoder.decode(T.Response.self, from: data)
                completion?(.success(result))
            } catch {
                completion?(.failure(error))
            }
        }
    }
    
    #if canImport(Combine)
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public func publisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error>? {
        guard let urlRequest = self.urlRequest(from: request) else {
            return nil
        }
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    #endif
}
