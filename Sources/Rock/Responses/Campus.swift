import Foundation

public struct Campus: Codable {
    let id: Int
    let guid: String
    let name: String
    let shortCode: String
    let locationID: Int
    let isActive: Bool
    let location: Location?
}
