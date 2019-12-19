//: [Previous](@previous)

import Foundation

let input = """
109,424,203,1,21102,1,11,0,1105,1,282,21101,18,0,0,1106,0,259,2101,0,1,221,203,1,21102,1,31,0,1106,0,282,21101,0,38,0,1106,0,259,21002,23,1,2,22102,1,1,3,21101,0,1,1,21102,57,1,0,1106,0,303,2102,1,1,222,21002,221,1,3,21002,221,1,2,21101,0,259,1,21101,0,80,0,1105,1,225,21101,123,0,2,21101,91,0,0,1105,1,303,1201,1,0,223,20101,0,222,4,21101,259,0,3,21102,225,1,2,21101,0,225,1,21102,118,1,0,1105,1,225,21001,222,0,3,21102,58,1,2,21101,133,0,0,1105,1,303,21202,1,-1,1,22001,223,1,1,21102,1,148,0,1106,0,259,1201,1,0,223,20101,0,221,4,21002,222,1,3,21101,20,0,2,1001,132,-2,224,1002,224,2,224,1001,224,3,224,1002,132,-1,132,1,224,132,224,21001,224,1,1,21101,195,0,0,105,1,109,20207,1,223,2,20102,1,23,1,21101,-1,0,3,21102,214,1,0,1105,1,303,22101,1,1,1,204,1,99,0,0,0,0,109,5,2101,0,-4,249,22102,1,-3,1,22102,1,-2,2,22101,0,-1,3,21101,250,0,0,1105,1,225,21202,1,1,-4,109,-5,2105,1,0,109,3,22107,0,-2,-1,21202,-1,2,-1,21201,-1,-1,-1,22202,-1,-2,-2,109,-3,2106,0,0,109,3,21207,-2,0,-1,1206,-1,294,104,0,99,21201,-2,0,-2,109,-3,2106,0,0,109,5,22207,-3,-4,-1,1206,-1,346,22201,-4,-3,-4,21202,-3,-1,-1,22201,-4,-1,2,21202,2,-1,-1,22201,-4,-1,1,22102,1,-2,3,21102,1,343,0,1105,1,303,1105,1,415,22207,-2,-3,-1,1206,-1,387,22201,-3,-2,-3,21202,-2,-1,-1,22201,-3,-1,3,21202,3,-1,-1,22201,-3,-1,2,21201,-4,0,1,21102,1,384,0,1106,0,303,1105,1,415,21202,-4,-1,-4,22201,-4,-3,-4,22202,-3,-2,-2,22202,-2,-4,-4,22202,-3,-2,-3,21202,-4,-1,-2,22201,-3,-2,1,21201,1,0,-4,109,-5,2105,1,0
"""

extension Int {
    var decimalComponents: [Int] {
        String(self).map { $0.wholeNumberValue! }
    }
}

struct Intcode {

    enum Operation { case read, write }
    
    var numbers: [Int: Int]
    
    init(numbers: [Int: Int]) {
        self.numbers = numbers
    }
    
    private(set) var hasFinished = false
    
    private var currentPosition = 0
    private var relativeBase = 0
    
    mutating func execute(
        input: () -> (Int),
        output: (Int) -> ()
    ) {
        
        guard hasFinished == false else { return }
        
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
                numbers[pZero] = input()
                currentPosition += 2
                
            case 4:
                let pZero = parameter(atIndex: 0)
                output(pZero)
                currentPosition += 2
                
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
                
            case 99: hasFinished = true; return
            default: fatalError("Unexpected opCode")
            }
        }
    }
}

let initialNumbers = input
    .split(separator: ",")
    .map { Int($0)! }
    .enumerated()
    .reduce(into: [Int: Int]()) { dict, indexElementPair in
        dict[indexElementPair.offset] = indexElementPair.element
    }

func partOne() -> String {
    var count = 0
    
    for y in 0 ..< 50 {
        for x in 0 ..< 50 {
            var input = [x, y]
            var engine = Intcode(numbers: initialNumbers)
            engine.execute(
                input: { input.removeFirst() },
                output: { op in
                    if op == 1 { count += 1 }
                }
            )
        }
    }
    
    return count.description
}
    
func partTwo() -> String {
    let initial = (x: 500, y: 800)
    
    var board: [Int: ClosedRange<Int>] = [:]

    for y in initial.y... {
        for x in (board[y]?.lowerBound ?? initial.x)... {
            var input = [x, y]
            var engine = Intcode(numbers: initialNumbers)
            var op: Int!
            engine.execute(
                input: { input.removeFirst() },
                output: { op = $0 }
            )
            if op == 1 {
                if let existing = board[y] {
                    board[y] = existing.lowerBound ... x
                } else {
                    board[y] = x ... x
                }
            } else {
                if board[y] != nil {
                    break
                }
            }
            
            if x >= y * 2 && board[y] == nil { break }
        }

        if let hundredPrevRange = board[y - 99], let selfRange = board[y] {
            if hundredPrevRange.upperBound >= selfRange.lowerBound + 99 {
                return ((selfRange.lowerBound * 10_000) + (y - 99)).description
            }
        }
        board.removeValue(forKey: y - 99)
    }
    
    fatalError("This shouldn't happen")
}

print(partOne())
print(partTwo())

//: [Next](@next)
