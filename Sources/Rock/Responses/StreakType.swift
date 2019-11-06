import Foundation

public struct StreakType: Codable, Hashable {
    public let id: Int
    public let guid: String
    public let name: String
    public let isActive: Bool
}
