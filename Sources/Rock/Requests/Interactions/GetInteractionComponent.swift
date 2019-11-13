import Foundation

public struct GetInteractionComponent: APIRequest {
    public typealias Response = [InteractionComponent]

    public var method: HTTPMethod { .get }

    public var path: String {
        var parameters = [String: String]()
        if let guid = guid {
            parameters["$filter"] = "Guid eq guid'\(guid)'"
        }
        parameters["$select"] = "Id,Guid,ChannelId,Name"
        return "api/InteractionComponents?\(parameters.urlQueryEscaped)"
    }
    
    public let guid: String?
    
    public init(guid: String?) {
        self.guid = guid
    }
}
