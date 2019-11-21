import Foundation
#if canImport(Combine)
import Combine
#endif

public class RockAPIClient: APIClient {
    public var baseURL: URL?
    
    public var token: String?
    
    lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration()
        configuration.urlCache = URLCache(memoryCapacity: 0, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
        return URLSession(configuration: configuration)
    }()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .custom({ keys in
            return RockKey(stringValue: keys.last?.stringValue.toSwiftKey() ?? "")
        })
        return decoder
    }()
    
    func createRequest<T: APIRequest>(from request: T) -> URLRequest? {
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
    
    public func send<T: APIRequest>(_ request: T, completion: ResultCallback<T.Response>? = nil) {
        guard let urlRequest = createRequest(from: request) else {
            completion?(.failure(APIError.invalidURL))
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            let result: Result<T.Response, Error>
            if let self = self, let response = response, let data = data, let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) {
                if urlRequest.httpMethod == HTTPMethod.get.rawValue {
                    self.store(request: urlRequest, response: response, data: data)
                }
                result = request.handle(data: data, decoder: self.decoder)
            } else if let message = data?.errorMessage {
                result = .failure(RockError(message: message))
            } else if let error = error {
                result = .failure(error)
            } else {
                result = .failure(RockError(message: "Error"))
            }
            completion?(result)
        }
        
        task.resume()
    }
    
    public func load<T: APIRequest>(_ request: T) -> T.Response? {
        guard let urlRequest = createRequest(from: request) else {
            return nil
        }
        
        guard let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: urlRequest) else {
            return nil
        }
        
        let result = request.handle(data: cachedResponse.data, decoder: decoder)
        if case .success(let response) = result {
            return response
        } else {
            return nil
        }
    }
    
    private func store(request: URLRequest, response: URLResponse, data: Data) {
        let cachedResponse = CachedURLResponse(response: response, data: data)
        urlSession.configuration.urlCache?.storeCachedResponse(cachedResponse, for: request)
    }
    
    #if canImport(Combine)
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    public func publisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error>? {
        guard let urlRequest = createRequest(from: request) else {
            return nil
        }
        
        return urlSession.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.Response.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    #endif
}
