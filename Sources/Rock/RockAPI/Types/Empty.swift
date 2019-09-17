import Foundation

public struct Empty: Decodable {
    public init() { }
    public init(from decoder: Decoder) throws { }
}
