//: [Previous](@previous)
import Foundation

let input = """
.|#.#|..#...|..##||...|#..##..#..|#|....#.#|.|....
.||....#..#...|#....#.||....||...||...|..#|..||..|
......|.|.#.#.#..|.....#.###.....#........|.||..#|
..|.....||...#||#.#|#.....|##.|.|....|#....#|..#.#
|...#.|..#|#.#....|.#.#.|.#...#..#|#.....##|#..#.|
#....|#|......#.|||..#..#..||...#.#...|||##|..|#..
.#||.|....|.......#|##...|.#.....#.##...|.|.#...#|
....#|.|.|...##.......|#.....|..#......#...#|.#..#
...#.|....#.|.#...|||......##..|#|||#..#...|.|#.#.
.#..|...|..#.|##.#.#......#...||.||.#...|.#.#.#|..
|...#.|||...#|.#||.......|.##.....|..||...####...|
.##..|..##|...##.#...#...#.#|.|###...#............
|.....||...#.......|.#..|#.....|.|#.|..||.##.|#|..
.#..##|.#|.|..|.#..#.|.#..#|......##...#.#.......#
...#.##.|..|.#.....#....#..#.............|.|##||..
||.##.||.|.|..|..#.|.|.##|.|...|.#.|#.......#.|...
..|#.##..#|.#|#.#...........|.|........#...#|...#|
....|.#|..|.#|#|...|.|.#..#.....#|##|||##.#....#..
...###.#.....#.||......#|#..##...|#....#....|#|.#.
.##.|.##|.#.||....#|....|.#.|#.|....##..#.##|.....
|...|...#|....#....#...#|#...|..#.#.|.|.....|.#|..
.|.|.#.#.#|.#.|#....|.|###..#......|...|...#.|#...
..|...||.|..##|...|..|#|...|......#.||.#...#..|#.|
........|..#||..|....|.....|.|#..#....|#..|.#.....
#.|.|#....#...|..|....|.#.....||.....|..|........#
...||||....|.#.|....#..#....|###....|...#...##....
|||........|.#|.|......||#.|.....|.||#|.##....#|..
.....|#|#..||#...|##.|..||....####.|#.|..#....|.#.
.||..#||....#.....#.#|.|....|.##|..|.#..|##....##.
.|#.#|#|#|.....||..|.|.|.#......#..|.#..#..|.#||#.
|.|#.......|..#|#|....|.#.#.#.|...|.......##.|||#|
..|.....#...||.|....|##|...#..#.#.....|##|##.##...
.|.|..##.#|..|.|#.......#....#||.|...||#...|......
|.|##.#....|#..|....#..#..|##.|.##..#......#|##|..
..#....#.|#...#.#...|.....|.||.#.#|.#.|###..|..#.#
..|.##...........|..###.||.|.##.|....|.|.#|#.#.|#|
..|....|.|#|...#|#...|.#......#.#||...|.#|...#.|#.
..#.......|.||.....||.|....|#||..........#...|#...
.|..#....|#|||#..##||..#|.......|..|###..|.#...|.|
|..|.#|.#...#....|.....#.....#....#...|..|.|.#.|.#
....###.#....|.#..#...#...###.|.|.....#|...#.....|
..#....##.....##..|.#.||#.|.#|#||..|...#|..|.#....
|#..#.#|||#.|#..#........#......||...#.|..#|....#|
......#|...#.|...#...|.|...|#|#......#|.##.#|.|.#|
#||.#......#.##......#..||.##|.|.||..|#....#..#...
#.#...#.|.#|#||#.#......#....|##|.........##.#|...
.....###...#||....|####..#|||...#..#|.|....#|..#..
......|#..#.#.#..|.#|#||..||.|...#....##...|......
...#...|..#..##.||.#.#.....|.###.....##|#||..#..#|
.#..#||.#....||....|##..|||...|.||...#..##.#....#.
"""

let testInput = """
.#.#...|#.
.....#|##|
.|..|...#.
..|#.....#
#.#|||#|#|
...#.||...
.|....|...
||...#|.#|
|.||||..|.
...#.|..|.
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

enum State: Character, Equatable, Hashable {
    case open = "."
    case trees = "|"
    case lumberyard = "#"
}

let area = input
    .components(separatedBy: .newlines)
    .map { $0.map { State(rawValue: $0)! } }

func neighbours(area: [[State]], x: Int, y: Int) -> [State] {
    let xRange = max(0, x - 1) ... min(area[y].count - 1, x + 1)
    let yRange = max(0, y - 1) ... min(area.count - 1, y + 1)
    
    return yRange.flatMap { yValue in
        xRange.compactMap { xValue in
            if x == xValue && y == yValue {
                return nil
            } else {
                return area[yValue][xValue]
            }
        }
    }
}

func areaAfterOneMinute(_ area: [[State]]) -> [[State]] {
    var newArea = area
    for (y, row) in area.enumerated() {
        for (x, current) in row.enumerated() {
            let nearby = neighbours(area: area, x: x, y: y)
            switch current {
            case .open:
                if nearby.count(where: { $0 == .trees }) >= 3 {
                    newArea[y][x] = .trees
                }
            case .trees:
                if nearby.count(where: { $0 == .lumberyard }) >= 3 {
                    newArea[y][x] = .lumberyard
                }
            case .lumberyard:
                if nearby.count(where: { $0 == .lumberyard }) > 0 && nearby.count(where: { $0 == .trees }) > 0 {
                    break
                }
                newArea[y][x] = .open
            }
        }
    }
    return newArea
}

func resourceValue(for area: [[State]]) -> Int {
    let treeCount = area
        .map { $0.count(where: { $0 == .trees }) }
        .reduce(0, +)
    
    let lumberCount = area
        .map { $0.count(where: { $0 == .lumberyard }) }
        .reduce(0, +)
    
    return treeCount * lumberCount
}

func partOne() -> String {
    var newArea = area
    for _ in 1...10 {
        newArea = areaAfterOneMinute(newArea)
    }
    
    let result = resourceValue(for: newArea)
    return "\(result)"
}

func partTwo() -> String {
    let minuteCount = 1000000000
    var newArea = area
    
    var stateMap: [[[State]]: Int] = [:]
    
    for minute in 1...minuteCount {
        newArea = areaAfterOneMinute(newArea)
        
        if let previousMinute = stateMap[newArea] {
            let cycleTime = minute - previousMinute
            let numberOfCycles = (minuteCount - minute) / cycleTime
            let minuteAtFirstOccurence = minuteCount - ((numberOfCycles + 1) * cycleTime)
            newArea = stateMap.first(where: { $0.value == minuteAtFirstOccurence })!.key
            break
        } else {
            stateMap[newArea] = minute
        }
    }
    
    let result = resourceValue(for: newArea)
    return "\(result)"
}

print(partOne())
print(partTwo())
//: [Next](@next)
