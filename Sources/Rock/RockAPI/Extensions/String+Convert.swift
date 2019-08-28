import Foundation

let suffixesWithAllUppcases = ["Id", "Guid"]

extension String {
    func toSwiftKey() -> String {
        var result = prefix(1).lowercased() + dropFirst()
                
        for suffix in suffixesWithAllUppcases {
            if result.hasSuffix(suffix) {
                result = result.dropLast(suffix.count) + suffix.uppercased()
            }
        }
        
        return result
    }
    
    func toRockKey() -> String {
        var result = prefix(1).uppercased() + dropFirst()
                
        for suffix in suffixesWithAllUppcases {
            if result.hasSuffix(suffix.uppercased()) {
                result = result.dropLast(suffix.count) + suffix.capitalized
            }
        }
        
        return result
    }
}
