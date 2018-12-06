//: [Previous](@previous)
import Foundation

let input = """
252, 125
128, 333
89, 324
141, 171
266, 338
117, 175
160, 236
234, 202
165, 192
204, 232
83, 192
229, 178
333, 57
70, 243
108, 350
161, 63
213, 277
87, 299
163, 68
135, 312
290, 87
73, 246
283, 146
80, 357
66, 312
159, 214
221, 158
175, 54
298, 342
348, 162
249, 90
189, 322
311, 181
194, 244
53, 295
80, 301
262, 332
268, 180
139, 287
115, 53
163, 146
220, 268
79, 85
95, 112
349, 296
179, 274
113, 132
158, 264
316, 175
268, 215
"""

let testInput = """
1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
"""

extension Sequence {
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        
        return count
    }
}

struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
    
    func manhattanDistance(from otherPoint: Point) -> Int {
        let xDistance = x - otherPoint.x
        let yDistance = y - otherPoint.y
        
        return abs(xDistance) + abs(yDistance)
    }
}

let points = input
    .trimmingCharacters(in: .whitespacesAndNewlines)
    .components(separatedBy: .newlines)
    .map { line -> Point in
        let components = line
            .components(separatedBy: .punctuationCharacters)
            .map { $0.trimmingCharacters(in: .whitespaces) }
        let x = Int(components[0])!
        let y = Int(components[1])!
        return Point(x: x, y: y)
}

func partOne() -> String {
    func calculateCount(gridSize: Int) -> [Int] {
        let offset = gridSize / 2
        
        let counts = (0 ..< gridSize).flatMap { x in
            (0 ..< gridSize).compactMap { y in
                let actualPoint = Point(x: x - offset, y: y - offset)
                let distanceMap: [(index: Int, distance: Int)] = points
                    .enumerated()
                    .map { ($0, $1.manhattanDistance(from: actualPoint)) }
                let closest = distanceMap.min(by: { $0.distance < $1.distance })!
                let hasOneClosest = distanceMap.count(where: { $0.distance == closest.distance }) == 1
                return hasOneClosest ? closest.index : nil
            }
            }.reduce(into: Array(repeating: 0, count: points.count), { $0[$1] += 1 })
        
        return counts
    }
    
    let result = zip(calculateCount(gridSize: 1000), calculateCount(gridSize: 1200))
        .filter { $0 == $1 }
        .map { $0.0 }
        .max()!
    
    return "\(result)"
}

func partTwo() -> String {
    func calculateCount(gridSize: Int, distanceLimit: Int) -> Int {
        let offset = gridSize / 2
        
        let underLimitCount = (0 ..< gridSize).flatMap { x in
            (0 ..< gridSize).map { y in
                let actualPoint = Point(x: x - offset, y: y - offset)
                let totalDistance = points
                    .map { $0.manhattanDistance(from: actualPoint) }
                    .reduce(0, +)
                return totalDistance
                }.filter { $0 < distanceLimit }
            }.count
        
        return underLimitCount
    }
    
    let result = calculateCount(gridSize: 1200, distanceLimit: 10000)
    
    return "\(result)"
}

print(partOne())
print(partTwo())
//: [Next](@next)
