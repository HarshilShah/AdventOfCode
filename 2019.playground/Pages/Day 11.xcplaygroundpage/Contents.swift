//: [Previous](@previous)

import Foundation

let input = """
3,8,1005,8,324,1106,0,11,0,0,0,104,1,104,0,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,0,10,4,10,1001,8,0,29,3,8,1002,8,-1,10,101,1,10,10,4,10,108,0,8,10,4,10,101,0,8,50,1,1106,9,10,1,102,15,10,2,1003,3,10,1,3,19,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,0,10,4,10,1001,8,0,89,1,1105,9,10,2,1103,1,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,1,10,4,10,1001,8,0,119,1006,0,26,1,109,7,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,108,1,8,10,4,10,1002,8,1,147,1006,0,75,1,1005,17,10,3,8,102,-1,8,10,101,1,10,10,4,10,108,0,8,10,4,10,102,1,8,176,3,8,102,-1,8,10,1001,10,1,10,4,10,1008,8,1,10,4,10,102,1,8,199,3,8,102,-1,8,10,1001,10,1,10,4,10,108,1,8,10,4,10,102,1,8,220,2,103,10,10,1,1,0,10,1,102,17,10,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,101,0,8,254,2,1001,10,10,1006,0,12,1,3,6,10,3,8,102,-1,8,10,101,1,10,10,4,10,1008,8,0,10,4,10,102,1,8,288,2,1106,9,10,2,1009,6,10,2,1101,18,10,2,103,8,10,101,1,9,9,1007,9,1045,10,1005,10,15,99,109,646,104,0,104,1,21101,838211318676,0,1,21102,341,1,0,1106,0,445,21101,0,838211051932,1,21101,0,352,0,1106,0,445,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21101,0,21704576195,1,21101,0,399,0,1106,0,445,21101,0,179356830951,1,21101,410,0,0,1105,1,445,3,10,104,0,104,0,3,10,104,0,104,0,21102,837897052948,1,1,21102,1,433,0,1106,0,445,21102,709052085092,1,1,21102,1,444,0,1105,1,445,99,109,2,21201,-1,0,1,21101,0,40,2,21102,476,1,3,21102,466,1,0,1105,1,509,109,-2,2105,1,0,0,1,0,0,1,109,2,3,10,204,-1,1001,471,472,487,4,0,1001,471,1,471,108,4,471,10,1006,10,503,1102,1,0,471,109,-2,2106,0,0,0,109,4,2102,1,-1,508,1207,-3,0,10,1006,10,526,21101,0,0,-3,21201,-3,0,1,21201,-2,0,2,21101,0,1,3,21101,545,0,0,1105,1,550,109,-4,2105,1,0,109,5,1207,-3,1,10,1006,10,573,2207,-4,-2,10,1006,10,573,21201,-4,0,-4,1105,1,641,22102,1,-4,1,21201,-3,-1,2,21202,-2,2,3,21101,592,0,0,1105,1,550,21201,1,0,-4,21102,1,1,-1,2207,-4,-2,10,1006,10,611,21101,0,0,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,633,21202,-1,1,1,21101,633,0,0,106,0,508,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2105,1,0
"""

extension Sequence {
    func min<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> T? {
        return self.min(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })?[keyPath: keyPath]
    }
    
    func max<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> T? {
        return self.max(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })?[keyPath: keyPath]
    }
    
    func range<T: Comparable>(_ keyPath: KeyPath<Element, T>) -> ClosedRange<T>? {
        guard let minimum = min(keyPath), let maximum = max(keyPath) else {
            return nil
        }
        
        return minimum...maximum
    }
}

enum Direction {
    case left, right, up, down
    
    mutating func turn(_ value: Int) {
        switch self {
        case .left: self = value == 0 ? .down : .up
        case .right: self = value == 0 ? .up : .down
        case .up:  self = value == 0 ? .left : .right
        case .down: self = value == 0 ? .right : .left
        }
    }
}

enum Colour: Int, CustomStringConvertible {
    case black = 0
    case white = 1
    
    var description: String {
        switch self {
        case .black: return "▪️"
        case .white: return "▫️"
        }
    }
}

struct Point: Equatable, Hashable {
    var x: Int
    var y: Int
    
    mutating func move(in direction: Direction) {
        switch direction {
        case .left: x -= 1
        case .right: x += 1
        case .up: y -= 1
        case .down: y += 1
        }
    }
}

extension Int {
    var decimalComponents: [Int] {
        String(self).map { $0.wholeNumberValue! }
    }
}

class Intcode {

    enum Operation { case read, write }
    
    var numbers: [Int: Int]
    
    var currentPosition = 0
    var relativeBase = 0
    var output: Int!
    
    var hasFinished = false
    
    init(numbers: [Int: Int]) {
        self.numbers = numbers
    }
    
    func execute(withInput input: Int) -> Int {
        
        guard hasFinished == false else { return output }
        
        while true {
            let opCodeComponents = numbers[currentPosition]!.decimalComponents
            let opCode = ((opCodeComponents.dropLast().last ?? 0) * 10) + opCodeComponents.last!
            
            func parameter(atIndex index: Int, operation: Operation = .read) -> Int {
                let explicitMode = opCodeComponents.dropLast(2 + index).last
                let rawPosition = currentPosition + 1 + index
                
                switch operation {
                case .read:
                    switch explicitMode {
                    case 0: return numbers[numbers[rawPosition]!, default: 0]
                    case 1: return numbers[rawPosition, default: 0]
                    case 2: return numbers[relativeBase + numbers[rawPosition]!, default: 0]
                    default: return numbers[numbers[rawPosition]!, default: 0]
                    }
                    
                case .write:
                    switch explicitMode {
                    case 0: return numbers[rawPosition]!
                    case 2: return relativeBase + numbers[rawPosition]!
                    default: return numbers[rawPosition]!
                    }
                }
            }
            
            switch opCode {
            case 1:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero + pOne
                currentPosition += 4
                
            case 2:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero * pOne
                currentPosition += 4
                
            case 3:
                let pZero = parameter(atIndex: 0, operation: .write)
                numbers[pZero] = input
                currentPosition += 2
                
            case 4:
                let pZero = parameter(atIndex: 0)
                output = pZero
                currentPosition += 2
                return output
                
            case 5:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                
                if pZero != 0 {
                    currentPosition = pOne
                } else {
                    currentPosition += 3
                }
                
            case 6:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                
                if pZero == 0 {
                    currentPosition = pOne
                } else {
                    currentPosition += 3
                }
                
            case 7:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero < pOne ? 1 : 0
                currentPosition += 4
                
            case 8:
                let pZero = parameter(atIndex: 0)
                let pOne = parameter(atIndex: 1)
                let pTwo = parameter(atIndex: 2, operation: .write)
                numbers[pTwo] = pZero == pOne ? 1 : 0
                currentPosition += 4
                
            case 9:
                let pZero = parameter(atIndex: 0)
                relativeBase += pZero
                currentPosition += 2
                
            case 99: hasFinished = true; return output
            default: fatalError("Unexpected opCode")
            }
        }
    }
}

let numbers = input
    .split(separator: ",")
    .map { Int($0)! }
    .enumerated()
    .reduce(into: [Int: Int]()) { dict, indexElementPair in
        dict[indexElementPair.offset] = indexElementPair.element
    }

func partOne() -> String {
    var grid: [Point: Colour] = [:]
    var position = Point(x: 0, y: 0)
    var direction = Direction.up
    
    let engine = Intcode(numbers: numbers)
    
    while !engine.hasFinished {
        let currentColour = grid[position, default: .black].rawValue
        let nextColour = engine.execute(withInput: currentColour) == 0 ? Colour.black : .white
        let nextDirection = engine.execute(withInput: currentColour)
        
        grid[position] = nextColour
        direction.turn(nextDirection)
        position.move(in: direction)
    }
    
    return grid.keys.count.description
}

func partTwo() -> String {
    var grid = [Point(x: 0, y: 0): Colour.white]
    var position = Point(x: 0, y: 0)
    var direction = Direction.up

    let engine = Intcode(numbers: numbers)

    while !engine.hasFinished {
        let currentColour = grid[position, default: .black].rawValue
        let nextColour = engine.execute(withInput: currentColour) == 0 ? Colour.black : .white
        let nextDirection = engine.execute(withInput: currentColour)
        
        grid[position] = nextColour
        direction.turn(nextDirection)
        position.move(in: direction)
    }
    
    let rows = grid.keys.range(\.y)!
    let columns = grid.keys.range(\.x)!
    
    rows.forEach { row in
        let colours = columns
            .map { column -> Colour in
                let point = Point(x: column, y: row)
                return grid[point, default: .black]
            }
        print(colours.map({ $0.description }).joined())
    }
    
    return ""
}

print(partOne())
print(partTwo())

//: [Next](@next)
