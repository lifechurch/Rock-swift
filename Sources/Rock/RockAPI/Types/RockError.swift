import Foundation

public struct RockError: LocalizedError {
    let message: String
    
    public var errorDescription: String? {
        return message
    }
}
