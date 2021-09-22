import Foundation

public protocol APIClient {
    var baseURL: URL? { get}
    
    func send<T: APIRequest>(_ request: T, completion: ResultCallback<T.Response>?)
    
    func load<T: APIRequest>(_ request: T) -> T.Response?
}
