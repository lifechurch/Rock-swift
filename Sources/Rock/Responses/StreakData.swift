import Foundation

public struct StreakData: Codable {
    public let streakTypeID: Int
    public let streakIDs: [Int]
    public let engagedAtMostRecentOccurrence: Bool
    public let engagementsThisMonth: Int
    public let engagementsThisYear: Int
}
