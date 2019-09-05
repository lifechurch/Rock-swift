import Foundation

public class Rock {
    static let API = RockAPIClient()

    static func configure(baseURL: URL?) {
        API.baseURL = baseURL
    }
    
    static func assign(token: String?) {
        API.token = token
    }
}
