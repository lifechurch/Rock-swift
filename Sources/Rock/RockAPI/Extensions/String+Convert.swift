import Foundation

let suffixConversionDictionary: [String: String] = [
    "Id": "ID",
    "Ids": "IDs",
    "Guid": "GUID",
]

extension String {
    func toSwiftKey() -> String {
        var result = prefix(1).lowercased() + dropFirst()
                
        for entry in suffixConversionDictionary {
            if result.hasSuffix(entry.key) {
                result = result.dropLast(entry.key.count) + entry.value
            }
        }
        
        return result
    }
    
    func toRockKey() -> String {
        var result = prefix(1).uppercased() + dropFirst()
                
        for entry in suffixConversionDictionary {
            if result.hasSuffix(entry.value) {
                result = result.dropLast(entry.value.count) + entry.key
            }
        }
        
        return result
    }
}
