import Foundation

struct Point : Hashable {
    let x: Int
    let y: Int
    
    func translated(by vector: Vector) -> Point {
        return Point(
            x: self.x + vector.dx,
            y: self.y + vector.dy
        )
    }
}

struct Vector {
    let dx: Int
    let dy: Int
}

struct WireSegment {
    let direction: String
    let length: Int
}

func match(text: String, pattern: String) throws -> [String] {
    let regex = try NSRegularExpression(pattern: "(.)(\\d+)")
    let matches = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
    return matches.flatMap { match in
        return (0..<match.numberOfRanges).map { matchIndex in
            return String(text[Range(match.range(at: matchIndex), in: text)!])
        }
    }
}

class UnknownDirection: Error {
}

func parseWire(origin: Point, wireSpec: String) throws -> [Point] {
    var points: [Point] = []
    var p = origin
    
    try wireSpec
            .split(separator: ",").map(String.init)
            .map { (segment: String) -> WireSegment in
                let data = try match(text: String(segment), pattern: "(.)(\\d+)")
                return WireSegment(direction: data[1], length: Int(data[2])!)
            }
            .forEach { segment in
                let vector = { () -> Vector in
                    switch (segment.direction) {
                    case "R": return Vector(dx: +1, dy: 0)
                    case "L": return Vector(dx: -1, dy: 0)
                    case "U": return Vector(dx: 0, dy: +1)
                    case "D": return Vector(dx: 0, dy: -1)
                    default: throw UnknownDirection()
                    }
                }

                for _ in 1...segment.length {
                    p = p.translated(by: try vector())
                    points.append(p)
                }
            }
    
    return points
}

func manhattanDistance(_ a: Point, _ b: Point) -> Int {
    return abs(a.x - b.x) + abs(a.y - b.y)
}

func wiresCrossings(wires: [[Point]]) -> Set<Point> {
    let head = Set(wires.first!)
    
    return wires.dropFirst().reduce(head) { $0.intersection($1) }
}

public func distanceToNearestIntersection(wireSpecs: [String]) throws -> Int {
    let origin = Point(x:0, y:0 )
    
    let wires = try wireSpecs
        .map { try parseWire(origin: origin, wireSpec: $0) }
    
    return wiresCrossings(wires: wires)
        .map { manhattanDistance(origin, $0) }
        .min()!
}

public func shortestIntersectionPath(wireSpecs: [String]) throws -> Int {
    let origin = Point(x:0, y:0 )
    
    let wires = try wireSpecs
        .map { try parseWire(origin: origin, wireSpec: $0) }
    
    return wiresCrossings(wires: wires)
        .map { crossing in
            wires.map { $0.firstIndex(of: crossing)! + 1 }.reduce(0, +)
        }
        .min()!
}
