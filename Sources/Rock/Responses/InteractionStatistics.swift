import Foundation

public struct InteractionStatistics: Codable {
    public var interactionsAllTime: Int
    public var interactionsThatDay: Int
    public var interactionsThatMonth: Int
    public var interactionsThatYear: Int
    
    public mutating func increment() {
        interactionsAllTime += 1
        interactionsThatDay += 1
        interactionsThatMonth += 1
        interactionsThatYear += 1
    }
}
