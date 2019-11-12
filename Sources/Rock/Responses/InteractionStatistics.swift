import Foundation

public struct InteractionStatistics: Codable {
    public let interactionsAllTime: Int
    public let interactionsThatDay: Int
    public let interactionsThatMonth: Int
    public let interactionsThatYear: Int
}
