import Foundation

public extension String {
    func lines() -> [String] {
        return self.split { $0.isNewline }.map(String.init)
    }
    
    func singleLine() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func asInt() -> Int {
        guard let number = Int(self) else { fatalError("'\(self)' is not a number") }
        return number
    }
}
