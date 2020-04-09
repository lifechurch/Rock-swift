import Foundation

public struct Group: Codable {
    public let id: Int
    public let guid: String
    public let name: String
    public let campus: Campus?
}
