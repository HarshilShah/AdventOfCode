//: [Previous](@previous)
import Foundation

let input = """
depth: 3558
target: 15,740
"""

extension String {
    var integers: [Int] {
        return self
            .split{ "-0123456789".contains($0) == false }
            .map { Int($0)! }
    }
}

struct Position: Equatable, Hashable {
    var x: Int
    var y: Int
}

enum Tool: Equatable, Hashable {
    case torch, climbingGear, neither
}

struct Tile {
    enum Kind {
        case rocky
        case wet
        case narrow
        case finish
    }
    
    let kind: Kind
    let erosionLevel: Int
    let riskLevel: Int
    
    var allowedTools: [Tool] {
        switch kind {
        case .rocky: return [.climbingGear, .torch]
        case .wet: return [.climbingGear, .neither]
        case .narrow: return [.torch, .neither]
        case .finish: return [.torch]
        }
    }
}

struct Runner {
    let position: Position
    let tool: Tool
    let timeStamp: Int
}

let components = input.components(separatedBy: .newlines)
let mouth = Position(x: 0, y: 0)
let target = Position(x: components[1].integers[0], y: components[1].integers[1])
let depth = components[0].integers[0]

var map: [[Tile]] = []

for y in mouth.y ... target.y * 2 {
    map.append([])
    
    for x in mouth.x ... target.x * 2 {
        let geologicalLevel: Int
        switch (x, y) {
        case (0, 0), (target.x, target.y): geologicalLevel = 0
        case (_, 0): geologicalLevel = x * 16807
        case (0, _): geologicalLevel = y * 48271
        default: geologicalLevel = map[y - 1][x].erosionLevel * map[y][x - 1].erosionLevel
        }
        
        let erosionLevel = (geologicalLevel + depth) % 20183
        let riskLevel = erosionLevel % 3
        
        var kind: Tile.Kind
        if (x == target.x && y == target.y) {
            kind = .finish
        } else {
            switch riskLevel {
            case 0: kind = .rocky
            case 1: kind = .wet
            case 2: kind = .narrow
            default: fatalError("This won't happen")
            }
        }
        
        map[y].append(Tile(kind: kind, erosionLevel: erosionLevel, riskLevel: riskLevel))
    }
}

func neighbours(at position: Position) -> [Position] {
    let x = position.x
    let y = position.y
    
    let xRange = max(0, x - 1) ... min(target.x * 2 - 1, x + 1)
    let yRange = max(0, y - 1) ... min(target.y * 2 - 1, y + 1)
    
    return yRange.flatMap { yValue in
        xRange.compactMap { xValue in
            if x == xValue && y == yValue {
                return nil
            } else if x == xValue || y == yValue {
                return Position(x: xValue, y: yValue)
            } else {
                return nil
            }
        }
    }
}

func partOne() -> String {
    let result = (0...target.y).map { y in
            (0...target.x).reduce(0) { partial, x in
                return partial + map[y][x].riskLevel
            }
        }.reduce(0, +)
    
    return "\(result)"
}

func partTwo() -> String {
    let startingPosition = Position(x: mouth.x, y: mouth.y)
    let startingTool = Tool.torch
    var runners = [Runner(position: startingPosition, tool: startingTool, timeStamp: 0)]

    var visitedPositions: [Position: [Tool: Int]] = [:]

    for time in 0... {
        var nextRunners: [Runner] = []
        
        for runner in runners {
            guard runner.timeStamp == time else {
                nextRunners.append(runner)
                continue
            }
            
            if runner.position == target {
                return "\(time)"
            }
            
            let currentlyAllowedTools = map[runner.position.y][runner.position.x].allowedTools
            let newPositions = neighbours(at: runner.position)
            
            for position in newPositions {
                let newTile = map[position.y][position.x]
                let allowedTools = newTile.allowedTools
                let canContinueWithTool = allowedTools.contains(runner.tool)
                
                let newTimeStamp = canContinueWithTool ? time + 1 : time + 8
                let newTool = canContinueWithTool ? runner.tool : allowedTools.first(where: { currentlyAllowedTools.contains($0) })
                
                if let tool = newTool {
                    if let existingTimeStampsForPosition = visitedPositions[position],
                        let existingTimeStamp = existingTimeStampsForPosition[tool],
                        existingTimeStamp <= newTimeStamp {
                        continue
                    }
                    
                    visitedPositions[position, default: [:]][tool] = newTimeStamp
                    let newRunner = Runner(position: position, tool: tool, timeStamp: newTimeStamp)
                    nextRunners.append(newRunner)
                }
            }
        }
        
        runners = nextRunners
    }
    
    fatalError("This should never happen")
}

print(partOne())
print(partTwo())
//: [Next](@next)
