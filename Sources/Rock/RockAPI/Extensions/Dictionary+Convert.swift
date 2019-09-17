import Foundation

extension Dictionary where Key == String, Value == String {
    var urlQueryEscaped: String {
        return self
            .compactMap {
                if let value = $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    return "\($0)=\(value)"
                } else {
                    return nil
                }
            }
            .joined(separator: "&")
    }
}
