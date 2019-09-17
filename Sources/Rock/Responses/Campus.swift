import Foundation

public struct Campus: Codable {
    public let id: Int
    public let guid: String
    public let name: String
    public let shortCode: String
    public let locationID: Int
    public let isActive: Bool
    public let location: Location?
}
