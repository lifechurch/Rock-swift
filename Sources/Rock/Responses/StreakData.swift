import Foundation

public struct StreakData: Codable {
    public let streakTypeID: Int
    public let streakIDs: [Int]
    public let perFrequencyUnit: [PerFrequencyUnit]
}
