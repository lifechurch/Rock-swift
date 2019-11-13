import Foundation

public struct InteractionStatistics: Codable {
    private(set) var interactionsAllTime: Int
    private(set) var interactionsThatDay: Int
    private(set) var interactionsThatMonth: Int
    private(set) var interactionsThatYear: Int
    
    public mutating func increment() {
        interactionsAllTime += 1
        interactionsThatDay += 1
        interactionsThatMonth += 1
        interactionsThatYear += 1
    }
}
