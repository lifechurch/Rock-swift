import Foundation

extension Data {
    var errorMessage: String? {
        if let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] {
            if let message = json["Message"] as? String {
                return message
            }
        }
        return nil
    }
}
