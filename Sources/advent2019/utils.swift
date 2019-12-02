import Foundation

public extension String {
    func lines() -> [String] {
        return self.split { $0.isNewline }.map(String.init)
    }
    
    func singleLine() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
