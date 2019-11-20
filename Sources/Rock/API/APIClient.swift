import Foundation
#if canImport(Combine)
import Combine
#endif

public protocol APIClient {
    var baseURL: URL? { get}
    
    func send<T: APIRequest>(_ request: T, willUseCache: Bool, completion: ResultCallback<T.Response>?)
    
    #if canImport(Combine)
    @available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func publisher<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error>?
    #endif
}
