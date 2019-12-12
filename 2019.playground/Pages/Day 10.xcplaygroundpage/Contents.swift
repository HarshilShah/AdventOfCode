//: [Previous](@previous)

import Foundation

let input = """
###..#.##.####.##..###.#.#..
#..#..###..#.......####.....
#.###.#.##..###.##..#.###.#.
..#.##..##...#.#.###.##.####
.#.##..####...####.###.##...
##...###.#.##.##..###..#..#.
.##..###...#....###.....##.#
#..##...#..#.##..####.....#.
.#..#.######.#..#..####....#
#.##.##......#..#..####.##..
##...#....#.#.##.#..#...##.#
##.####.###...#.##........##
......##.....#.###.##.#.#..#
.###..#####.#..#...#...#.###
..##.###..##.#.##.#.##......
......##.#.#....#..##.#.####
...##..#.#.#.....##.###...##
.#.#..#.#....##..##.#..#.#..
...#..###..##.####.#...#..##
#.#......#.#..##..#...#.#..#
..#.##.#......#.##...#..#.##
#.##..#....#...#.##..#..#..#
#..#.#.#.##..#..#.#.#...##..
.#...#.........#..#....#.#.#
..####.#..#..##.####.#.##.##
.#.######......##..#.#.##.#.
.#....####....###.#.#.#.####
....####...##.#.#...#..#.##.
"""

struct Position: Equatable, Hashable {
    var x: Int
    var y: Int
    
    func distance(from other: Position) -> Int {
        abs(other.y - y) + abs(other.x - x)
    }
    
    func slope(withRespectTo other: Position) -> Double {
        let xDiff = Double(x - other.x)
        let yDiff = Double(y - other.y)
        return (((atan2(yDiff, xDiff) * 180.0 / .pi) * -1) + 360).truncatingRemainder(dividingBy: 360)
    }
}

enum Item {
    case asteroid, empty
}

func lineOfSightAsteroidCount(map: [[Item]], startingPosition: Position) -> Int? {
    guard map[startingPosition.y][startingPosition.x] == .asteroid else { return nil }
    
    var count = 0
    var encounteredSlopes: Set<Double> = []
    
    map.enumerated().forEach { y, line in
        line.enumerated().forEach { x, item in
            let position = Position(x: x, y: y)
            let slope = position.slope(withRespectTo: startingPosition)
            
            guard
                item == .asteroid,
                position != startingPosition,
                encounteredSlopes.contains(slope) == false
                else { return }
            
            encounteredSlopes.insert(slope)
            count += 1
        }
    }
    
    return count
}

func monitoringStation(fromMap map: [[Item]]) -> (position: Position, lineOfSightCount: Int) {
    map
        .enumerated()
        .compactMap { yTuple -> (Position, Int)? in
            let (y, line) = yTuple
            return line
                .indices
                .compactMap { x -> (Position, Int)? in
                    let position = Position(x: x, y: y)
                    guard let count = lineOfSightAsteroidCount(map: map, startingPosition: position) else { return nil }
                    return (position, count)
                }
                .max(by: { $0.1 < $1.1 })
        }
        .max(by: { $0.1 < $1.1 })!
}

let map = input
    .components(separatedBy: .newlines)
    .map { line in
        line.map { $0 == "#" ? Item.asteroid : .empty }
    }

func partOne() -> String {
    monitoringStation(fromMap: map)
        .lineOfSightCount
        .description
}

func partTwo() -> String {
    let stationPosition = monitoringStation(fromMap: map).position
    
    var encounteredSlopes: [Double: [Position]] = [:]
    
    map.enumerated().forEach { y, line in
        line.enumerated().forEach { x, item in
            let position = Position(x: x, y: y)
            let slope = position.slope(withRespectTo: stationPosition)
            
            guard
                item == .asteroid,
                position != stationPosition
                else { return }

            encounteredSlopes[slope, default: []].append(position)
        }
    }

    var currentSlope = 90.0
    var destroyedCount = 0

    while true {
        if let index = encounteredSlopes[currentSlope]?
            .enumerated()
            .min(by: { $0.1.distance(from: stationPosition) < $1.1.distance(from: stationPosition) })?
            .offset
        {
            let removed = encounteredSlopes[currentSlope]!.remove(at: index)
            
            destroyedCount += 1
            if destroyedCount == 200 {
                return ((removed.x * 100) + removed.y).description
            }
        }

        currentSlope = encounteredSlopes
            .lazy
            .filter { $0.key < currentSlope && $0.value.isEmpty == false }
            .map { $0.key }
            .max() ?? 360
    }
}

print(partOne())
print(partTwo())

//: [Next](@next)
