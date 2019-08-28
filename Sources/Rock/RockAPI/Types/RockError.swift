import Foundation

struct RockError: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        return message
    }
}
