import Foundation

public struct GetInteractionStatistics: APIRequest {
    public typealias Response = InteractionStatistics

    public var method: HTTPMethod { .get }

    public var path: String {
        let parameters = self.parameters.mapValues { "\($0)" }
        return "api/People/GetInteractionStatistics?\(parameters.urlQueryEscaped)"
    }
    
    public let interactionChannelID: Int?
    public let interactionChannelGUID: String?
    public let interactionComponentID: Int?
    public let interactionComponentGUID: String?
    
    public init(interactionChannelID: Int? = nil, interactionChannelGUID: String? = nil, interactionComponentID: Int? = nil, interactionComponentGUID: String? = nil) {
        self.interactionChannelID = interactionChannelID
        self.interactionChannelGUID = interactionChannelGUID
        self.interactionComponentID = interactionComponentID
        self.interactionComponentGUID = interactionComponentGUID
    }
}
