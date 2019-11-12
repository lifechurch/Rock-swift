import Foundation

public struct GetInteractionStatistics: APIRequest {
    public typealias Response = InteractionStatistics

    public var method: HTTPMethod { .get }

    public var path: String {
        var parameters = [String: String]()
        if let interactionChannelGUID = interactionChannelGUID {
            parameters["interactionChannelGuid"] = interactionChannelGUID.description
        }
        if let interactionComponentGUID = interactionComponentGUID {
            parameters["interactionComponentGuid"] = interactionComponentGUID.description
        }
        return "api/People/GetInteractionStatistics?\(parameters.urlQueryEscaped)"
    }
    
    public let interactionChannelGUID: String?
    public let interactionComponentGUID: String?
    
    public init(interactionChannelGUID: String?, interactionComponentGUID: String?) {
        self.interactionChannelGUID = interactionChannelGUID
        self.interactionComponentGUID = interactionComponentGUID
    }
}
