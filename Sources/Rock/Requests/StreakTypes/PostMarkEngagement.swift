import Foundation

public struct PostMarkEngagement: APIRequest {
    public typealias Response = Empty
    
    public var method: HTTPMethod { .post }

    public var path: String { "api/StreakTypes/MarkEngagement/\(streakTypeID)?groupID=\(groupID)&locationID=\(locationID)" }
    
    public let streakTypeID: Int
    
    public let groupID: Int
    
    public let locationID: Int
    
    public init(streakTypeID: Int, groupID: Int, locationID: Int) {
        self.streakTypeID = streakTypeID
        self.groupID = groupID
        self.locationID = locationID
    }
}
