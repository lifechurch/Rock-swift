import Foundation

public struct Location: Codable {
    public let id: Int
    public let name: String
    public let latitude: Double?
    public let longitude: Double?
}
