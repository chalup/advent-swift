import Foundation

struct Point : Hashable {
    var x: Int
    var y: Int
    
    static func +=(point: inout Point, vector: Vector) {
        point.x += vector.dx
        point.y += vector.dy
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

func parseWire(origin: Point, wireSpec: String) -> [Point] {
    var points: [Point] = []
    var p = origin
    
    wireSpec
            .split(separator: ",").map(String.init)
            .map { (segment: String) -> WireSegment in
                let data = try! match(text: String(segment), pattern: "(.)(\\d+)")
                return WireSegment(direction: data[1], length: data[2].asInt())
            }
            .forEach { segment in
                let vector = { () -> Vector in
                    switch (segment.direction) {
                    case "R": return Vector(dx: +1, dy: 0)
                    case "L": return Vector(dx: -1, dy: 0)
                    case "U": return Vector(dx: 0, dy: +1)
                    case "D": return Vector(dx: 0, dy: -1)
                    default: fatalError("Unknown direction: '\(segment.direction)'")
                    }
                }()

                for _ in 1...segment.length {
                    p += vector
                    points.append(p)
                }
            }
    
    return points
}

func manhattanDistance(_ a: Point, _ b: Point) -> Int {
    return abs(a.x - b.x) + abs(a.y - b.y)
}

func wiresCrossings(wires: [[Point]]) -> Set<Point> {
    guard let first = wires.first else { return [] }
    
    return wires.dropFirst().reduce(Set(first)) { $0.intersection($1) }
}

public func distanceToNearestIntersection(wireSpecs: [String]) -> Int {
    let origin = Point(x:0, y:0 )
    
    let wires = wireSpecs
        .map { parseWire(origin: origin, wireSpec: $0) }
    
    return wiresCrossings(wires: wires)
        .map { manhattanDistance(origin, $0) }
        .min()!
}

public func shortestIntersectionPath(wireSpecs: [String]) -> Int {
    let origin = Point(x:0, y:0 )
    
    let wires = wireSpecs
        .map { parseWire(origin: origin, wireSpec: $0) }
        
    let pointsLookup = wires
        .map { $0.enumerated().reduce(into: [:]) { (result, enumeratedPoint) in result[enumeratedPoint.element] = enumeratedPoint.offset + 1 } }
    
    return wiresCrossings(wires: wires)
        .map { crossing in
            pointsLookup.map { $0[crossing]! }.reduce(0, +)
        }
        .min()!
}
