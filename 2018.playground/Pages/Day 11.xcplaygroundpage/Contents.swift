//: [Previous](@previous)
import Foundation

let input = """
2187
"""

let serial = Int(input)!
let gridSize = 300

func powerLevel(x: Int, y: Int, serial: Int) -> Int {
    let rackId = x + 10
    let powerLevel = ((rackId * y) + serial) * rackId
    let actualLevel = ((powerLevel / 100) % 10) - 5
    return actualLevel
}

let grid = (1 ... gridSize).map { x in
    (1 ... gridSize).map { y in
        powerLevel(x: x, y: y, serial: serial)
    }
}

func partOne() -> String {
    var minX = -1
    var minY = -1
    var minLevel = Int.min
    
    for y in 0 ... gridSize - 3 {
        for x in 0 ... gridSize - 3 {
            let level = (x ..< x + 3).map { xVal -> Int in
                (y ..< y + 3).map { yVal -> Int in
                    grid[xVal][yVal]
                    }.reduce(0, +)
                }.reduce(0, +)
            
            if level > minLevel {
                minLevel = level
                minX = x
                minY = y
            }
        }
    }
    
    let result = "\(minX + 1),\(minY + 1)"
    return result
}

func partTwo() -> String {
    var minX = -1
    var minY = -1
    var minSize = -1
    var minLevel = Int.min
    
    for y in 0 ..< gridSize {
        for x in 0 ..< gridSize {
            var level = 0
            for size in 0 ..< (300 - max(x, y)) {
                for newX in x ... x + size {
                    level += grid[newX][y + size]
                }
                
                for newY in y ..< y + size {
                    level += grid[x + size][newY]
                }
                
                if level > minLevel {
                    minLevel = level
                    minX = x
                    minY = y
                    minSize = size
                }
            }
        }
    }
    
    let result = "\(minX + 1),\(minY + 1),\(minSize + 1)"
    return result
}

print(partOne())
print(partTwo())
//: [Next](@next)
