import Foundation

public class Rock {
    public static let API = RockAPIClient()

    public static func configure(baseURL: URL?) {
        API.baseURL = baseURL
    }
    
    public static func assign(token: String?) {
        API.token = token
    }
}
