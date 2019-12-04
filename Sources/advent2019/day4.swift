import Foundation

public func day4task1(range: ClosedRange<Int>) -> Int { countValidPasswords(range: range, checks: isNotDecreasing, containsDouble) }
public func day4task2(range: ClosedRange<Int>) -> Int { countValidPasswords(range: range, checks: isNotDecreasing, containsSeparatedDouble) }

func countValidPasswords(range: ClosedRange<Int>, checks: (String) -> Bool...) -> Int {
    return range
        .map(String.init)
        .filter { (password: String) -> Bool in checks.allSatisfy { predicate in predicate(password) } }
        .count
}

func isNotDecreasing(_ password: String) -> Bool {
    return password
        .windowed(size: 2)
        .allSatisfy { $0[0] <= $0[1] }
}

func containsDouble(_ password: String) -> Bool {
    return password
        .windowed(size: 2)
        .contains { $0[0] == $0[1] }
}

func containsSeparatedDouble(_ password: String) -> Bool {
    return "#\(password)#"
        .windowed(size: 4)
        .contains { $0[0] != $0[1] && $0[1] == $0[2] && $0[2] != $0[3] }
}

extension StringProtocol {
    func windowed(size: Int) -> [SubSequence] { (0...self.count-size).map { self[$0..<$0+size] } }
    subscript(_ n: Int) -> Element { self[index(startIndex, offsetBy: n)] }
    subscript(_ range: Range<Int>) -> SubSequence { prefix(range.lowerBound + range.count).suffix(range.count) }
}
