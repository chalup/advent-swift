import Foundation

struct MapEntry {
    let parentId: String
    let childId: String
}

enum MapObject : Equatable {
    case CenterOfMass
    indirect case OrbitalBody(id: String, parent: MapObject)
}

func orbitalPath(object: MapObject) -> [MapObject] {
    var current = object
    var result: [MapObject] = []
    
    while(true) {
        result.append(current)
        
        switch current {
        case .CenterOfMass: return Array(result.dropFirst())
        case .OrbitalBody(_, let parent): current = parent
        }
    }
}

func objectId(_ object: MapObject) -> String {
    switch object {
    case .CenterOfMass: return "COM"
    case .OrbitalBody(let id, _): return id
    }
}

func parseInput(_ input: [String]) -> [MapEntry] {
    return input.map {
        let parts = $0.split(separator: ")")
        return MapEntry(parentId: String(parts[0]), childId: String(parts[1]))
    }
}

func buildMap(_ entries: [MapEntry]) -> [String: MapObject] {
    var map: [String: MapObject] = [:]
    
    let childrenByParentId = Dictionary(grouping: entries, by: { $0.parentId }).mapValues { $0.map { $0.childId } }
    var queue = [MapObject.CenterOfMass]
    
    while(!queue.isEmpty) {
        let element = queue.remove(at: 0)
        let id = objectId(element)
        
        map[id] = element
        
        childrenByParentId[id]?.forEach { queue.append(MapObject.OrbitalBody(id: $0, parent: element)) }
    }
    
    return map
}

public func day6task1(input: [String]) -> Int {
    let entries = parseInput(input)
    let map = buildMap(entries)
    
    return map.values.map { orbitalPath(object: $0).count }.reduce(0, +)
}

public func day6task2(input: [String]) -> Int {
    let entries = parseInput(input)
    let map = buildMap(entries)
    
    let yourPath = orbitalPath(object: map["YOU"]!)
    let santaPath = orbitalPath(object: map["SAN"]!)
    
    let firstCommonAncestor = firstCommonBody(pathA: yourPath, pathB: santaPath)
    
    return yourPath.firstIndex(of: firstCommonAncestor)! + santaPath.firstIndex(of: firstCommonAncestor)!
}

private func firstCommonBody(pathA: [MapObject], pathB: [MapObject]) -> MapObject {
    var result = MapObject.CenterOfMass
    
    for (a, b) in zip(pathA.reversed(), pathB.reversed()) {
        if (a == b) {
            result = a
        } else {
            break
        }
    }
    
    return result
}
