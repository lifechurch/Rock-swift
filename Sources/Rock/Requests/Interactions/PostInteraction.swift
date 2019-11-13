import Foundation

public struct PostInteraction: APIRequest {
    public typealias Response = Int
    
    public var method: HTTPMethod { .post }

    public var path: String { "api/Interactions" }
    
    public let operation: String
    public let interactionComponentID: Int
    public let interactionSummary: String
    public let interactionData: String
    public let interactionDateTime: String
    public let personAliasID: Int

    public init(operation: String, interactionComponentID: Int, interactionSummary: String, interactionData: String, interactionDateTime: String, personAliasID: Int) {
        self.operation = operation
        self.interactionComponentID = interactionComponentID
        self.interactionSummary = interactionSummary
        self.interactionData = interactionData
        self.interactionDateTime = interactionDateTime
        self.personAliasID = personAliasID
    }
}
